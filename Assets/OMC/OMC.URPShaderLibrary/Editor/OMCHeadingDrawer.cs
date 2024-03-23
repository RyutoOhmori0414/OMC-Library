using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace OMC.ShaderLibrary.Editor
{
    public class OMCHeadingDrawer : MaterialPropertyDrawer
    {
        private readonly string _headingLabel;

        private bool _isInit = false;

        public OMCHeadingDrawer(string headingLabel)
        {
            _headingLabel = headingLabel;
        }

        public override void Apply(MaterialProperty prop)
        {
            Debug.Log(_headingLabel);
            
            base.Apply(prop);
        }
    }   
}
