// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "SFS/LightingToonTex" {

	// Shades the geometry based on a main texture as well as a toon shading effect driven by the provided ramp map
	// Similar to the previous one but using a slightly different way of applying the texture so it's more controllable
	// (the texture is composed with the base color instead of added to it, and the Albedo is not taken into account in the toon shading)

	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		_MainTex("Main Texture", 2D) = "white" {}
		_Intensity("Intensity", Range(0,2)) = 1
		_RampTex("Ramp Texture", 2D) = "white" {}
		_Offset("Offset", Range(-1,1)) = 1
	}

	Subshader
	{
		CGPROGRAM

		#include "UnityCG.cginc"

		#pragma target 3.0

		#pragma surface surf Toon noshadow

		struct Input 
		{
			float2 uv_MainTex;
		};

		float _Intensity, _Offset;
		fixed4 _Color;
		sampler2D _MainTex, _RampTex;

		fixed4 LightingToon(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
		{
			fixed4 color;

			half NdotL = saturate(dot(viewDir,s.Normal));
			color.rgb = _LightColor0.rgb * tex2D(_RampTex, float2(NdotL,0.5) + _Offset).rgb * atten * _Intensity;
			color.a = s.Alpha;
			
			return color;
		}

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Color.rgb * tex2D(_MainTex, IN.uv_MainTex);
		}

		ENDCG
	}

	FallBack "Diffuse"
}