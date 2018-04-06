Shader "SFS/FullGreen" {
	
	// Challenge 2: create a shader that takes a texture to use as the albedo colour,
	// but no matter what always turns up the green channel to full.

	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_Range ("Range Value", Range(0,5)) = 1
		_MainTex ("Main Texture (RGB)", 2D) = "white" {}
		_Cubemap ("Cube Map", CUBE) = "" {}
		_Float ("Float Value", Float) = 1
		_Vector ("Vector", Vector) = (1,1,1,1)
	}
	SubShader {

		CGPROGRAM

		#pragma surface surf Lambert

		fixed4 _Color;
		half _Range;
		sampler2D _MainTex;
		samplerCUBE _Cubemap;
		float _Float;
		float4 _Vector;

		struct Input {
			float2 uv_MainTex;
			float3 worldRefl;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo.rb = _Color.rb + (tex2D(_MainTex, IN.uv_MainTex) * _Range).rb;
			o.Albedo.g = 1.0f;
			o.Emission = texCUBE(_Cubemap, IN.worldRefl).rgb;
		}
		
		ENDCG
	}
	FallBack "Diffuse"
}
