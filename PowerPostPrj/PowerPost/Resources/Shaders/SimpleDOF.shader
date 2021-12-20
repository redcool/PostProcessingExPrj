Shader "Hidden/PowerPost/SimpleDOF"
{
    Properties
    {
        // _MainTex ("Texture", 2D) = "white" {}
        _BlurSize("_BlurSize",float) = 1
        _Distance("_Distance",float) = 1
        _DepthRange("_DepthRange",float) = 0.5
        _Debug("_Debug",float) = 0
    }
    HLSLINCLUDE
        #include "PowerPostLib.hlsl"
        TEXTURE2D(_MainTex);SAMPLER(sampler_MainTex);
		float4 _MainTex_TexelSize;

        TEXTURE2D(_DepthRT);SAMPLER(sampler_DepthRT);
        float4 _DepthRT_TexelSize;

        TEXTURE2D(_BlurRT);SAMPLER(sampler_BlurRT);
        float4 _BlurRT_TexelSize;

    ENDHLSL
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            HLSLPROGRAM
            #pragma vertex VertDefault
            #pragma fragment frag
            CBUFFER_START(UnityPerMaterial)
            float _BlurSize;

            float _Distance;
            float _DepthRange; //清晰的范围
            float _Debug; //blur区域显示为 红色
            CBUFFER_END

            float4 frag (VaryingsDefault i) : SV_Target
            {
                float4 col = SAMPLE_TEXTURE2D(_MainTex,sampler_MainTex,i.texcoord);
                // float4 blurCol = SampleBox(_MainTex,sampler_MainTex,_DepthRT_TexelSize,i.texcoord,_BlurSize);
                float4 blurCol = SampleGaussian(_BlurRT,sampler_BlurRT,_BlurRT_TexelSize.xy * _BlurSize,i.texcoord);

                float depth = SAMPLE_TEXTURE2D(_DepthRT,sampler_DepthRT,i.texcoord).r;
                depth = Linear01Depth(depth,_ZBufferParams);

                float rate = abs(depth - _Distance)*5;
                rate = saturate(max(rate-_DepthRange,0)); // flat center point to center line
                rate = smoothstep(0.0001,0.1,rate);

                if(_Debug)
                    blurCol *= float4(1,0,0,1);
                return lerp(col,blurCol,rate);
            }
            ENDHLSL
        }
    }
}
