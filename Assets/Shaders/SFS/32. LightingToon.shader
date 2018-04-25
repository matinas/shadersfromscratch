// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "SFS/LightingToon" {

	// Shades the geometry based on a main texture as well as
	// a toon shading effect driven by the provided ramp map

	Properties {
		_MainTex ("Base (RGB)", 2D) = "black" {}
		_Color ("Base Color", Color) = (1,1,1,1)
		_RampTex ("Ramp (RGB)", 2D) = "white" {}
		_Offset ("Ramp Offset", Range(-1,1)) = 0 
	}

 	SubShader {

    	Tags { "RenderType"="Opaque" }
 
    	CGPROGRAM

    	#pragma surface surf Toon // As we redefined the lighting model function the program expects to find a LightingToon function
 
    	sampler2D _MainTex;
		fixed4 _Color;
		half _Offset;
		 
    	struct Input
		{
        	float2 uv_MainTex;
    	};
 
    	void surf (Input IN, inout SurfaceOutput o)
    	{
            o.Albedo = _Color + tex2D(_MainTex, IN.uv_MainTex).rgb;
    	}

		sampler2D _RampTex;

		fixed4 LightingToon(SurfaceOutput s, half3 lightDir, half atten) // We won't use the lightDir and atten but the custom lighting function signature must include those anyway
		{
			half NdotL = dot(s.Normal, normalize(lightDir)) + _Offset;

			// NdotL = NdotL*0.5 + 0.5; // If we would want to shift the dot values to [0,1] instead of [-1,1]. The result is similar but not the same because of the way the
										// value is used in the line below. If the dot is 0 for example, in the first case it will map to 0.5, but in the other it will map to 0

			NdotL = tex2D(_RampTex, fixed2(NdotL, 0.5));

			//half NDotL = floor(NdotL * _CelShadingLevels) / (_CelShadingLevels); // Substitute previous line by this in case we want to achieve Toon Shading without a Ramp
																				   // Map texture. _CelShadingLevels should be a float [0,+inf]. This method is called Snap

			fixed4 color;
			color.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
			color.a = s.Alpha;

			return color;
		}

    	ENDCG
	}

	FallBack "Diffuse"
}