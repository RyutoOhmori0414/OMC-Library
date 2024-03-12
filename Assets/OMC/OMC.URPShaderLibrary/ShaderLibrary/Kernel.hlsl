#ifndef OMC_KERNEL_LIBRARY_INCLUDED
#define OMC_KERNEL_LIBRARY_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

struct KernelColor3x3
{
    half4 col00;
    half4 col10;
    half4 col20;

    half4 col01;
    half4 col11;
    half4 col21;

    half4 col02;
    half4 col12;
    half4 col22;

    half4 Convolution(float3x3 coefficient)
    {
        return abs(col00 * coefficient[0][0] + col10 * coefficient[1][0] + col20 * coefficient[2][0] +
            col01 * coefficient[0][1] + col11 * coefficient[1][1] + col21 * coefficient[2][1] +
            col02 * coefficient[0][2] + col12 * coefficient[1][2] + col22 * coefficient[2][2]);
    }
};

KernelColor3x3 SampleTexture2D3x3(Texture2D sampleTexture, SamplerState textureSampler, float2 texCoord, float2 texelSize)
{
    KernelColor3x3 output;
    
    output.col00 = SAMPLE_TEXTURE2D(sampleTexture, textureSampler, texCoord + float2(-texelSize.x, -texelSize.y));
    output.col10 = SAMPLE_TEXTURE2D(sampleTexture, textureSampler, texCoord + float2(0, -texelSize.y));
    output.col20 = SAMPLE_TEXTURE2D(sampleTexture, textureSampler, texCoord + float2(texelSize.x, -texelSize.y));
    output.col01 = SAMPLE_TEXTURE2D(sampleTexture, textureSampler, texCoord + float2(-texelSize.x, 0));
    output.col11 = SAMPLE_TEXTURE2D(sampleTexture, textureSampler, texCoord);
    output.col21 = SAMPLE_TEXTURE2D(sampleTexture, textureSampler, texCoord + float2(texelSize.x, 0));
    output.col02 = SAMPLE_TEXTURE2D(sampleTexture, textureSampler, texCoord + float2(-texelSize.x, texelSize.y));
    output.col12 = SAMPLE_TEXTURE2D(sampleTexture, textureSampler, texCoord + float2(0, texelSize.y));
    output.col22 = SAMPLE_TEXTURE2D(sampleTexture, textureSampler, texCoord + float2(texelSize.x, texelSize.y));
    

    return output;
}

#define SAMPLE_TEXTURE2D_3x3(textureName, samplerName, texCoord)\
    SampleTexture2D3x3(textureName, samplerName, texCoord, textureName##_TexelSize.xy)

#endif