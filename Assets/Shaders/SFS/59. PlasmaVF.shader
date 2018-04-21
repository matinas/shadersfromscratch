Shader "SFS/PlasmaVF" {
	
	// Shades the geometry with RGB coloured psychodelic circular patterns (akin a plasma effect) using a VF shader

	Properties
	{
		_Tint ("Main Color", Color) = (1,1,1,1)
		_Speed ("Speed", Range(0,5)) = 1
		_Scale1 ("Scale 1", Range(0,5)) = 1
		_Scale2 ("Scale 2", Range(0,5)) = 1
		_Scale3 ("Scale 3", Range(0,5)) = 1
		_Scale4 ("Scale 4", Range(0,5)) = 1
	}

	SubShader {

		Pass
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			fixed4 _Tint;
			float _Speed, _Scale1, _Scale2, _Scale3, _Scale4;

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 worldPos : TEXCOORD0;
			};

			v2f vert(in appdata_base v)
			{
				v2f o;

				o.vertex = UnityObjectToClipPos(v.vertex);
				o.worldPos = v.vertex;

				return o;
			}

			fixed4 frag(v2f i) : SV_TARGET
			{
				float t = _Time.y * _Speed;
				float c=0;

				c += sin(i.worldPos.x * _Scale1 + t);									// vertical movement (involves x)
				c += sin(i.worldPos.z * _Scale2 + t);									// horizontal movement (involves z)
				c += sin(_Scale3 * (i.worldPos.x*sin(t/2) + i.worldPos.z*sin(t/3))+t); 	// circular patterns (involves x and z)

				float c1 = pow(i.worldPos.x + 0.5*sin(t/5),2); 							// and even more circular movement
				float c2 = pow(i.worldPos.z + 0.5*cos(t/3),2);
				c += sin(sqrt(_Scale4*(c1+c2)+1+t));

				fixed4 color = float4(sin((c/4)*UNITY_PI + UNITY_PI/4), sin((c/4)*UNITY_PI + UNITY_PI/2), sin((c/4)*UNITY_PI + UNITY_PI), 1);

				return color * _Tint;
			}

			// In case we would want to use the screen space coords instead of world position to colour fragments...
			
			// fixed4 frag (v2f i) : SV_Target
			// {
	        //     float t = _Time.y * _Speed;

	        //     float xpos = i.vertex.x * 0.01; // these are screen coordinates so get them down to small values for the sin to use
	        //     float ypos = i.vertex.y * 0.01;
	          
	        //     float c = sin(xpos * _Scale1 + t);						// vertical movement (involves x)
	        //     c += sin(ypos * _Scale2 + t);							// horizontal movement (involves z)
	        //     c += sin(_Scale3*(xpos*sin(t/2) + ypos*cos(t/3))+t);	// circular patterns (involves x and z)

	        //     float c1 = pow(xpos + 0.5 * sin(t/5),2);				// and even more circular movement
	        //     float c2 = pow(ypos + 0.5 * cos(t/3),2);
	        //     c += sin(sqrt(_Scale4*(c1 + c2)+1+t));

			// 	fixed4 color = float4(sin((c/4)*UNITY_PI + UNITY_PI/4), sin((c/4)*UNITY_PI + UNITY_PI/2), sin((c/4)*UNITY_PI + UNITY_PI), 1);

			// 	return color * _Tint;
			// }

			ENDCG
		}
	}
}