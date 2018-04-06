Shader "SFS/DiffuseNormalIntensity" {
	
	// Challenge: Add another slider to the code developed in the previous
	// lecture to turn the brightness over the entire model up and down

	Properties {
		_AlbedoTex ("Albedo Texture", 2D) = "white" {}
		_NormalTex ("Normal Map", 2D) = "bump" {}
		_Bump ("Bump Amount", Range(0,10)) = 1
		_Intensity ("Intensity", Range(0,10)) = 1
	}
	
	SubShader {
		
		CGPROGRAM
		
		#pragma surface surf Lambert

		uniform sampler2D _AlbedoTex;
		uniform sampler2D _NormalTex;
		uniform half _Bump, _Intensity;

		struct Input
		{
			float2 uv_AlbedoTex;
			float2 uv_NormalTex;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_AlbedoTex, IN.uv_AlbedoTex).rgb;
			o.Normal = UnpackNormal(tex2D(_NormalTex, IN.uv_NormalTex));

			//o.Normal = UnpackNormal(tex2D(_NormalTex, IN.uv_NormalTex)) * _Intensity; // Could have also multiplied the intensity here to modify the whole
																						// normal vector (not just the Z) but the result is a bit different
			
			o.Normal *= float3(_Bump,_Bump,_Intensity);
		}

		ENDCG
	}

	FallBack "Diffuse"
}