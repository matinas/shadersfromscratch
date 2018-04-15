Shader "SFS/DiffuseVF" {
	
	// Shades the geometry using a simple diffuse Lambert lighting model

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
	}

	SubShader {

		Pass
		{
			Tags { "LightMode" = "ForwardBase" } // It's requeried to set the rendering mode (forward rendering in this case)
			
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"

			struct app_data
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				fixed4 diff : COLOR;
			};


			sampler2D _MainTex;
			float4 _MainTex_ST;

			v2f vert(app_data v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				half3 worldNormal = UnityObjectToWorldNormal(v.normal); 		// We must convert the normal from object space to world space to be able to
				half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));	// compare it with the light's position which is in world space
				o.diff = nl * _LightColor0;

				return o;
			}

			fixed4 frag(v2f i) : SV_TARGET
			{
				fixed4 color = tex2D(_MainTex, i.uv);
				color *= i.diff;

				return color;
			}

			ENDCG
		}
	}
}