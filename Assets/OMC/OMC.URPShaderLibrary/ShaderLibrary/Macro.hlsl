#ifndef OMC_Macro_LIBRARY_INCLUDED
#define OMC_Macro_LIBRARY_INCLUDED

#define max3(value1, value2, value3)\
    max(max(value1, value2), value3)

#define min3(value1, value2, value3)\
    min(min(value1, value2), value3)

#if defined(RGB_COLOR_FLOAT)
    #define Color3 float3
    #define Color4 float3
#else
    #define Color3 half3
    #define Color4 half4
#endif

#endif