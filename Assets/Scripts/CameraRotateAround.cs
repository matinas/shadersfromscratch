using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraRotateAround : MonoBehaviour {

	[SerializeField]
	[Tooltip("Set the speed of the rotation")]
	private float speed;

	[SerializeField]
	[Tooltip("Set the distance from the object to rotate around")]
	private float distance;

	[SerializeField]
	[Tooltip("Set the object around which the camera will rotate")]
	private Transform target;

	private Vector3 center;

	// Use this for initialization
	void Start ()
	{
		distance = transform.position.z - target.position.z;
	}
	
	// Update is called once per frame
	void Update ()
	{
		transform.Translate(new Vector3(0,0,distance));
		transform.Rotate(target.up, speed * Time.deltaTime);
		transform.Translate(new Vector3(0,0,-distance));
	}
}
