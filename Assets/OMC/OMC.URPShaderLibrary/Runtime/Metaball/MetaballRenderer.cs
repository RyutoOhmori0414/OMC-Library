using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Random = UnityEngine.Random;

#if UNITY_EDITOR
using UnityEditor;
#endif

namespace OMC.ShaderLibrary.Runtime
{
    [ExecuteAlways]
    public class MetaballRenderer : MonoBehaviour
    {
        [SerializeField] private Material _slimeMaterial = default;
    
        private const int MAX_SPHERE_COUNT = 256;
        private readonly Vector4[] _spheres = new Vector4[MAX_SPHERE_COUNT];
        private readonly int _spheresPropertyID = Shader.PropertyToID("_Spheres");
        private readonly int _sphereCountPropertyId = Shader.PropertyToID("_SphereCount");
        private readonly int _colorPropertyId = Shader.PropertyToID("_Colors");
        
        private SphereCollider[] _colliders;
        private Vector4[] _colors = new Vector4[MAX_SPHERE_COUNT];
    
        private void Start()
        {
            if (!_slimeMaterial) return;
            InitCollier();
            InitColor();
        }
    
        private void Update()
        {
    #if UNITY_EDITOR
            if (!EditorApplication.isPlaying)
            {
                InitCollier();
            }
    #endif
            UpdateVectorArray();
        }
    
        private void InitCollier()
        {
            _colliders = GetComponentsInChildren<SphereCollider>();
            
            _slimeMaterial.SetInteger(_sphereCountPropertyId, _colliders.Length);
        }
    
        private void InitColor()
        {
            for (int i = 0; i < _colors.Length; i++)
            {
                _colors[i] = Random.ColorHSV(0F, 1F, 1F, 1F, 1F, 1F);
            }
            
            _slimeMaterial.SetVectorArray(_colorPropertyId, _colors);
        }
    
        private void UpdateVectorArray()
        {
            if (!_slimeMaterial) return;
            
            for (int i = 0; i < _colliders.Length; i++)
            {
                var target = _colliders[i];
                var targetTransform = target.transform;
                var targetPosition = targetTransform.position;
                var radius = targetTransform.lossyScale.x * target.radius;
    
                _spheres[i] = new Vector4(
                    targetPosition.x, 
                    targetPosition.y, 
                    targetPosition.z, 
                    radius);
            }
            
            _slimeMaterial.SetVectorArray(_spheresPropertyID, _spheres);
        }
    }   
}