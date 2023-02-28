namespace PowerUtilities
{
    using PowerPost;
    using UnityEngine;
#if UNITY_EDITOR
    using UnityEditor;

    [CustomEditor(typeof(SimpleBloomSettingsControl))]
    public class SimpleBloomSettingsControlEditor : Editor
    {
        public override void OnInspectorGUI()
        {
            base.OnInspectorGUI();
            if (GUILayout.Button("Record Vars"))
            {
                var inst = target as SimpleBloomSettingsControl;
                inst.RecordVars();
            }
        }
    }
#endif
    
    [ExecuteInEditMode]
    public class SimpleBloomSettingsControl : BaseSettingsControl<SimpleBloomSettings>
    {
        // variables
        public float intensity;


        public override void UpdateVars()
        {
            if (!settings)
                return;
            //settings.baseLineMapIntensity.value = baseLineMapIntensity;
            settings.intensity.value = intensity;

        }

        public override void RecordVars()
        {
            base.RecordVars();
            if (!settings)
                return;
            
            //rotateRate = settings.rotateRate.value;
            intensity = settings.intensity.value;

        }
    }
}
