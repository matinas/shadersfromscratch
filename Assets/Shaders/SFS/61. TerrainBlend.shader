Shader "Example/Terrain" {

	// Blends multiple textures based on a terrain splatmap. Mainly used for shading terrains.
	// It also allows to project a customizable circle in a given point of the terrain

	Properties
	{
		_MainTint ("Diffuse Tint", Color) = (1,1,1,1) 
		_Splatmap ("Splatmap", 2D) = "" {}
		_Tex1 ("Texture 1", 2D) = "" {}
		_Tex2 ("Texture 2", 2D) = "" {}
		_Tex3 ("Texture 3", 2D) = "" {}
		_Tex4 ("Texture 4", 2D) = "" {}
		_ColorA ("Color A", Color) = (1,1,1,1)
		_ColorB ("Color B", Color) = (1,1,1,1)
		[Toggle] _DrawCircle ("Draw Circle", Float) = 0
		_Center("Center", Vector) = (0,0,0,0)
		_Radius("Radius", Float) = 0.5
		_RadiusColor("Radius Color", Color) = (1,0,0,1)
		_RadiusWidth("Radius Width", Float) = 2 
	}

 	SubShader {

    	CGPROGRAM

    	#pragma surface surf Lambert
 
    	sampler2D _Splatmap, _Tex1, _Tex2, _Tex3, _Tex4;
		fixed4 _MainTint, _ColorA, _ColorB, _RadiusColor;
		float3 _Center;
		float _DrawCircle, _Radius, _RadiusWidth;
 
    	struct Input
		{
			float2 uv_Splatmap;
			float2 uv_Tex1;
			float2 uv_Tex2;
			float2 uv_Tex3;
			float3 worldPos;
    	};
 
    	void surf (Input IN, inout SurfaceOutput o)
		{
			float4 blendData = tex2D(_Splatmap, IN.uv_Splatmap);

			fixed3 tex1color = tex2D(_Tex1, IN.uv_Tex1);
			fixed3 tex2color = tex2D(_Tex2, IN.uv_Tex2);
			fixed3 tex3color = tex2D(_Tex3, IN.uv_Tex3);
			fixed3 tex4color = tex2D(_Tex4, IN.uv_Tex3); // Shares UV values with _Tex3 because we cannot add another UV interpolator as Input...

			fixed3 finalcolor = lerp(tex1color,tex2color,blendData.r);
			finalcolor = lerp(finalcolor,tex3color,blendData.g);
			finalcolor = lerp(tex4color,finalcolor,blendData.b);
			finalcolor *= lerp(_ColorA, _ColorB, blendData.a);

			fixed3 circleColor = 0;

			if (_DrawCircle)
			{
				float d = distance(_Center, IN.worldPos);
				circleColor = (d > _Radius) && (d < _Radius + _RadiusWidth) ? _RadiusColor.rgb : float3(0,0,0);
			}

			o.Albedo = saturate(finalcolor) + _MainTint.rgb + circleColor;
			o.Alpha = 1;
		}

    	ENDCG
	}

	FallBack "Diffuse"
}