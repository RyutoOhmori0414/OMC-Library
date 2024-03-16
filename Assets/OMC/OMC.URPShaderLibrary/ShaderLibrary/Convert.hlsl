#ifndef OMC_CONVERT_LIBRARY_INCLUDED
#define OMC_CONVERT_LIBRARY_INCLUDED

#include "Macro.hlsl"

inline half RGB2Luminance(half3 rgb)
{
    return (rgb.r * 0.299H + rgb.g * 0.587H + rgb.b * 0.114H);
}

inline half3 RGB2HSV(half3 rgb)
{
    half4 K = half4(0.0H, -1.0H / 3.0H, 2.0H / 3.0H, -1.0H);
    half4 P = lerp(half4(rgb.bg, K.wz), half4(rgb.gb, K.xy), step(rgb.b, rgb.g));
    half4 Q = lerp(half4(P.xyw, rgb.r), half4(rgb.r, P.yzx), step(P.x, rgb.r));
    half D = Q.x - min(Q.w, Q.y);
    half E = 1e-10H;

    return half3(abs(Q.z + (Q.w - Q.y) / (6.0H * D + E)), D / (Q.x + E), Q.x);
}

inline half3 HSV2RGB(half3 hsv)
{
    half4 K = half4(1.0H, 2.0H / 3.0H, 1.0H / 3.0H, 3.0H);
    half3 P = abs(frac(hsv.xxx + K.xyz) * 6.0H - K.www);

    return hsv.z * lerp(K.xxx, saturate(P - K.xxx), hsv.y);
}

#endif