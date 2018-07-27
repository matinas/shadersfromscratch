Shader "SFS/StripedRimLocal" {
	
	// Shades the geometry by interchanging two colors depending on the world
	// position, giving a multicolor horizontal band effect as a result. The
	// band is rimmed to the edges depending on the given threshold parameter

	Properties
	{
		_Color1 ("Color 1", Color) = (0.5,0,0,1)
		_Color2 ("Color 2", Color) = (0,0.5,0,1)
		_Threshold ("Threshold", Range(0.0,1.0)) = 0.4
		_RimPower ("Rim Power", Range(0.5,10)) = 3.0
		_RimIntensity ("Rim Intensity", Range(0.1,10)) = 1.0
		_RimThreshold ("Rim Threshold", Range(0.0,0.9)) = 0
	}

	SubShader {

		CGPROGRAM

		#pragma surface surf Lambert

		fixed4 _Color1, _Color2;
		float _RimPower, _RimIntensity, _RimThreshold, _Threshold;

		struct Input
		{
			fixed3 viewDir;
			float3 worldPos;
		};

		fixed3 rimCutoff(float _rimValue, fixed4 _color)
		{
			return (_rimValue > _RimThreshold) ? _color * pow(_rimValue,_RimPower) : 0;
		}

		void surf (Input IN, inout SurfaceOutput o)
		{
			float rim = 1 - saturate(dot(IN.viewDir, o.Normal));

			float3 localPos = IN.worldPos - mul(unity_ObjectToWorld, float4(0,0,0,1));

			o.Emission = (frac(localPos.y*10) > _Threshold) ? rimCutoff(rim,_Color1) : rimCutoff(rim,_Color2); // We could have written the whole nested logic statements here but it's clearer with a function
			o.Emission *= _RimIntensity;
		}

		ENDCG		
	}

	FallBack "Diffuse"
}
