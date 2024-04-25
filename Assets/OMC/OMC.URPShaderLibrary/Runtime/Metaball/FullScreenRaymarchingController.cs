using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace OMC.ShaderLibrary.Runtime
{
    [ExecuteAlways, RequireComponent(typeof(Camera))]
    public class FullScreenRaymarchingController : MonoBehaviour
    {
        [SerializeField] private Material _fullscreenRaymarchingMaterial = default;
        private readonly int _cameraMonoFrustumCornerDirWSPropertyID = Shader.PropertyToID("_CameraMonoFrustumCornerDirWS"); 

        private Camera _camara;
    
        // Start is called before the first frame update
        void Start()
        {
            _camara = GetComponent<Camera>();
        }

        // Update is called once per frame
        void Update()
        {
            var frustumDir = new Vector3[4];
            var testColArray = new []{ Color.red, Color.green, Color.blue, Color.yellow };
        
            _camara.CalculateFrustumCorners(
                new Rect(0, 0, 1, 1),
                _camara.farClipPlane,
                Camera.MonoOrStereoscopicEye.Mono,
                frustumDir
            );

            var frustumDir4 = new Vector4[4];
        
            for (int i = 0; i < 4; i++)
            {
                var tempDir = _camara.transform.TransformVector(frustumDir[i]);
                Debug.DrawRay(_camara.transform.position, tempDir, testColArray[i]);
                tempDir = Vector3.Normalize(tempDir);
                frustumDir4[i] = new Vector4(tempDir.x, tempDir.y, tempDir.z, 0.0F);
            }

            if (_fullscreenRaymarchingMaterial)
            {
                _fullscreenRaymarchingMaterial.SetVectorArray(_cameraMonoFrustumCornerDirWSPropertyID, frustumDir4);
            }
        }
    }   
}