Shader "SFS/SpecularBlinnPhong" {
	
	// Shades the geometry with speculear Blinn Phong lighting based on the input parameters

	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		_DiffuseColor ("Diffuse Color", Color) = (0,0,0,1)
		_SpecColor ("Specular Color", Color) = (1,1,1,1) // This one is already defined by Unity in the CGPROGRAM...
		_Spec("Specular Coverage", Range (0,1)) = 0.5
		_Shininness ("Shininness", Range(0,1)) = 0.5
	}

	SubShader {

		CGPROGRAM

		#pragma surface surf BlinnPhong

		sampler2D _MainTex;
		fixed4 _DiffuseColor;
		half _Spec;
		fixed _Shininness;

		struct Input
		{
			fixed2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _DiffuseColor + tex2D(_MainTex, IN.uv_MainTex).rgb;
			o.Specular = _Spec;
			o.Gloss = _Shininness;
		}

		ENDCG		
	}

	FallBack "Diffuse"
}
