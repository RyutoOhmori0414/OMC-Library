#ifndef OMC_NOISE_LIBRARY_INCLUDED
#define OMC_NOISE_LIBRARY_INCLUDED

#include "Random.hlsl"

float BlockNoise(float2 seeds, float2 noiseScale)
{
    seeds *= noiseScale;
    return rand(floor(seeds));
}

float ValueNoise(float2 seeds, float2 noiseScale)
{
    seeds *= noiseScale;

    float2 i = floor(seeds);
    float2 f = frac(seeds);

    float2 i10 = i + float2(1.0F, 0.0F);
    float2 i01 = i + float2(0.0F, 1.0F);
    float2 i11 = i + float2(1.0F, 1.0F);

    float v00 = rand(i);
    float v10 = rand(i10);
    float v01 = rand(i01);
    float v11 = rand(i11);

    float2 p = smoothstep(0.0F, 1.0F, f);

    float v00v10 = lerp(v00, v10, p.x);
    float v01v11 = lerp(v01, v11, p.x);

    return lerp(v00v10, v01v11, p.y);
}

float PerlinNoise(float2 seeds, float2 noiseScale)
{
    seeds *= noiseScale;
    
    float2 i = floor(seeds);
    float2 f = frac(seeds);

    float2 i01 = i + float2(0.0F, 1.0F);
    float2 i10 = i + float2(1.0F, 0.0F);
    float2 i11 = i + float2(1.0F, 1.0F);
    
    float2 f01 = f - float2(0.0F, 1.0F);
    float2 f10 = f - float2(1.0F, 0.0F);
    float2 f11 = f - float2(1.0F, 1.0F);

    float2 g00 = normalize(rand2(i) * 2.0F - 1.0F);
    float2 g01 = normalize(rand2(i01) * 2.0F - 1.0F);
    float2 g10 = normalize(rand2(i10) * 2.0F - 1.0F);
    float2 g11 = normalize(rand2(i11) * 2.0F - 1.0F);

    float d00 = dot(g00, f);
    float d01 = dot(g01, f01);
    float d10 = dot(g10, f10);
    float d11 = dot(g11, f11);

    f = smoothstep(0, 1, f);

    float d00d01 = lerp(d00, d01, f.y);
    float d10d11 = lerp(d10, d11, f.y);

    return lerp(d00d01, d10d11, f.x) * 0.5F + 0.5F;
}

float PerlinNoise3D(float3 seeds, float3 noiseScale)
{
    seeds *= noiseScale;
    
    float3 i = floor(seeds);
    float3 f = frac(seeds);

    float3 i100 = i + float3(1.0F, 0.0F, 0.0F);
    float3 i010 = i + float3(0.0F, 1.0F, 0.0F);
    float3 i110 = i + float3(1.0F, 1.0F, 0.0F);
    float3 i001 = i + float3(0.0F, 0.0F, 1.0F);
    float3 i101 = i + float3(1.0F, 0.0F, 1.0F);
    float3 i011 = i + float3(0.0F, 1.0F, 1.0F);
    float3 i111 = i + float3(1.0F, 1.0F, 1.0F);

    float3 f100 = f - float3(1.0F, 0.0F, 0.0F);
    float3 f010 = f - float3(0.0F, 1.0F, 0.0F);
    float3 f110 = f - float3(1.0F, 1.0F, 0.0F);
    float3 f001 = f - float3(0.0F, 0.0F, 1.0F);
    float3 f101 = f - float3(1.0F, 0.0F, 1.0F);
    float3 f011 = f - float3(0.0F, 1.0F, 1.0F);
    float3 f111 = f - float3(1.0F, 1.0F, 1.0F);

    float3 g000 = normalize(rand3(i) * 2.0F - 1.0F);
    float3 g100 = normalize(rand3(i100) * 2.0F - 1.0F);
    float3 g010 = normalize(rand3(i010) * 2.0F - 1.0F);
    float3 g110 = normalize(rand3(i110) * 2.0F - 1.0F);
    float3 g001 = normalize(rand3(i001) * 2.0F - 1.0F);
    float3 g101 = normalize(rand3(i101) * 2.0F - 1.0F);
    float3 g011 = normalize(rand3(i011) * 2.0F - 1.0F);
    float3 g111 = normalize(rand3(i111) * 2.0F - 1.0F);

    float d000 = dot(g000, f);
    float d100 = dot(g100, f100);
    float d010 = dot(g010, f010);
    float d110 = dot(g110, f110);
    float d001 = dot(g001, f001);
    float d101 = dot(g101, f101);
    float d011 = dot(g011, f011);
    float d111 = dot(g111, f111);

    f = smoothstep(0.0F, 1.0F, f);

    float d000d100 = lerp(d000, d100, f.x);
    float d010d110 = lerp(d010, d110, f.x);
    float d001d101 = lerp(d001, d101, f.x);
    float d011d111 = lerp(d011, d111, f.x);

    float d000d100d010d110 = lerp(d000d100, d010d110, f.y);
    float d001d101d011d111 = lerp(d001d101, d011d111, f.y);

    return lerp(d000d100d010d110, d001d101d011d111, f.z) * 0.5F + 0.5F;
}

float DotGradient(float3 seeds, float3 f)
{
    switch (floor(lerp(0.0F, 12.0F, rand(seeds.xy + seeds.z))))
    {
    case 0: return f.x + f.y;
    case 1: return -f.x + f.y;
    case 2: return f.x - f.y;
    case 3: return -f.x - f.y;
    case 4: return f.x + f.z;
    case 5: return -f.x + f.z;
    case 6: return f.x - f.z;
    case 7: return -f.x - f.z;
    case 8: return f.y + f.z;
    case 9: return -f.y + f.z;
    case 10: return f.y - f.z;
    default: return -f.y - f.z;
    }
}

float ImprovedNoise(float3 seeds, float3 scale)
{
    seeds *= scale;
    
    float3 i = floor(seeds);
    float3 f = frac(seeds);

    float3 i100 = i + float3(1.0F, 0.0F, 0.0F);
    float3 i010 = i + float3(0.0F, 1.0F, 0.0F);
    float3 i110 = i + float3(1.0F, 1.0F, 0.0F);

    float3 i001 = i + float3(0.0F, 0.0F, 1.0F);
    float3 i101 = i + float3(1.0F, 0.0F, 1.0F);
    float3 i011 = i + float3(0.0F, 1.0F, 1.0F);
    float3 i111 = i + float3(1.0F, 1.0F, 1.0F);

    float3 f100 = f - float3(1.0F, 0.0F, 0.0F);
    float3 f010 = f - float3(0.0F, 1.0F, 0.0F);
    float3 f110 = f - float3(1.0F, 1.0F, 0.0F);

    float3 f001 = f - float3(0.0F, 0.0F, 1.0F);
    float3 f101 = f - float3(1.0F, 0.0F, 1.0F);
    float3 f011 = f - float3(0.0F, 1.0F, 1.0F);
    float3 f111 = f - float3(1.0F, 1.0F, 1.0F);

    float d000 = DotGradient(i, f);
    float d100 = DotGradient(i100, f100);
    float d010 = DotGradient(i010, f010);
    float d110 = DotGradient(i110, f110);

    float d001 = DotGradient(i001, f001);
    float d101 = DotGradient(i101, f101);
    float d011 = DotGradient(i011, f011);
    float d111 = DotGradient(i111, f111);

    f = f * f * f * (f * (f * 6.0F - 15.0F) + 10.0F);

    float d000d100 = lerp(d000, d100, f.x);
    float d010d110 = lerp(d010, d110, f.x);
    float d001d101 = lerp(d001, d101, f.x);
    float d011d111 = lerp(d011, d111, f.x);

    float d000d100d010d110 = lerp(d000d100, d010d110, f.y);
    float d001d101d011d111 = lerp(d001d101, d011d111, f.y);

    return lerp(d000d100d010d110, d001d101d011d111, f.z) * 0.5F + 0.5F;
}

/// \param octaves noise sample count(loop count)
float FractalBlockNoise(float2 seeds, int octaves)
{
    float output = 0.0F;
    float amplitude = 0.5F;

    [unroll]
    for (int i = 0; i < octaves; i++)
    {
        output += BlockNoise(seeds, 1.0F) * amplitude;

        seeds *= 2.0F;
        amplitude *= 0.5F;
    }

    return output;
}

inline float2 VoronoiRandVec(float2 seeds, float offset)
{
    float2x2 m = float2x2(12.27F, 47.63F, 98.31F, 78.32F);
    seeds = rand2(mul(seeds, m));
    return float2(sin(seeds.y * offset) * 0.5F + 0.5F, cos(seeds.x * offset) * 0.5F + 0.5F);
}

void Voronoi(float2 seeds, float angleOffset, float cellDensity, out float cellularNoise, out float voronoi)
{
    float2 i = floor(seeds * cellDensity);
    float2 f = frac(seeds * cellDensity);

    float3 res = float3(8.0F, 0.0F, 0.0F);

    [unroll]
    for (int y = -1; y <= 1; y++)
    {
        [unroll]
        for(int x = -1; x <= 1; x++)
        {
            float2 lattice = float2(x, y);

            float2 offset = VoronoiRandVec(lattice + i, angleOffset);
            float d = distance(lattice + offset, f);

            if (d < res.x)
            {
                res = float3(d, offset.x, offset.y);
                cellularNoise = res.x;
                voronoi = res.y;
            }
        }
    }
}

#endif