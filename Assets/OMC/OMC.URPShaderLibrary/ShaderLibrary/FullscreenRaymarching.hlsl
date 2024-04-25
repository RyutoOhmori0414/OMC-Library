#ifndef OMC_FULLSCREEN_RAY_MARCHING_LIBRARY_INCLUDED
#define OMC_FULLSCREEN_RAY_MARCHING_LIBRARY_INCLUDED

#define CAMERA_CORNER_COUNT 4
float3 _CameraMonoFrustumCornerDirWS[CAMERA_CORNER_COUNT];
#if defined(USE_VR_ON)
float3 _CameraLeftFrustumCornerDirWS[CAMERA_CORNER_COUNT];
float3 _CameraRightFrustumCornerDirWS[CAMERA_CORNER_COUNT];
#endif

inline float3 GetFullScreenViewDir(float2 uv)
{
    return  lerp(
        lerp(_CameraMonoFrustumCornerDirWS[0], _CameraMonoFrustumCornerDirWS[3], uv.x),
        lerp(_CameraMonoFrustumCornerDirWS[1], _CameraMonoFrustumCornerDirWS[2], uv.x),
        uv.y);
}

#endif