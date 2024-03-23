Shader "OMC/Lit"
{
    Properties
    {
        [OMCHeading(Test)]
        _MainTex ("Texture", 2D) = "white" {}
        
        [Enum(UnityEngine.Rendering.CullMode)] _Cull("Culling", Float) = 2.0
        [HideInInspector] _SrcBlend("Src Blend Mode", Float) = 1.0
        [HideInInspector] _DstBlend("Dst Blend Mode", Float) = 0.0
        [HideInInspector] _ScrBlendAlpha("Src Alpha Blend Mode", Float) = 1.0
        [HideInInspector] _DstBlendAlpha("Dst Alpha Blend Mode", Float) = 0.0
        [HideInInspector] _AlphaToMask("Alpha To Mask", Float) = 0.0
    }
    SubShader
    {
        Tags 
        {
            "RenderType" = "Transparent"
            "RenderPipeline" = "UniversalPipeline"
            "UniversalMaterialType" = "Lit"
            "IgnoreProjector" = "True"
            "Queue" = "Transparent"
        }
        
        Pass
        {
            Tags
            {
                "LightMode" = "UniversalForward"
            }
            
            Cull[_Cull]
            
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #define OMC_UNIVERSAL_FORWARD_PASS

            #include "Pass/LitUniversalForward.hlsl"
            
            ENDHLSL
        }
        Pass
        {
            Tags
            {
                "LightMode" = "ShadowCaster"
            }
            
            ZWrite On
            ZTest LEqual
            ColorMask 0
            Cull[_Cull]
        }
    }
    
    CustomEditor "OMC.ShaderLibrary.Editor.OMCShaderGUI"
}
