using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// This scripts allows to implement a blur screen effect. Based on https://www.youtube.com/watch?v=kpBnIAPtsj8

[ExecuteInEditMode]
[RequireComponent (typeof(Camera))]
public class BlurRenderImage : MonoBehaviour {

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

	[Range(0,10)]
	public float blurAmount = 0;

	[Range(0,4)]
	public int downRes = 0;

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
	}
	
	void OnRenderImage(RenderTexture srcTexture, RenderTexture dstTexture)
	{
		int width = srcTexture.width >> downRes;	// Downsample the width by a power of 2 given by downRes. NOTE: only tweaking this we should get some free blur...
		int height = srcTexture.height >> downRes;	// Downsample the height by a power of 2 given by downRes

		if (curShader != null)
		{
			RenderTexture rt = RenderTexture.GetTemporary(width, height);
			Graphics.Blit(srcTexture,rt);

			for (int i=0; i<blurAmount; i++)
			{
				RenderTexture rt2 = RenderTexture.GetTemporary(rt.width, rt.height);
				Graphics.Blit(rt, rt2, material);
				RenderTexture.ReleaseTemporary(rt);
				rt = rt2;
			}

			Graphics.Blit(rt,dstTexture);
			RenderTexture.ReleaseTemporary(rt);
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
