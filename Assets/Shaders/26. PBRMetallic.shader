Shader "SFS/PBRMetallic" {
	
	// Shades the geometry with the Standard Metallic lighting model (PBR)

	Properties
	{
		_DiffuseColor ("Diffuse Color", Color) = (0,0,0,1)
		_MetallicTex("Metallic Texture", 2D) = "white" {}
		_Metallic("Metallic Intensity", Range (0,1)) = 0.5
	}

	SubShader {

		CGPROGRAM

		#pragma surface surf Standard

		sampler2D _MetallicTex;
		fixed4 _DiffuseColor;
		half _Metallic;

		struct Input
		{
			fixed2 uv_MetallicTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) // We have to change the inout Surface Structure parameter for Standard lighting
		{
			o.Albedo = _DiffuseColor;
			o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r; // As it is a grayscale texture we can just use any of the channels
			o.Metallic = _Metallic;
		}

		ENDCG		
	}

	FallBack "Diffuse"
}
