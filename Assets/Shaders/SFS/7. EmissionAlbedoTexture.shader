Shader "SFS/EmissionAlbedoTexture" {
	
	// Challenge: 1. Write a shader that has two properties; one for a diffuse texture and one for a emissive texture.
	// 2. Use the attached images to test with Zombunny. There is one for diffuse and one for emissive. 3. Apply the
	// diffuse to the model's albedo and the emissive to the emission. What do you notice happens to the visual result
	// when only a diffuse texture is given and no emissive one? How do you think this is correct? 

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
			float2 uv_EmissionTex;
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