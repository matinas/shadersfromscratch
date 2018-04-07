Shader "SFS/DotProductAlbedo" {
	
	// Shades the geometry based on the angle between the normals and the view
	// direction (used to set the color's red channel). It uses a color
	// displacement parameter to allow inverting the shading

	Properties
	{
		_Disp ("Color Displacement", Range(-1,1)) = 0
	}

	SubShader {

		CGPROGRAM

		#pragma surface surf Lambert

		float _Disp;

		struct Input
		{
			float2 uv_NormalTex;
			fixed3 viewDir;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			float dotP = _Disp + dot(o.Normal,IN.viewDir);

			o.Albedo = fixed3(dotP,1,1);
		}
		ENDCG
	}

	FallBack "Diffuse"
}
