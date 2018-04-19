Shader "SFS/Waves" {
	
	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_Freq ("Frequency", Float) = 0
		_Amp ("Amplitude", Float) = 0
		_Speed ("Speed", Float) = 1
	}

	SubShader {

		Tags { "Queue"="Geometry" }

		CGPROGRAM

		#pragma surface surf Lambert vertex:vert

		#include "UnityCG.cginc"

		sampler2D _MainTex;
		float _Amp, _Freq, _Speed;

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
			float t = _Time * _Speed;
			float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp + sin(t*2 + v.vertex.x * _Freq*2) * _Amp; // Check trig function interactive graphs here! https://www.desmos.com/calculator
			float waveHeightZ = cos(t + v.vertex.z * _Freq) * _Amp + cos(t*2 + v.vertex.z * _Freq*2) * _Amp;

			v.vertex.y += waveHeight + waveHeightZ;
			v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z + waveHeightZ)); // Update normal so to get proper Lighting. Check exaplnation how to get this at the end
			
			v.color = waveHeight*waveHeightZ+1; // Should return a number in range [0,1] so when the wave is very low (waveHeight=-1) it's darker and when it's high it's brighter
		}

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo.rgb = tex2D(_MainTex, IN.uv_MainTex).rgb * IN.vertColor.rgb;
		}

		ENDCG
	}

	Fallback "Diffuse"
}

// How to calculate new normal? After modifying the vertex (increasing Y) we have a plane which includes the points V_p+1, V_p (modified vertex) and V_pz
// where: V_p+1=(p+1,0,0), V_p=(p,h,0) and V_pz=(p,h,1) where h is the waveHeigth or the amount we added to Y coord. So we can find the new normal calculating
// the normal to this plane, which can be calculated with the cross product V1xV2 where V1=V_p+1-V_p and V2=V_pz-V_p, the two vector formed by the three points
// from V_p. Doing the math we have that V1=(1,-h,0) and V2=(0,0,-1), so using the algebraic formula for the cross product we have that V1xV2=(h,1,0). The old
// normal was n=(0,1,0) so the new normal V1xV2=(h,1,0)=n+(h,0,0). And that's the same as adding the waveHeight to the X coordinate of the current normal as in the code