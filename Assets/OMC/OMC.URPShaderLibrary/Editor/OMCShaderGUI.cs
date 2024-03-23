using UnityEditor;
using UnityEngine;

namespace OMC.ShaderLibrary.Editor
{
    public class OMCShaderGUI : ShaderGUI
    {
        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            var material = materialEditor.target as Material;

            if (!material) return;

            base.OnGUI(materialEditor, properties);
        }

        public override void OnClosed(Material material)
        {
            Debug.Log("Closed");
            
            base.OnClosed(material);
        }
    }   
}
