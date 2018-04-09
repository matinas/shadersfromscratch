Shader "SFS/HardRim" {
	
	// Creates a Rim effect highlighting just the borders of the geomtry with
	// the given colors and intensity parameters. The color thresholds allow to
	// configure the size of the color bands

	Properties
	{
		_RimColor1 ("Rim Color", Color) = (0.5,0,0,1)
		_RimThreshold1 ("Rim Threshold", Range(0.0,0.9)) = 0
		_RimColor2 ("Rim Color", Color) = (0,0.5,0,1)
		_RimThreshold2 ("Rim Threshold", Range(0.0,0.9)) = 0
		_RimPower ("Rim Power", Range(0.5,10)) = 3.0
		_RimIntensity ("Rim Intensity", Range(0.1,10)) = 1.0
	}

	SubShader {

		CGPROGRAM

		#pragma surface surf Lambert

		fixed4 _RimColor1, _RimColor2;
		float _RimPower, _RimIntensity, _RimThreshold1, _RimThreshold2;

		struct Input
		{
			fixed3 viewDir;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			half rim = 1 - saturate(dot(o.Normal,IN.viewDir));

			o.Emission = rim > _RimThreshold1 ? _RimColor1 * pow(rim,_RimPower) : (rim > _RimThreshold2 ? _RimColor2 * pow(rim,_RimPower) : 0);
			o.Emission *= _RimIntensity;
		}
		ENDCG
	}

	FallBack "Diffuse"
}
