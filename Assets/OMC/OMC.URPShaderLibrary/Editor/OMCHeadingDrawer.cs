using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace OMC.ShaderLibrary.Editor
{
    public class OMCHeadingDrawer : MaterialPropertyDrawer
    {
        private readonly string _headingLabel;

        public OMCHeadingDrawer(string headingLabel)
        {
            _headingLabel = headingLabel;
        }
        
        public override void Apply(MaterialProperty prop)
        {
        }

        public override void OnGUI(Rect position, MaterialProperty prop, GUIContent label, MaterialEditor editor)
        {
        }
    }   
}
