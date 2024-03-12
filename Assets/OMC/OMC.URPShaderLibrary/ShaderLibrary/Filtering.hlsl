#ifndef OMC_FILTERING_LIBRARY_INCLUDED
#define OMC_FILTERING_LIBRARY_INCLUDED

#include "Kernel.hlsl"

half4 PrewittFilter(KernelColor3x3 kernel)
{
    return saturate(kernel.Convolution(half3x3(-1.0H, -1.0H, -1.0H, 0.0H, 0.0H, 0.0H, 1.0H, 1.0H, 1.0H)) +
        kernel.Convolution(half3x3(-1.0H, 0.0H, 1.0H, -1.0H, 0.0H, 1.0H, -1.0H, 0.0H, 1.0H)));
}

half4 SobelFilter(KernelColor3x3 kernel)
{
    return saturate(kernel.Convolution(half3x3(-1.0H, -2.0H, -1.0H, 0.0H, 0.0H, 0.0H, 1.0H, 2.0H, 1.0H)) +
        kernel.Convolution(half3x3(-1.0H, 0.0H, 1.0H, -2.0H, 0.0H, 2.0H, -1.0H, 0.0H, 1.0H)));
}

#endif