Shader "Example/ScreenNightVision" {

	// Allows to simulate a night vision effect including Green Tone and Digital Imagery effect (scanlines and noise)
	// This shader must be used together with the NightVisionRenderImage script applied to the Camera

	Properties
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_VignetteTex ("Vignette Texture", 2D) = "white" {}
		_VignetteAmount ("Vignette Amount", Range(0,1)) = 1
		_ScanlinesTex ("Scanlines Texture", 2D) = "white" {}
		_ScanlinesYScale ("Scanlines Y Scale", Range(1,5)) = 1
		_ScanlinesIntensity ("Scanlines Intensity", Range(0,5)) = 1
		_ScanlinesEffectAmount ("Scanlines Effect Amount", Range(0,1)) = 1
		_NoiseTex ("Noise Texture", 2D) = "white" {}
		_NoiseXScale ("Noise X Scale", Range(1,5)) = 1
		_NoiseYScale ("Noise Y Scale", Range(1,5)) = 1
		_NoiseXSpeed ("Noise X Speed", Range(1,5)) = 1
		_NoiseYSpeed ("Noise Y Speed", Range(1,5)) = 1
		_NoiseEffectAmount ("Noise Effect Amount", Range(0,1)) = 1
		_GreenColor ("Green Color", Color) = (1,1,1,1)
		_EffectAmount ("Effect Amount", Range(0,1)) = 1
		_Distortion ("Lens Distortion", Float) = 0.2
		_Scale ("Lens Distortion Scale", Float) = 1
		_RandomValue("Random Value", Float) = 1
	}

 	SubShader {

		Pass
		{
			CGPROGRAM
			
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex, _VignetteTex, _ScanlinesTex, _NoiseTex;
			uniform fixed3 _GreenColor;
			uniform fixed _VignetteAmount, _EffectAmount, _ScanlinesYScale, _NoiseXScale, _NoiseYScale, _ScanlinesIntensity, _ScanlinesEffectAmount, _NoiseEffectAmount;
			uniform fixed _NoiseXSpeed, _NoiseYSpeed, _Distortion, _Scale, _RandomValue;
	
			// Lens distortion algorithm from http://www.ssontech.com/content/lensalg.htm
			float2 barrelDistortion(float2 coord)
			{
        		float2 h = coord.xy - float2(0.5, 0.5);
				float r2 = h.x * h.x + h.y * h.y;
				float f = 1.0 + r2 * (_Distortion * sqrt(r2));

        		return f * _Scale * h + 0.5;
			}

			fixed4 frag(v2f_img i) : SV_TARGET
			{
				fixed3 renderTex = tex2D(_MainTex, barrelDistortion(i.uv));
				fixed3 constantWhite = 1;

				// Apply Green Tone effect

				fixed lum = dot(fixed3(0.299, 0.587, 0.114), renderTex.rgb);
				fixed3 finalColor = lum + _GreenColor;

				// Apply Vignette Effect

				fixed3 vignetteTex = tex2D(_VignetteTex, i.uv);
				finalColor *= lerp(finalColor, vignetteTex, _VignetteAmount);

				// Apply Scanlines Effect

				half2 scanlineUV = half2(0, i.uv.y*_ScanlinesYScale);
				fixed3 scanlineTex = saturate(tex2D(_ScanlinesTex, scanlineUV) + _GreenColor*_ScanlinesIntensity);
				finalColor *= lerp(constantWhite, scanlineTex, _ScanlinesEffectAmount);

				// Apply Noise Effect

				half2 noiseUV = half2(i.uv.x*_NoiseXScale + (_RandomValue * _SinTime.z * _NoiseXSpeed), i.uv.y*_NoiseYScale + _Time.z*_NoiseYSpeed);
				fixed3 noiseTex = tex2D(_NoiseTex, noiseUV);
				finalColor *= lerp(constantWhite, noiseTex, _NoiseEffectAmount);

				// Apply global effect amount

				finalColor = lerp(renderTex, finalColor, _EffectAmount);

				return fixed4(finalColor,1);
			}

			ENDCG
		}
	}

	FallBack Off
}