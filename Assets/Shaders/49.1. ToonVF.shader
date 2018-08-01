Shader "SFS/ToonVF" {

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_RampTex ("Ramp Texture", 2D) = "white" {}
		_Color ("Base color", Color) = (1,1,1,1)
		_Offset("Offset", Range(0,1)) = 0
	}

	SubShader {

		Tags { "Queue" = "Geometry" }

		Pass
		{
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"

			struct app_data
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float3 worldNormal : TEXCOORD1;
			};

			sampler2D _MainTex, _RampTex;
			float4 _MainTex_ST, _RampTex_ST;
			fixed4 _Color;
			float _Offset;

			v2f vert(app_data v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _RampTex);
				o.worldNormal = UnityObjectToWorldNormal(v.normal);

				return o;
			}

			fixed4 frag(v2f i) : SV_TARGET
			{
				fixed4 color;

				half nl = max(0, dot(i.worldNormal, _WorldSpaceLightPos0.xyz));
				color.rgb = _Color + tex2D(_RampTex, nl + _Offset).rgb;

				return color;
			}

			ENDCG
		}
	}
}
