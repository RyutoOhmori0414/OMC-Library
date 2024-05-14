using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace OMC.ShaderLibrary.Editor
{
    public class OMCHeadingPropertyBase : MaterialPropertyDrawer
    {
        private readonly string _headingLabel;

        private bool _isInit = false;

        public OMCHeadingPropertyBase(string headingLabel)
        {
            _headingLabel = headingLabel;
        }

        public override void Apply(MaterialProperty prop)
        {
            var mat = prop.targets[0] as Material;

            if (!mat)
            {
                Debug.LogAssertion($"prop.target[0] is null");
            }
            
            OMCHeadingData.AddCache(mat, _headingLabel, prop);
        }
    }   
}
