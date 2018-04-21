Shader "SFS/Plasma" {
	
	// Shades the geometry with RGB coloured psychodelic circular patterns (akin a plasma effect)

	Properties
	{
		_Tint ("Main Color", Color) = (1,1,1,1)
		_Speed ("Speed", Range(0,5)) = 1
		_Scale1 ("Scale 1", Range(0,5)) = 1
		_Scale2 ("Scale 2", Range(0,5)) = 1
		_Scale3 ("Scale 3", Range(0,5)) = 1
		_Scale4 ("Scale 4", Range(0,5)) = 1
	}

	SubShader {

		Tags { "Queue"="Geometry" }

		CGPROGRAM

		#pragma surface surf Lambert

		#include "UnityCG.cginc"

		fixed4 _Tint;
		float _Speed, _Scale1, _Scale2, _Scale3, _Scale4;

		struct Input
		{
			float3 worldPos : TEXCOORD1;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			float t = _Time.y * _Speed;
			float c=0;

			c += sin(IN.worldPos.x * _Scale1 + t);										// vertical movement (involves x)
			c += sin(IN.worldPos.z * _Scale2 + t);										// horizontal movement (involves z)
			c += sin(_Scale3 * (IN.worldPos.x*sin(t/2) + IN.worldPos.z*sin(t/3))+t); 	// circular patterns (involves x and z)

			float c1 = pow(IN.worldPos.x + 0.5*sin(t/5),2); 							// and even more circular movement
			float c2 = pow(IN.worldPos.z + 0.5*cos(t/3),2);
			c += sin(sqrt(_Scale4*(c1+c2)+1+t));

			o.Albedo.r = sin((c/4)*UNITY_PI + UNITY_PI/4);
			o.Albedo.g = sin((c/4)*UNITY_PI + UNITY_PI/2); // Check this for visualizing trig functions: https://www.desmos.com/calculator
			o.Albedo.b = sin((c/4)*UNITY_PI + UNITY_PI);

			// o.Albedo.rgb = sin((c/4)*UNITY_PI); // Use this for black and white version

			o.Albedo *= _Tint;
		}

		ENDCG
	}

	Fallback "Diffuse"
}