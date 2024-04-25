Shader "OMC/Metaball/FullScreen"
{
    Properties
    {
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Transparent"
            "Queue" = "Transparent"
        }
        LOD 100

        Pass
        {
            ZWrite On
            Blend SrcAlpha OneMinusSrcAlpha
            
            HLSLPROGRAM
            #pragma vertex MetaballVert
            #pragma fragment MetaballFrag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.core/Runtime/Utilities/Blit.hlsl"
            #include "../.././ShaderLibrary/FullscreenRaymarching.hlsl"
            

            struct MetaballVaryings
            {
                float4 positionCS : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 positionWS : TEXCOORD1;
                float3 viewDir : TEXCOORD2;
            };

            struct Output
            {
                half4 col : SV_Target;
                float depth : SV_Depth;
            };

            MetaballVaryings MetaballVert (const Attributes input)
            {
                MetaballVaryings output = (MetaballVaryings)0;
                #if Shader_API_GLES
                output.positionCS = input.positionOS;
                output.uv = input.uv
                #else
                output.positionCS = GetFullScreenTriangleVertexPosition(input.vertexID);
                output.uv = GetFullScreenTriangleTexCoord(input.vertexID);
                #endif
                
                output.uv = output.uv * _BlitScaleBias.xy + _BlitScaleBias.zw;
                output.positionWS = mul(unity_MatrixInvVP, output.positionCS);

                output.viewDir = GetFullScreenViewDir(output.uv);
                
                return output;
            }

            float sphereDistanceFunction(float4 sphere, float3 pos)
            {
                return length(sphere.xyz - pos) - sphere.w;
            }

            inline float getDepth(float3 pos)
            {
                const float4 vpPos = TransformWorldToHClip(pos);

                float z = vpPos.z / vpPos.w;

                #if defined(SHADER_API_GLCORE) || \
                    defined(SHADER_API_OPENGL) || \
                    defined(SHADER_API_GLES) || \
                    defined(SHADER_API_GLES3)
                return z * 0.5F + 0.5F;
                #else
                return z;
                #endif
            }

            #define MAX_SPHERE_COUNT 256
            TEXTURE2D(_CameraDepthTexture);
            float4 _Spheres[MAX_SPHERE_COUNT];
            half3 _Colors[MAX_SPHERE_COUNT];

            CBUFFER_START(UnityPerMaterial)
            int _SphereCount;
            CBUFFER_END

            float smoothMin(float x1, float x2, float k)
            {
                return -log(exp(-k * x1) + exp(-k * x2)) / k;
            }

            float getDistance(float3 pos)
            {
                float dist = 100000;

                for (int i = 0; i < _SphereCount; i++)
                {
                    dist = smoothMin(dist, sphereDistanceFunction(_Spheres[i], pos), 3);
                }

                return dist;
            }

            half3 getColor(const float3 posWS)
            {
                // half3 color = half3(0.0H, 0.0H, 0.0H);
                // float weight = 0.01F;
                //
                // for (int i = 0; i < _SphereCount;i++)
                // {
                //     const float distinctness = 0.7F;
                //     const float4 sphere = _Spheres[i];
                //     const float x = saturate((length(sphere.xyz - posWS) - sphere.w) * distinctness);
                //     const float t = 1.0F - x * x * (3.0F - 2.0F * x);
                //     color += t * _Colors[i];
                //     weight += t;
                // }
                //
                // color /= weight;
                // return color;

                return half3(1, 0, 0);
            }

            float3 getNormal(const float3 pos)
            {
                float d = 0.0001F;

                return normalize(float3(
                    getDistance(pos + float3(d, 0.0F, 0.0F)) - getDistance(pos + float3(-d, 0.0F, 0.0F)),
                    getDistance(pos + float3(0.0F, d, 0.0F)) - getDistance(pos + float3(0.0F, -d, 0.0F)),
                    getDistance(pos + float3(0.0F, 0.0F, d)) - getDistance(pos + float3(0.0F, 0.0F, -d))));
            }

            Output MetaballFrag (MetaballVaryings input)
            {
                Output output = (Output)0;

                output.col = SAMPLE_TEXTURE2D_X(_BlitTexture, sampler_LinearRepeat, input.uv);

                float depthTex = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, sampler_LinearRepeat, input.uv);

                float3 posWS = _WorldSpaceCameraPos;
                const float3 rayDir = input.viewDir;

                float3 lightDir = GetMainLight().direction;
                float3 halfDir = normalize(-rayDir + lightDir);

                [unroll]
                for (int i = 0; i < 30; i++)
                {
                    float dist = getDistance(posWS);

                    if (dist < 0.01F)
                    {
                        float3 normal = getNormal(posWS);
                        half3 col = getColor(posWS);

                        const float rimPower = 2;
                        const float rimRate = pow(1 - abs(dot(normal, GetViewForwardDir())), rimPower);
                        const half3 rimColor = half3(1.5F, 1.5F, 1.5F);

                        float highlight = lerp(1, 0, step(dot(halfDir, normal), 0.99));
                        col = saturate(lerp(col, rimColor, rimRate)  + highlight);
                        half alpha = saturate(lerp(0.2, 4, rimRate) + highlight);

                        float depth = getDepth(posWS);
                        
                        if (depth >= depthTex)
                        {
                            output.col = half4(col, alpha);
                            output.depth = getDepth(posWS);
                        }
                        break;
                    }

                    posWS += dist * rayDir;
                };

                return output;
            }
            ENDHLSL
        }
    }
}
