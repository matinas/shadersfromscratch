// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "SFS/LightingToon" {

	// Shades the geometry based on a color as well as a toon shading effect driven
	// by the provided ramp map. The toon effect is applied base on both the view and
	// the lights direction (as if two toon effects where applied accumulatively)

	Properties {
		_Color ("Base Color", Color) = (1,1,1,1)
		_RampTex ("Ramp (RGB)", 2D) = "white" {}
		_Offset ("Ramp Offset", Range(-1,1)) = 0 
	}

 	SubShader {

    	Tags { "RenderType"="Opaque" }
 
    	CGPROGRAM

    	#pragma surface surf Toon // As we redefined the lighting model function the program expects to find a LightingToon function
 
		sampler2D _RampTex;
		fixed4 _Color;
		half _Offset;
		 
    	struct Input
		{
			fixed3 viewDir;
    	};
 
    	void surf (Input IN, inout SurfaceOutput o)
    	{
			half NdotL = dot(o.Normal, normalize(IN.viewDir));

            o.Albedo = _Color + tex2D(_RampTex, fixed2(NdotL, 0.5)).rgb;
    	}

		fixed4 LightingToon(SurfaceOutput s, half3 lightDir, half atten) // We won't use the lightDir and atten but the custom lighting function signature must include those anyway
		{
			half NdotL = dot(s.Normal, normalize(lightDir)) + _Offset;

			// NdotL = NdotL*0.5 + 0.5; // If we would want to shift the dot values to [0,1] instead of [-1,1]. The result is similar but not the same because of the way the
										// value is used in the line below. If the dot is 0 for example, in the first case it will map to 0.5, but in the other it will map to 0

			NdotL = tex2D(_RampTex, fixed2(NdotL, 0.5));	

			fixed4 color;
			color.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
			color.a = s.Alpha;

			return color;
		}

    	ENDCG
 }

 FallBack "Diffuse"
}