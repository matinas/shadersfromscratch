Shader "SFS/SimpleVF" {
	
	// A simple vertex shader that colors the geometry per-pixel based on pixel's X position
	// The interesting thing to note here is that the color assigned corresponds to the vertex screen coords on the frag

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_ScreenOffset ("Screen Offset", Float) = 1
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
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				fixed4 color : COLOR;
			};

			sampler2D _MainTex;
			float _MainTex_ST, _ScreenOffset;

			v2f vert(app_data v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);

				return o;
			}

			fixed4 frag(v2f i) : SV_TARGET
			{
				fixed4 color;
				color.r = i.vertex.x/_ScreenOffset; // This is because we are in screen/image space now so coords range from 0 to screen resolution

				return color;
			}

			ENDCG
		}
	}
}