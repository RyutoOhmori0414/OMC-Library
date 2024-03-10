#ifndef OMC_RANDOM_LIBRARY_INCLUDED
#define OMC_RANDOM_LIBRARY_INCLUDED

/// \return randomValue(float)
inline float rand(float2 seeds)
{
    return frac(sin(dot(seeds, float2(12.9898, 78.233))) * 43758.5453);
}

/// \return randomValue(float2)
inline float2 rand2(float2 seeds)
{
    seeds = float2(dot(seeds, float2(127.1, 311.7)),
                   dot(seeds, float2(269.5, 183.3)));

    return frac(sin(seeds) * 43758.5433123);
}

/// \return randomValue(float3)
inline float3 rand3(float3 seeds)
{
    seeds = float3(dot(seeds, float3(127.1, 311.7, 542.3)),
                   dot(seeds, float3(269.5, 185.3, 461.7)),
                   dot(seeds, float3(732.1, 845.3, 231.7)));

    return frac(sin(seeds) * 43758.5433123);
}

#endif