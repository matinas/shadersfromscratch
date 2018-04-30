Shader "SFS/Rim" {
	
	// Creates a Rim effect highlighting just the borders of the geomtry with
	// the given color and intensity parameters

	Properties
	{
		_RimColor ("Rim Color", Color) = (0,0.5,0.5,1)
		_RimPower ("Rim Power", Range(0.5,10)) = 3.0
		_RimIntensity ("Rim Intensity", Range(0.1,10)) = 1.0
	}

	SubShader {

		CGPROGRAM

		#pragma surface surf Lambert

		fixed4 _RimColor;
		float _RimPower, _RimIntensity;

		struct Input
		{
			fixed3 viewDir;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			half rim = 1 - saturate(dot(o.Normal,IN.viewDir));

			o.Emission = _RimColor * pow(rim,_RimPower) * _RimIntensity;
		}
		ENDCG
	}

	FallBack "Diffuse"
}
