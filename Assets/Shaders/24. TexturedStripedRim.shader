Shader "SFS/TextureStripedRim" {
	
	// Shades the geometry with a base texture in addition to interchanging two colors depending
	// on the world position, giving a multicolor horizontal band effect as a result. The
	// band is rimmed to the edges depending on the given threshold parameter, and the
	// size of each band is also configurable

	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		_Color1 ("Color 1", Color) = (0.5,0,0,1)
		_Color2 ("Color 2", Color) = (0,0.5,0,1)
		_Threshold ("Threshold", Range(0.0,1.0)) = 0.4
		_RimPower ("Rim Power", Range(0.5,10)) = 3.0
		_RimIntensity ("Rim Intensity", Range(0.1,10)) = 1.0
		_RimThreshold ("Rim Threshold", Range(0.0,0.9)) = 0
		_StripeCountCoef ("Stripe Amount Coefficient", Range(1,20)) = 10
	}

	SubShader {

		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _MainTex;
		fixed4 _Color1, _Color2;
		float _RimPower, _RimIntensity, _RimThreshold, _Threshold, _StripeCountCoef;

		struct Input
		{
			fixed2 uv_MainTex;
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

			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;

			o.Emission = (frac(IN.worldPos.y * _StripeCountCoef) > _Threshold) ? rimCutoff(rim,_Color1) : rimCutoff(rim,_Color2); // We could have written the whole nested logic statements here but it's clearer with a function
			o.Emission *= _RimIntensity;
		}

		ENDCG		
	}

	FallBack "Diffuse"
}
