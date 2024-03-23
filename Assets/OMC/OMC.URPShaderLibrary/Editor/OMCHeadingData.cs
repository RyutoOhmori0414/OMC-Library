using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace OMC.ShaderLibrary.Editor
{
    internal static class OMCHeadingData
    {
        private static Dictionary<Material, Dictionary<string, List<MaterialProperty>>> _headingPropertyCache;

        static OMCHeadingData()
        {
            _headingPropertyCache = new();
        }

        public static void AddCache(Material targetMat, string headingLabel, MaterialProperty property)
        {
            if (!_headingPropertyCache.TryGetValue(targetMat, out var labelDic))
            {
                labelDic = new();
                
                _headingPropertyCache.Add(targetMat, labelDic);
            }

            if (!labelDic.TryGetValue(headingLabel, out var propDic))
            {
                propDic = new();
                
                labelDic.Add(headingLabel, propDic);
            }
            
            propDic.Add(property);
        }

        public static void ClearCache(Material target)
        {
            _headingPropertyCache[target].Clear();
        }
    }   
}
