Shader "SFS/DiffuseVFShadowReceiving" {
	
	// Shades the geometry using a simple diffuse Lambert lighting model including casting shadows to other objects
	// and receiving shadows from othe objects. It also provides the option to alter the color of the received shadows

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		[Toggle] _ChangeShadowColor ("Modify Shadow Color?", Float) = 0
		_ShadowColor ("Shadow Color", Color) = (1,0,0,1)
	}

	SubShader {

		Pass
		{
			Tags { "LightMode" = "ForwardBase" } // It's requeried to set the rendering mode (forward rendering in this case)
			
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertlight // All this is to specify we will be handling all the shadow stuff
																							 // Note that it should also work just with multi_compile_fwdbase which is the most relevant flag

			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"
			#include "Lighting.cginc"
			#include "Autolight.cginc"

			struct app_data
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION; // We have to rename this from 'vertex' to 'pos' because TRANSFER_SHADOWS expects that name for the vertex position
				float2 uv : TEXCOORD0;
				fixed4 diff : COLOR;
				SHADOW_COORDS(1)
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			fixed4 _ShadowColor;
			float _ChangeShadowColor;

			v2f vert(app_data v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				half3 worldNormal = UnityObjectToWorldNormal(v.normal); 		// We must convert the normal from object space to world space to be able to
				half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));	// compare it with the light's position which is in world space
				o.diff = nl * _LightColor0;

				TRANSFER_SHADOW(o)

				return o;
			}

			fixed4 frag(v2f i) : SV_TARGET
			{
				fixed4 color = tex2D(_MainTex, i.uv);
				fixed shadow = SHADOW_ATTENUATION(i);

				color.rgb *= i.diff * shadow + _ChangeShadowColor * (shadow < 0.25 ? _ShadowColor : 0); // This generates a little dark strip surrounding the shadow (more noticeable with soft shadows)
				// color.rgb *= i.diff + _ChangeShadowColor * (shadow < 1 ? _ShadowColor : 0); 			// In case we don't want to generate the dark strip

				return color;
			}

			ENDCG
		}

		Pass
		{
			Tags { "LightMode" = "ShadowCaster" }

			CGPROGRAM

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_shadowcaster

				#include "UnityCG.cginc"

				struct app_data
				{
					float4 vertex : POSITION;
					float3 normal : NORMAL;
					float4 uv : TEXCOORD0;
				};

				struct v2f
				{
					V2F_SHADOW_CASTER;
				};

				v2f vert(app_data v)
				{
					v2f o;
					TRANSFER_SHADOW_CASTER_NORMALOFFSET(o);

					return o;
				}

				fixed4 frag(v2f i) : SV_TARGET
				{
					SHADOW_CASTER_FRAGMENT(i);
				}

			ENDCG
		}
	}
}