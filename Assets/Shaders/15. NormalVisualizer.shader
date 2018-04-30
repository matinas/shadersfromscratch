Shader "Holistic/NormalVisualizer"
{
	// Shades the geometry with the normal vector used as a color, modified
	// to control the amount of bump (X and Y coords) and the intensity/length (Z coord)

	Properties {
		_Bump ("Bump Amount", Range(0,10)) = 1
		_Intensity ("Intensity", Range(0,10)) = 1
	}

	SubShader
	{

	CGPROGRAM
	#pragma surface surf Lambert

	uniform half _Bump, _Intensity;

	struct Input
	{
		float2 uv_mainTex;
	};

	void surf(Input IN, inout SurfaceOutput o)
	{
		o.Albedo = o.Normal * float3(_Bump,_Bump,_Intensity);
	}

	ENDCG
	}

	Fallback "Diffuse"
}