﻿namespace PowerPost
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using UnityEngine;
    using UnityEngine.Rendering;

    [Serializable, VolumeComponentMenu("Custom/Glitch")]
    public class GlitchSettings : BasePostExSettings
    {
         public ClampedFloatParameter scanlineJitter = new ClampedFloatParameter(0,0,1);
         public ClampedFloatParameter snowFlakeAmplitude = new ClampedFloatParameter(0,0,1);
         public ClampedFloatParameter verticalJump = new ClampedFloatParameter(0,0,1);
         public ClampedFloatParameter horizontalShake = new ClampedFloatParameter(0,0,1);
         public ClampedFloatParameter colorDrift = new ClampedFloatParameter(0,0,1);

        public LayerMaskParameter layer = new LayerMaskParameter(-1);

        public override BasePostExPass CreateNewInstance()
        {
            return new GlitchPass();
        }

        public override bool IsActive()
        {
            return true;
        }

    }
}
