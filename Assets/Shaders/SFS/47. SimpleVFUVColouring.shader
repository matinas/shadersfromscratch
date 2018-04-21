Shader "SFS/SimpleVFUVColouring" {
	
	// A simple vertex shader that colors the geometry based either on a texture or the UV values of the mesh

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		[Toggle] _UVColouring ("UV-based shading", Float) = 0
	}

	SubShader {

		Tags { "Queue" = "Geometry" }

		Pass
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct app_data
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			sampler2D _MainTex;
			float _UVColouring;
			float4 _MainTex_ST;

			v2f vert(app_data v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				return o;
			}

			fixed4 frag(v2f i) : SV_TARGET
			{
				fixed4 color;
				
				color.rgb = _UVColouring ? fixed3(i.uv,0) : tex2D(_MainTex, i.uv);
				// color.rgb = fixed3(i.uv,0) * tex2D(_MainTex, i.uv); // In case we want to compose the texture with the UV colouring

				return color;
			}

			ENDCG
		}
	}
}