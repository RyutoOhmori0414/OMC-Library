#ifndef OMC_3D_DISNEY_BRDF_INCLUDED
#define OMC_3D_DISNEY_BRDF_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

struct DisneyBRDFData
{
    half4 baseColor;
    float subsurface;
    float metallic;
    float specular;
    float specularTint;
    float roughness;
    float anisotropic;
    float sheen;
    float sheenTint;
    float clearCoat;
    float clearCoatTint;
};

inline float SchlickFresnel(float cosTheta)
{
    return pow(saturate(1 - cosTheta), 5.0);
}

inline float D_GTR1(float NdotH, float a)
{
    float a2 = a * a;
    float tmp = 1 + (a2 - 1) * NdotH * NdotH;
    return (a2 - 1) / PI * log(a2) * tmp;
}

inline float D_GTR2aniso(float NdotH, float HdotX, float HdotY, float ax, float ay)
{
    float tmp = HdotX * HdotX / ax * ax + HdotY * HdotY / ay * ay + NdotH * NdotH;
    return 1 / PI * ax * ay * tmp * tmp;
}

inline float G_GGX(float NdotV, float)

#endif