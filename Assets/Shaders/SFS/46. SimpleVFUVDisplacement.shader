Shader "SFS/SimpleVFUVDisplacement" {
	
	// A simple vertex shader that colors the geometry based on a texture which is offseted using the Sin function
	// It's useful to refer to this graphs in order to verify the result as the Offset parameters varies: https://www.desmos.com/calculator/nqfu5lxaij

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_XUVScale ("Scale UV X", Range(1,10)) = 1
		[Toggle] _XUVScaleToggl ("Enable Scale UV X", Float) = 1
		_YUVScale ("Scale UV Y", Range(1,10)) = 1
		[Toggle] _YUVScaleToggl ("Enable Scale UV Y", Float) = 1
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
			float4 _MainTex_ST;
			float _XUVScale, _YUVScale, _XUVScaleToggl, _YUVScaleToggl;

			v2f vert(app_data v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				o.uv.x = _XUVScaleToggl ? sin(o.uv.x * _XUVScale) : o.uv.x;
				o.uv.y = _YUVScaleToggl ? sin(o.uv.y * _YUVScale) : o.uv.y;

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