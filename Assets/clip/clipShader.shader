Shader "Custom/clipShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_Th("Th", Float) = 1.0
		//_Th("Th", Range(-1,1)) = 1.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		// addshadow追加
		#pragma surface surf Standard vertex:vert fullforwardshadows addshadow 
		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float3 localPos;
		};

		half _Glossiness;
		half _Metallic;
		float _Th;
		fixed4 _Color;

		//localPositionを取るための設定
		//http://answers.unity3d.com/questions/561900/get-local-position-in-surface-shader.html
		//からパクった
		void vert(inout appdata_full v, out Input o) {
			//頂点プログラムの出力の値を初期化
			UNITY_INITIALIZE_OUTPUT(Input, o);
			//localPos追加
			o.localPos = v.vertex.xyz;
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			//閾値以下のピクセルを削除
			if (IN.localPos.z < _Th) {
				clip(-1);
			}
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			//// Metallic and smoothness come from slider variables
			//o.Metallic = _Metallic;
			//o.Smoothness = _Glossiness;
			//o.Alpha = c.a;
			
		}
		ENDCG
	}
	FallBack "Diffuse"
}
