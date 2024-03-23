#ifndef OMC_3D_HEADER_INCLUDED
#define OMC_3D_HEADER_INCLUDED

// Attributes struct field define
#define OMC_ATTR_POSITION_OS_DEFINED

#if defined(OMC_UNIVERSAL_FORWARD_PASS)
    #define OMC_ATTR_TEX_COORD_DEFINED
#endif

#if defined(OMC_UNIVERSAL_FORWARD_PASS)
    #define OMC_ATTR_NORMAL_OS_DEFINED
#endif

#if defined(OMC_UNIVERSAL_FORWARD_PASS)
    #define OMC_ATTR_TANGENT_OS_DEFINED
#endif

#if defined(None)
    #define OMC_ATTR_COLOR_DEFINED
#endif

// Varyings struct field define
#define OMC_VARY_POSITION_CS_DEFINED

#if defined(OMC_UNIVERSAL_FORWARD_PASS)
    #define OMC_VARY_POSITION_WS
#endif 

#if defined(OMC_ATTR_TEX_COORD_DEFINED)
    #define OMC_VARY_TEX_COORD_DEFINED
#endif

#if defined(OMC_ATTR_NORMAL_OS_DEFINED)
    #define OMC_VARY_NORMAL_WS_DEFINED
#endif

#if defined(OMC_ATTR_TANGENT_OS_DEFINED)
    #define OMC_VARY_TANGENT_WS_DEFINED
#endif

#if defined(OMC_ATTR_NORMAL_OS_DEFINED) && defined(OMC_ATTR_TANGENT_OS_DEFINED)
    #define OMC_VARY_BITANGENT_WS_DEFINED
#endif

#if defined(OMC_ATTR_COLOR_DEFINED)
    #define OMC_VARY_COLOR_DEFINED
#endif

struct Attributes
{
    #if defined(OMC_ATTR_POSITION_OS_DEFINED)
    float4 positionOS : POSITION;
    #endif
    #if defined(OMC_ATTR_TEX_COORD_DEFINED)
    float2 texCoord : TEXCOORD0;
    #endif
    #if defined(OMC_ATTR_NORMAL_OS_DEFINED)
    float3 normalOS : NORMAL;
    #endif
    #if defined(OMC_ATTR_TANGENT_OS_DEFINED)
    float4 tangentOS : TANGENT;
    #endif
    #if defined(OMC_ATTR_COLOR_DEFINED)
    float4 color : COLOR;
    #endif
};

struct Varyings
{
    #if defined(OMC_VARY_POSITION_CS_DEFINED)
    float4 positionCS : SV_POSITION;
    #endif
    #if defined(OMC_VARY_TEX_COORD_DEFINED)
    float2 texCoord : TEXCOORD0;
    #endif
    #if defined(OMC_VARY_POSITION_WS)
    float3 positionWS : TEXCOORD1;
    #endif
    #if defined(OMC_VARY_NORMAL_WS_DEFINED)
    float3 normalWS : NORMAL;
    #endif
    #if defined(OMC_VARY_TANGENT_WS_DEFINED)
    float3 tangentWS : TANGENT;
    #endif
    #if defined(OMC_VARY_BITANGENT_WS_DEFINED)
    float3 bitangentWS : TEXCOORD2;
    #endif
    #if defined(OMC_VARY_COLOR_DEFINED)
    float4 color : COLOR;
    #endif
};

// uniform
TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);

CBUFFER_START(UnityPerMaterial)
float4 _MainTex_ST;
CBUFFER_END

#endif