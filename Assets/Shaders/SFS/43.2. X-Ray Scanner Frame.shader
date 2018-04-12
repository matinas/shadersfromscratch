Shader "SFS/X-Ray Scanner Frane" {
	
	// Makes the geometry visible and applies a rim effect only on those areas which are not written on the stencil buffer
	// Combined with the 43.1. shader (put into another object) it allows to make a frame for the scanner

	Properties
	{
		_RimColor ("Rim Color", Color) = (0,0.5,0.5,1)
		_RimPower ("Rim Power", Range(0.5,10)) = 3.0
		_RimIntensity ("Rim Intensity", Range(0.1,10)) = 1.0
		_RimThreshold ("Rim Threshold", Range(0.0,0.9)) = 0
	}

	SubShader {

		Tags { "Queue" = "Geometry" }

		Stencil
		{
			Ref 1
			Comp notequal 	// If not equal 1 on the Stencil don't draw it. Otherwise draw it
			Pass replace	// Update the stencil to include the whole scanner+frame (1 on the buffer)
			ZFail replace	// If ZTest fails write into the stencil so the frame gets above the passthrough geometry
		}

		CGPROGRAM

		#pragma surface surf Lambert

		fixed4 _RimColor;
		float _RimPower, _RimIntensity, _RimThreshold;

		struct Input
		{
			fixed3 viewDir;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			half rim = 1 - saturate(dot(o.Normal,IN.viewDir));

			o.Emission = _RimColor * (rim > _RimThreshold ? pow(rim,_RimPower) : 0) * _RimIntensity * _SinTime.w;
		}
		ENDCG
	}

	FallBack "Diffuse"
}