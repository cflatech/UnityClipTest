using UnityEngine;
using System.Collections;

public class clip : MonoBehaviour {
    Renderer rend;
    Material mat;
    float th;
    float speed = 0.01f;

	// Use this for initialization
	void Start () {
        rend = this.GetComponent<Renderer>();
        mat = rend.material;
        th = mat.GetFloat("_Th");
	}
	
	// Update is called once per frame
	void Update () {
        this.transform.localPosition = this.transform.localPosition - new Vector3(speed * 2, 0, 0);

        th += speed;
        mat.SetFloat("_Th", th);
        Debug.Log(Mathf.Abs(th));
        if(Mathf.Abs(th) > 0.5)
        {
            speed = -speed;
        }
	
	}
}
