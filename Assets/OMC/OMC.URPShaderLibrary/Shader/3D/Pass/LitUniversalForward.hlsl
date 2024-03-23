#ifndef OMC_3D_LIT_UNIVERSAL_FORWARD_PASS_INCLUDED
#define OMC_3D_LIT_UNIVERSAL_FORWARD_PASS_INCLUDED

#include "Common/Include.hlsl"

Varyings vert(Attributes input)
{
    const VertexPositionInputs positionInput = GetVertexPositionInputs(input.positionOS.xyz);
    const VertexNormalInputs normalInput = GetVertexNormalInputs(input.normalOS, input.tangentOS);

    Varyings output = (Varyings)0;

    output.positionCS = positionInput.positionCS;
    output.positionWS = positionInput.positionWS;
    output.texCoord = TRANSFORM_TEX(input.texCoord, _MainTex);
    output.normalWS = normalInput.normalWS;
    output.tangentWS = normalInput.tangentWS;
    output.bitangentWS = normalInput.bitangentWS;

    return output;
}

half4 frag(Varyings input) : SV_Target
{
    half4 col = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.texCoord);

    return col;
}

#endif