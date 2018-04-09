﻿Shader "SFS/PBRSpecularEmission" {
	
	// Shades the geometry with the Standard Specular lighting model (PBR) and makes
	// the geometry to glow in the areas not filtered in the specular map (non-black areas)

	Properties
	{
		_DiffuseColor ("Diffuse Color", Color) = (0,0,0,1)
		_SpecColor ("Specular Color", Color) = (0,0,0,1) // This one is already declared by Unity as part if the the CGPROGRAM so we don't have to
		_SpecularTexture ("Specular Texture", 2D) = "white" {}
		_Specular ("Specular Coverage", Range(0,1)) = 0.5
		_Emission ("Emission", Range(0.0,5)) = 0
	}

	SubShader {

		CGPROGRAM

		#pragma surface surf StandardSpecular

		sampler2D _SpecularTexture;
		fixed4 _DiffuseColor, _SpecularColor;
		half _Specular, _Emission;

		struct Input
		{
			fixed2 uv_SpecularTexture;
		};

		void surf (Input IN, inout SurfaceOutputStandardSpecular o) // We have to change the inout Surface Structure parameter for Standard lighting
		{
			o.Albedo = _DiffuseColor;
			o.Smoothness = tex2D(_SpecularTexture, IN.uv_SpecularTexture).r;
			o.Emission = o.Smoothness * _Emission;
			o.Specular = _SpecColor * _Specular;
		}

		ENDCG		
	}

	FallBack "Diffuse"
}