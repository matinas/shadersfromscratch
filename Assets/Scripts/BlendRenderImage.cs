using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// This scripts allows to visualize the depth of the scene as a screen effect
// NOTE: it's not working 100% fine...

[ExecuteInEditMode]
[RequireComponent (typeof(Camera))]
public class BlendRenderImage : MonoBehaviour {

	#region Properties
	public Material material
	{
		get
		{
			if (curMaterial == null)
			{
				curMaterial = new Material(curShader);
				curMaterial.hideFlags = HideFlags.HideAndDontSave;
			}

			return curMaterial;
		}
	}
	#endregion

	#region Variables
	private Material curMaterial;
	public Shader curShader;

	public Texture2D blendTex;

	[Range(0,3)]
	public int blendMode;

	[Range(0.0f,1.0f)]
	public float opacity;

	#endregion

	// Use this for initialization
	void Start ()
	{
		if (!SystemInfo.supportsImageEffects)
		{
			enabled = false;
			return;
		}

		if (curShader && !curShader.isSupported)
		{
			enabled = false;
		}

		Camera.main.depthTextureMode = DepthTextureMode.Depth;
	}
	
	void Update ()
	{
		opacity = Mathf.Clamp(opacity, 0.0f, 1.0f);
	}

	void OnRenderImage(RenderTexture srcTexture, RenderTexture dstTexture)
	{
		if (curShader != null)
		{
			material.SetTexture("_BlendTex", blendTex);
			material.SetInt("_BlendMode", blendMode);
			material.SetFloat("_Opacity", opacity);

			Graphics.Blit(srcTexture,dstTexture,material);
		}
		else
			Graphics.Blit(srcTexture,dstTexture);
	}

	void OnDisable()
	{
		if (curMaterial)
		{
			DestroyImmediate(curMaterial);
		}
	}
}
