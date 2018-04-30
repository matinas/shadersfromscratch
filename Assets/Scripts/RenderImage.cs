using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// This scripts allows to implement a grayscale screen effect

[ExecuteInEditMode]
public class RenderImage : MonoBehaviour {

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
	public float grayScaleAmount = 1.0f;

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
	}
	
	// Update is called once per frame
	void Update ()
	{
		grayScaleAmount = Mathf.Clamp(grayScaleAmount,0.0f,1.0f);
	}

	void OnRenderImage(RenderTexture srcTexture, RenderTexture dstTexture)
	{
		if (curShader != null)
		{
			material.SetFloat("_LuminosityAmount", grayScaleAmount);
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
