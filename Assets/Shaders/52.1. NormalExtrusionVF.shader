Shader "SFS/NormalExtrusionVF" {
	
	// Extrudes the vertices based on the extrude amount parameter by using a V/F shader

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_ExtrudeAmount ("Extrude Amount", Range(-1,1)) = 0
	}

	SubShader {

		Pass
		{
			Tags { "Queue" = "Geometry" }

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct app_data
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION; 
				float2 uv : TEXCOORD0;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _ExtrudeAmount;

			v2f vert(app_data v)
			{
				v2f o;
				
				v.vertex.xyz += v.normal * _ExtrudeAmount;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				// Another alternative: extrude in clip space
				// float3 nClip = mul(UNITY_MATRIX_VP, v.normal);
				// o.pos.xyz += nClip * _ExtrudeAmount;

				return o;
			}

			fixed4 frag(v2f i) : SV_TARGET
			{
				fixed4 color = tex2D(_MainTex, i.uv);

				return color;
			}

			ENDCG
		}
	}
}