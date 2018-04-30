// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Example/AdvancedWaterEffect" {

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_Color ("Color", Color) = (1,1,1,1)
		_Displacement ("Displacement", Range(0,0.5)) = 0
		_NoiseTex ("Noise Texture", 2D) = "black" {}
		_Period ("Period", Range(0,50)) = 1
		_Scale ("Scale", Range(0,10)) = 1
	}

 	SubShader {

		Tags { "Queue" = "Transparent" } // We set this queue to ensure this geometry is rendered at the end
										 // If we have transparent objects we have to increment this further to work properly

		GrabPass {}

		Pass
		{
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
	
			#include "UnityCG.cginc"

			sampler2D _MainTex, _GrabTexture, _NoiseTex;
			fixed4 _Color;
			float _Displacement, _Period, _Scale;
	
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uvmain : TEXCOORD1;
				fixed2 uvnoise : TEXCOORD2;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 uvgrab : TEXCOORD0;
				float2 uvmain : TEXCOORD1;
				fixed2 uvnoise : TEXCOORD2;
				float4 worldPos : TEXCOORD3;
			};
	
			float4 _MainTex_ST, _NoiseTex_ST;

			v2f vert(appdata v)
			{
				v2f o;

				o.vertex = UnityObjectToClipPos(v.vertex);

				o.uvgrab.xy = (float2(o.vertex.x,o.vertex.y*_ProjectionParams.x)+o.vertex.w)*0.5;
				o.uvgrab.zw = o.vertex.zw;

				o.uvmain = TRANSFORM_TEX(v.uvmain, _MainTex);
				o.uvnoise = TRANSFORM_TEX(v.uvnoise, _NoiseTex);

				o.worldPos = mul(unity_ObjectToWorld, v.vertex);

				return o;
			}

			fixed4 frag(v2f i) : SV_TARGET
			{
				float sinT = sin(_Time.w / _Period);

				// This solution do not generate an animated material
				//float2 distortion = float2(sinT,sinT)-0.5;

				// Introduce time and a noise texture. The best way to avoid seeing a sinusoid pattern is to use the sine waves
				// as an offset in the UV data of the noise texture The _Scale variable determines the size of the waves
				//float2 distortion = float2(tex2D(_NoiseTex, i.uvnoise/_Scale + float2(sinT, 0)).r - 0.5, tex2D(_NoiseTex, i.uvnoise/_Scale + float2(0, sinT)).r - 0.5);

				// Same as last one but uses the world position as the initial position of the UV data so if the material moves the waves remain relative to the background
				float2 distortion = float2(tex2D(_NoiseTex, i.worldPos.xy / _Scale + float2(sinT, 0)).r - 0.5, tex2D(_NoiseTex, i.worldPos.xy / _Scale + float2(0, sinT)).r - 0.5);
				
				i.uvgrab.xy += distortion * _Displacement;

				fixed4 grab = tex2Dproj(_GrabTexture, i.uvgrab);
				fixed4 mainTex = tex2D(_MainTex, i.uvmain);

				fixed4 color = grab * mainTex * _Color;

				return color;
			}

			ENDCG
		}
	}
}