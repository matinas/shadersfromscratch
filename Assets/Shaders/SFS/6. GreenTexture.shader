Shader "SFS/GreenTexture" {
	
	// Challenge 3: Create a shader that has only one property which is a texture.
	// This texture should colour the albedo. To this texture, before applying it
	// to the albedo apply the colour green

	Properties {
		_MainTex ("Main Texture (RGB)", 2D) = "white" {}
	}

	SubShader {

		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			float4 green = (0,1,0,1);
			o.Albedo = (tex2D(_MainTex, IN.uv_MainTex) * green).rgb;
		}
		
		ENDCG
	}
	FallBack "Diffuse"
}
