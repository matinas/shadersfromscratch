Shader "SFS/EmissionAlbedo" {
	
	Properties {
		_Albedo ("Albedo Color", Color) = (1,1,1,1)
		_Emission ("Emission Color", Color) = (1,1,1,1)
	}
	
	SubShader {
		
		CGPROGRAM
		#pragma surface surf Lambert

		uniform fixed4 _Albedo;
		uniform fixed4 _Emission;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Albedo.rgb;
			o.Emission = _Emission.rgb;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
