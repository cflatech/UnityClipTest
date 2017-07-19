using UnityEngine;
using System.Collections;

public class clip : MonoBehaviour {
    Renderer rend;
    Material mat;
    float th = 0;
    float speed = 0.01f;

	// Use this for initialization
	void Start () {
        rend = this.GetComponent<Renderer>();
        mat = rend.material;
	}
	
	// Update is called once per frame
	void Update () {
        th += speed;
        mat.SetFloat("_Th", th);
        if(Mathf.Abs(th) > 1)
        {
            speed = -speed;
        }
	
	}
}
