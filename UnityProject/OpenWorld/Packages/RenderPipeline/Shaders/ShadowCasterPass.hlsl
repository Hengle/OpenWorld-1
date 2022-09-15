﻿#ifndef RENDERPIPELINE_SHADERCASTER_INCLUDED
#define RENDERPIPELINE_SHADERCASTER_INCLUDED

#include "Packages/RenderPipeline/ShaderLibrary/Core.hlsl"

struct Attributes
{
    float4 positionOS: POSITION;
    float3 normalOS: NORMAL;
    float2 uv: TEXCOORD0;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct Varyings
{
    float2 uv: TEXCOORD0;
    float4 positionCS: SV_POSITION;
};

float4 GetShadowPositionHClip(Attributes input)
{
    float3 positionWS = TransformObjectToWorld(input.positionOS.xyz);
    // float3 normalWS = TransformObjectToWorldNormal(input.normalOS);

    // #if _CASTING_PUNCTUAL_LIGHT_SHADOW
    //     float3 lightDirectionWS = normalize(_LightPosition - positionWS);
    // #else
    //     float3 lightDirectionWS = _LightDirection;
    // #endif

    // float4 positionCS = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, lightDirectionWS));

    // #if UNITY_REVERSED_Z
    //     positionCS.z = min(positionCS.z, UNITY_NEAR_CLIP_VALUE);
    // #else
    //     positionCS.z = max(positionCS.z, UNITY_NEAR_CLIP_VALUE);
    // #endif
    float4 positionCS = TransformWorldToHClip(positionWS);
    return positionCS;
}


Varyings ShadowPassVertex(Attributes input)
{
    Varyings output;
    UNITY_SETUP_INSTANCE_ID(input);

    output.positionCS = GetShadowPositionHClip(input);
    output.uv = input.uv;
    return output;
}


float4 ShadowPassFragment(Varyings input): SV_Target
{
    return 0;
}

#endif