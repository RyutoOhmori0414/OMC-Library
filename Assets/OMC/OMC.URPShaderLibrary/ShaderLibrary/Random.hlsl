#ifndef OMC_RANDOM_LIBRARY_INCLUDED
#define OMC_RANDOM_LIBRARY_INCLUDED

/// \return randomValue(float)
inline float rand(float2 seeds)
{
    return frac(sin(dot(seeds, float2(12.9898F, 78.233F))) * 43758.5453F);
}

/// \return randomValue(float2)
inline float2 rand2(float2 seeds)
{
    seeds = float2(dot(seeds, float2(127.1F, 311.7F)),
                   dot(seeds, float2(269.5F, 183.3F)));

    return frac(sin(seeds) * 43758.5433123F);
}

/// \return randomValue(float3)
inline float3 rand3(float3 seeds)
{
    seeds = float3(dot(seeds, float3(127.1F, 311.7F, 542.3F)),
                   dot(seeds, float3(269.5F, 185.3F, 461.7F)),
                   dot(seeds, float3(732.1F, 845.3F, 231.7F)));

    return frac(sin(seeds) * 43758.5433123F);
}

#endif