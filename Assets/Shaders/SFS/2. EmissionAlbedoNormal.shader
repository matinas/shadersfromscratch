Shader "SFS/EmissionAlbedoNormal" {
	
	Properties {
		_Albedo ("Albedo Color", Color) = (1,1,1,1)
		_Emission ("Emission Color", Color) = (1,1,1,1)
		_Normal ("Normal Color", Color) = (1,1,1,1)
	}
	
	SubShader {
		
		CGPROGRAM
		#pragma surface surf Lambert

		uniform fixed4 _Albedo;
		uniform fixed4 _Emission;
		uniform fixed4 _Normal;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Albedo.rgb;
			o.Emission = _Emission.rgb;
			o.Normal = _Normal.rgb;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
