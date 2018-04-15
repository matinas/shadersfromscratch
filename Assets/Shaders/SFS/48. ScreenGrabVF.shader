Shader "SFS/ScreenGrabVF" {
	
	// Grabs the rendered scene and applies it as a texture to the geometry

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
	}

	SubShader {

		Tags { "Queue" = "Transparent" } // We set this queue to ensure this geometry is rendered at the end
										 // If we have transparent objects we have to increment this further to work properly

		GrabPass {} // This pass will grab the frame buffer at this moment and put it on a texture called _GrabTexture

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


			sampler2D _MainTex, _GrabTexture; // _GrabTexture will maintain the framebuffer image immediately before the GrabPass
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
				fixed4 color = tex2D(_GrabTexture, i.uv);
				return color;
			}

			ENDCG
		}
	}
}