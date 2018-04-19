Shader "SFS/GlassEffect" {
	
	// Shades the geometry with a glass effect that makes all what's behind it a little blured and distorted

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_NormalTex ("Normal Texture", 2D) = "white" {}
		_UVScale ("UV Scale", Range(0,10)) = 0
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

			float _UVScale, _UValue, _VValue, _VX, _VY;

			struct app_data
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 uvnormal : TEXCOORD1;
				float4 uvgrab : TEXCOORD2; // Screen space coordinates of vertex
			};


			sampler2D _MainTex, _NormalTex, _GrabTexture; // _GrabTexture will maintain the framebuffer image immediately before the GrabPass
			float4 _MainTex_ST, _NormalTex_ST;

			v2f vert(app_data v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				
				o.uvgrab = ComputeScreenPos(o.vertex); // Check here: https://docs.unity3d.com/Manual/SL-BuiltinFunctions.html

				//o.uvgrab.xy = (float2(o.vertex.x, o.vertex.y*_ProjectionParams.x) + o.vertex.w) * 0.5; // This two lines are the same as the one above...
				//o.uvgrab.zw = o.vertex.zw;															 // Check explanation * at the end of the shader code

				o.uvnormal = TRANSFORM_TEX(v.uv, _NormalTex);

				return o;
			}

			fixed4 frag(v2f i) : SV_TARGET
			{
				half3 normal = UnpackNormal(tex2D(_NormalTex, i.uvnormal));
				
				float2 offset = normal.xy * _UVScale; 
				i.uvgrab.xy += offset * i.uvgrab.z;

				fixed4 color = tex2Dproj(_GrabTexture, i.uvgrab); // Check tex2Dproj() here: http://developer.download.nvidia.com/cg/tex2Dproj.html
				color *= tex2D(_MainTex, i.uv);

				return color;
			}

			ENDCG
		}
	}
}

// Math explanation *: the vertex coordinates at this point are in Clip Space as we have already applied the MVP transform using UnityObjectToClipPos(),
// so they are homogeneous coordinates living in the range [-1,1]. Texture coordinates saved in uvgrab should fall into the range [0,1] as any other texcoord,
// so what that particular line is doing is basically adding vertex.w to each coordinate and dividing it by 2. More clearly, it's something like:
// 
// 		float2((o.vertex.x+o.vertex.w)/2, (o.vertex.y+o.vertex.w)/2)
//
// That means that if we divide each coord by vertex.w, we get something in the desired range [0,1]. For example, let's focus in the X coord and let's divide it by vertex.w:
//
// 		(o.vertex.x/o.vertex.w + o.vertex.w/o.vertex.w) / 2 = (o.vertex.x/o.vertex.w + 1) / 2 = ({something in [-1,1]} + 1) / 2 = ({something in [0,2]} / 2) = something in [0,1]
//
// The division by vertex.w it's actually being done by the tex2Dproj() call as part of the fragment shader. What it does is basically a texture sampling
// much like tex2D but in contrast it also includes a projection before sampling the texture (division by the homogeneous coordinate w) as we want to get that
// particular screen space pixel color. Unity provides a function for doing this type of texture sampling called ComputeScreenPos(), so we can replace these lines
// with just o.uvgrab = ComputeScreenPos(o.vertex) and it should still work fine.