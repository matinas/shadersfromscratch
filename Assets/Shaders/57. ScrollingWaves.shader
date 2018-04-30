Shader "SFS/ScrollingWaves" {
	
	// Alters the geometry so to make it wobble given the oscilation frequency, amplitude and speed
	// It does wobble the geometry in X and Z directions following sin and cos functions respectively
	// It also scrolls the texture applied over the surface based on some scroll input parameters, and
	// includes an additional texture (for example, to represent foam over the water) which also scrolls
	// at a different pace

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_FoamTex ("Foam Texture", 2D) = "white" {}
		_Freq ("Frequency", Range(0,3)) = 0.5
		_Amp ("Amplitude", Range(0,1)) = 0.1
		_Speed ("Speed", Range(0,5)) = 10
		_ScrollX ("Scroll X", Range(-2,2)) = 1
		_ScrollY ("Scroll Y", Range(-2,2)) = 2
	}

	SubShader {

		Tags { "Queue"="Geometry" }

		CGPROGRAM

		#pragma surface surf Lambert vertex:vert

		#include "UnityCG.cginc"

		sampler2D _MainTex, _FoamTex;
		float _Amp, _Freq, _Speed, _ScrollX, _ScrollY;

		struct appdata
		{
			float4 vertex : POSITION;
			float3 normal : NORMAL;
			float4 texcoord : TEXCOORD0;
			float4 texcoord1 : TEXCOORD1; // Parameters from here are unused but mandatory...
			float4 texcoord2 : TEXCOORD2;
			float4 color : COLOR;
		};

		struct Input
		{
			float2 uv_MainTex : TEXCOORD0;
			float4 vertColor : COLOR;
		};

		void vert(inout appdata v)
		{
			float t = _Time.y * _Speed; // Time.y contains the time ticks unmodified (_Time.x contains _Time/20)
			float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp + sin(t*2 + v.vertex.x * _Freq*2) * _Amp; // Check trig function interactive graphs here! https://www.desmos.com/calculator
			float waveHeightZ = cos(t + v.vertex.z * _Freq) * _Amp + cos(t*2 + v.vertex.z * _Freq*2) * _Amp;

			v.vertex.y += waveHeight + waveHeightZ;
			v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z + waveHeightZ)); // Update normal so to get proper Lighting. Check exaplnation how to get this at the end
			
			v.color = waveHeight*waveHeightZ + 1; // Should return a value in range [0,1] so when the wave is very low (waveHeight=-1) it's darker and when it's high it's brighter
		}

		void surf(Input IN, inout SurfaceOutput o)
		{
			float2 scrollUV = float2(_Time.x*_ScrollX, _Time.x*_ScrollY);

			fixed3 mainTex = tex2D(_MainTex, IN.uv_MainTex + scrollUV).rgb;
			fixed3 foamTex = tex2D(_FoamTex, IN.uv_MainTex + scrollUV*1.25).rgb; 	// Set the foam scroll speed a bit higher than the water scroll speed

			o.Albedo.rgb = (mainTex + foamTex*0.5) * IN.vertColor.rgb; 				// Set the foam intensity a bit smaller so it doesn't get too white
		}

		ENDCG
	}

	Fallback "Diffuse"
}