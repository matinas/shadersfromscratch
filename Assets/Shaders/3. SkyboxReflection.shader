Shader "SFS/SkyboxReflection" {
	
	// Shades the object with a given diffuse texture plus a given cube map to set
	// the emission based on the reflection vector for each pixel, generating a
	// reflection effect. If the geometry is flat shaded it should behave as a perfect
	// mirror (no interpolation of the reflection vector before sampling the cube map)

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
		sampler2D _MainTex;		// When we import a texture to Unity, we are setting up some of the properties that sampler2D will use
		samplerCUBE _Cubemap;	// The most important is the Filter mode, which determines how colors are interpolated when the texture is sampled
		float _Float;
		float4 _Vector;

		struct Input
		{
			float2 uv_MainTex;
			float3 worldRefl;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = (tex2D(_MainTex, IN.uv_MainTex) * _Range).rgb;
			o.Emission = texCUBE(_Cubemap, IN.worldRefl).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
