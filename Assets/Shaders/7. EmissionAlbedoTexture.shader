Shader "SFS/EmissionAlbedoTexture" {
	
	// Shades the geometry with a given albedo texture as well as an emmision texture

	Properties {
		_AlbedoTex ("Albedo Texture", 2D) = "white" {}

		//set this texture to black to stop the white overwhelming the effect if no emission texture is present
		_EmissionTex ("Emission Texture", 2D) = "black" {}
	}
	
	SubShader {
		
		CGPROGRAM
		
		#pragma surface surf Lambert

		sampler2D _AlbedoTex;
		sampler2D _EmissionTex;

		struct Input
		{
			float2 uv_AlbedoTex;
			float2 uv_EmissionTex; // This is not strictly neccessary as we are using the same UV values for both textures...
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_AlbedoTex, IN.uv_AlbedoTex).rgb;
			o.Emission = tex2D(_EmissionTex, IN.uv_EmissionTex).rgb;
		}

		ENDCG
	}

	FallBack "Diffuse"
}