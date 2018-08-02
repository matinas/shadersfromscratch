Shader "SFS/AdvancedOutlineOnly" {
	
	// Shades the geometry with an outline of the specified color and width and the main geometry is transparent.

	Properties
	{
		_OutlineColor ("Outline Color", Color) = (0,0,0,1)
   		_Outline ("Outline width", Range (0.0, 5.0)) = 1
	}
	
	CGINCLUDE // CGINCLUDE will insert the contents of the include into each pass of the shader when needed (#pragma vert and frag defined)
			  // For example, in this particular case only the second pass is using the vertex function defined here

	#include "UnityCG.cginc"
	
	struct appdata
	{
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};
	
	struct v2f
	{
		float4 pos : POSITION;
		float4 color : COLOR;
	};
	
	uniform float _Outline;
	uniform float4 _OutlineColor;
	
	v2f vert(appdata v)
	{
		v2f o;
		o.pos = UnityObjectToClipPos(v.vertex);
		
		float3 norm = mul ((float3x3) UNITY_MATRIX_IT_MV, v.normal);
		float2 offset = TransformViewToProjection(norm.xy);
		
		o.pos.xy += offset * o.pos.z * _Outline;
		o.color = _OutlineColor;
		return o;
	}
	
	ENDCG
	
	SubShader
	{
		Tags { "Queue" = "Transparent" }
	
		Pass
		{
			Cull Back
			Blend Zero One
			Offset -8, -8
			SetTexture [_OutlineColor]
			{
				ConstantColor (0,0,0,0)
				Combine constant
			}
		}

		Pass
		{
			Cull Front
		
			Blend One OneMinusDstColor 
		
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
		
			half4 frag(v2f i) : COLOR
			{
				return i.color;
			}

			ENDCG
		}
	}
	
	Fallback "Diffuse"
}