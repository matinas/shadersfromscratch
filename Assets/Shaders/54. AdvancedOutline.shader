Shader "SFS/AdvancedOutline" {
	
	// Shades the geometry with an outline of the specified color and width. In contrast to the previous outline solution
	// it is not required to set it in the Transparent queue so it's more flexible and natural. It also outlines parts of
	// the geometry not outlined by the previous shader

	Properties {
		_AlbedoTex ("Albedo Texture", 2D) = "white" {}
		_OutlineColor ("Outline Color", Color) = (1,0,0,1)
		_OutlineWidth ("Outline Width", Range(0,0.02)) = 0
	}
	
	SubShader {

		Tags { "Queue" = "Geometry" }
		
		// First pass

		CGPROGRAM
	
			#pragma surface surf Lambert

			uniform sampler2D _AlbedoTex;

			struct Input
			{
				float2 uv_AlbedoTex;
			};

			void surf (Input IN, inout SurfaceOutput o)
			{
				o.Albedo = tex2D(_AlbedoTex, IN.uv_AlbedoTex).rgb;
			}

		ENDCG

		// Second pass. We combine the previous surface shader with a custom vertex/fragment shader put into a new pass

		Pass
		{
			Cull Front

			CGPROGRAM

				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

				struct app_data
				{
					float4 vertex : POSITION;
					float3 normal : NORMAL;
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					fixed4 color : COLOR;
				};

				float _OutlineWidth;
				fixed4 _OutlineColor;

				// NOTE: observe that we would not be able to do this with a Surface Shader with vertex access (vertex:vert) as it does not
				// allow to modify the vertex in a different space than object space. One is not supposed to convert the vertex to clip space there for
				// example, like it's done inside the vertex shader of a V/F shader (this is all done by the surf function inside a Surface Shader)

				v2f vert(app_data v)
				{
					v2f o;

					o.pos = UnityObjectToClipPos(v.vertex);

					//fixed3 n = UnityObjectToWorldNormal(v.normal);
					fixed3 n = normalize(mul((float3x3) UNITY_MATRIX_IT_MV, v.normal)); // Transform the normal to camera space so to align it with camera view
					float2 offset = TransformViewToProjection(n.xy); 					// Project the normal into XY plane, which makes the normals to point just to the sides, not front/back.
																						// This is what avoids that the Z coord of the outline to be less far than the Z coord of the base geometry

					o.pos.xy += offset * _OutlineWidth * o.pos.z; // Multiplication by pos.z is done in order to get the outline width dependant on the distance to the geometry
																  // So if the camera is far from the object the outline will be more thick and it will be seen without issues
					o.color = _OutlineColor; 

					return o;
				}

				fixed4 frag(v2f i) : SV_TARGET
				{
					return i.color;
				}

			ENDCG
		}
	}

	FallBack "Diffuse"
}