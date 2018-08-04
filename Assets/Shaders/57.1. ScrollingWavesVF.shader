Shader "SFS/ScrollingWavesVF" {
	
	// Alters the geometry so to make it wobble given the oscilation frequency, amplitude and speed
	// It does wobble the geometry in X and Z directions following sin and cos functions respectively
	// It also scrolls the texture applied over the surface based on some scroll input parameters, and
	// includes an additional texture (for example, to represent foam over the water) which also scrolls
	// at a different pace

	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		_FoamTex("Foam Texture", 2D) = "white" {}
		_Freq("Frequency", Range(0,2)) = 0
		_Amp("Amplitude", Range(0,2)) = 0
		_Speed("Speed", Range(0,2)) = 0
		_ScrollX ("Scroll X", Range(-2,2)) = 1
		_ScrollY ("Scroll Y", Range(-2,2)) = 1
	}

	Subshader
	{
		Tags { "Queue"="Geometry"}

		Pass
		{
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert
			#pragma fragment frag

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 color : COLOR;
				float2 uv : TEXCOORD0;
			};

			sampler2D _MainTex, _FoamTex;
			float4 _MainTex_ST;
			float _Freq, _Amp, _Speed, _ScrollX, _ScrollY;
			
			v2f vert(appdata v)
			{
				v2f o;

				float4 vert;

				float waveHeight = sin(v.vertex.x * _Freq + _Time.w * _Speed) * _Amp + sin(v.vertex.x * _Freq*2 + _Time.w*2) * _Amp;
				float waveHeightZ = cos(v.vertex.z * _Freq + _Time.w * _Speed) * _Amp + cos(v.vertex.x * _Freq*2 + _Time.w*2) * _Amp;

				vert.xy = v.vertex.xy;
				vert.y += waveHeight + waveHeightZ;
				vert.zw = v.vertex.zw;

				o.vertex = UnityObjectToClipPos(vert);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				o.color = vert.y + 1;
				
				return o;
			}

			// t's worth noting here that proper lighting calculations should be added if necessary...

			fixed4 frag(v2f i) : SV_TARGET
			{
				fixed4 color;

				float2 ScrollUV = float2(_ScrollX * _Time.y, _ScrollY * _Time.y);

				float4 mainTex = tex2D(_MainTex, i.uv + ScrollUV);
				float4 foamTex = tex2D(_FoamTex, i.uv + ScrollUV*1.25);

				color.rgb = (mainTex.rgb + foamTex.rgb) * 0.5 * i.color;
				color.a = 1;

				return color;
			}

			ENDCG
		}
	}
}