// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Example/Heatmap" {

	// Prints a heatmap base on the positions and properties of the given vectors
	// The idea is to demo the use of arrays inside a shader
	// The shader should be used with the Heatmap script, but it's not working fine...

	Properties
	{
		_HeatRampTex ("Heatmap Ramp Texture", 2D) = "white" {}
		_Points_Length ("Points Length", Int) = 3
	}

 	SubShader {

		Tags {"Queue"="Transparent"}

		Blend SrcAlpha OneMinusSrcAlpha // Alpha blend

		Pass
		{
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag

			uniform sampler2D _HeatRampTex;

			uniform int _Points_Length;
			uniform float3 _Points[5];		// x,y,z coords
			uniform float2 _Properties[5];	// x radius, y intensity

			struct appdata
			{
				float4 pos : POSITION;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float3 worldPos : TEXCOORD0;
			};

			v2f vert(appdata v)
			{
				v2f o;

				o.pos = UnityObjectToClipPos(v.pos);
				o.worldPos = mul(unity_ObjectToWorld, v.pos).xyz;

				return o;
			}

			fixed4 frag(v2f i) : COLOR
			{
				half accWeight = 0;

				for (int p=0; p<_Points_Length; p++)
				{
					half pDist = distance(i.worldPos, _Points[p].xyz);

					half pRad = _Properties[p].x; 
					half pWeight = 1 - saturate(pDist/pRad);

					accWeight += pWeight * _Properties[p].y;
				}

				half4 hmColor = tex2D(_HeatRampTex, fixed2(saturate(accWeight), 0.5));

				return hmColor;
			}

			ENDCG
		}
	}

	Fallback "Diffuse"
}