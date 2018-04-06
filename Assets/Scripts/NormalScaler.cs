using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class NormalPlay : MonoBehaviour {

	public Vector3 normal = new Vector3(0,1,0);

	[Range(1.0f, 10.0f)]
	public float xmod = 1;

	[Range(1.0f, 10.0f)]
	public float ymod = 1;

	[Range(1.0f, 10.0f)]
	public float zmod = 1;


	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update ()
	{
		Vector3 result = new Vector3(normal.x * xmod, normal.y * ymod, normal.z * zmod);
		Debug.DrawRay(this.transform.position, result, Color.red);
	}
}
