using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// This scripts allows to visualize the depth of the scene as a screen effect

[ExecuteInEditMode]
[RequireComponent (typeof(Camera))]
public class DepthRenderImage : MonoBehaviour {

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

	[Range(0.0f,1.0f)]
	public float depthPower = 1.0f;

	#endregion

	// Use this for initialization
	void Start ()
	{
		if (!SystemInfo.supportsImageEffects)
		{
			enabled = false;
			return;
		}

		if (!curShader && !curShader.isSupported)
		{
			enabled = false;
		}

		Camera.main.depthTextureMode = DepthTextureMode.Depth;
	}
	
	void Update ()
	{
		Camera.main.depthTextureMode = DepthTextureMode.Depth;
		depthPower = Mathf.Clamp(depthPower,0,5);
	}

	void OnRenderImage(RenderTexture srcTexture, RenderTexture dstTexture)
	{
		if (curShader != null)
		{
			material.SetFloat("_DepthPower", depthPower);
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
