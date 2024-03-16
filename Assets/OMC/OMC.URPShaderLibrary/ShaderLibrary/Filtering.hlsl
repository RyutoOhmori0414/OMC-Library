#ifndef OMC_FILTERING_LIBRARY_INCLUDED
#define OMC_FILTERING_LIBRARY_INCLUDED

#include "Kernel.hlsl"

half4 PrewittFilter(KernelColor3x3 kernel)
{
    return saturate(kernel.Convolution(float3x3(-1.0F, -1.0F, -1.0F, 0.0F, 0.0F, 0.0F, 1.0F, 1.0F, 1.0F)) +
        kernel.Convolution(float3x3(-1.0F, 0.0F, 1.0F, -1.0F, 0.0F, 1.0F, -1.0F, 0.0F, 1.0F)));
}

half4 SobelFilter(KernelColor3x3 kernel)
{
    return saturate(kernel.Convolution(float3x3(-1.0F, -2.0F, -1.0F, 0.0F, 0.0F, 0.0F, 1.0F, 2.0F, 1.0F)) +
        kernel.Convolution(float3x3(-1.0F, 0.0F, 1.0F, -2.0F, 0.0F, 2.0F, -1.0F, 0.0F, 1.0F)));
}

half4 LaplacianFilter4(KernelColor3x3 kernel)
{
    return kernel.Convolution(float3x3(0, 1, 0, 1, -4, 1, 0, 1, 0));
}

half4 LaplacianFilter8(KernelColor3x3 kernel)
{
    return kernel.Convolution(float3x3(1, 1, 1, 1, -8, 1, 1, 1, 1));
}

half4 AveragingFilter(KernelColor3x3 kernel)
{
    const float coefficient = 1.0F / 9.0F; 
    
    return kernel.Convolution(float3x3(coefficient, coefficient, coefficient,
                                                coefficient, coefficient, coefficient,
                                                coefficient, coefficient, coefficient));
}

half4 GaussianFilter(KernelColor3x3 kernel)
{
    return kernel.Convolution(float3x3(0.0625F, 0.125F, 0.0625F, 0.125F, 0.25F, 0.125F, 0.0625F, 0.125F, 0.0625F));
}

#endif