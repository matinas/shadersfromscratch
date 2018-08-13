// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Example/SimpleWaterEffect" {

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_BumpTex ("Bump Texture", 2D) = "bump" {}
		_Color ("Color", Color) = (1,1,1,1)
		_Displacement ("Displacement", Range(0,1)) = 0
		_NoiseTex ("Noise Texture", 2D) = "black" {}
		_Freq ("Frequency", Range(0,10)) = 1
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

			sampler2D _MainTex, _GrabTexture, _BumpTex, _NoiseTex;
			fixed4 _Color;
			float _Displacement, _Freq;
	
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
			};
	
			float4 _MainTex_ST, _BumpTex_ST, _NoiseTex_ST;

			v2f vert(appdata v)
			{
				v2f o;

				o.vertex = UnityObjectToClipPos(v.vertex);

				o.uvgrab.xy = (float2(o.vertex.x,o.vertex.y*_ProjectionParams.x)+o.vertex.w)*0.5; // This is the same that ComputeGrabScreePos function does...
				o.uvgrab.zw = o.vertex.zw;

				o.uvmain = TRANSFORM_TEX(v.uvmain, _MainTex);
				o.uvnoise = TRANSFORM_TEX(v.uvnoise, _NoiseTex);

				return o;
			}

			fixed4 frag(v2f i) : SV_TARGET
			{
				float rand = tex2D(_NoiseTex, i.uvnoise);

				float distortion = sin(_Time.w*_Freq+rand*20)*_Displacement;
				float3 normal = UnpackNormal(tex2D(_BumpTex, i.uvmain))*distortion*rand;

				fixed4 grab = tex2Dproj(_GrabTexture, i.uvgrab + float4(normal,0));
				fixed4 mainTex = tex2D(_MainTex, i.uvmain);

				fixed4 color = grab * mainTex * _Color;

				return color;
			}

			ENDCG
		}
	}
}