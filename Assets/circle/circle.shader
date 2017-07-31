Shader "Custom/circle" {
	Properties {
		_Color("Color", Color) = (1,1,1,1) 
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard vertex:vert alpha:fade

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float3 worldPos;
			float3 localPos;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		void vert(inout appdata_full v, out Input o) {
			//頂点プログラムの出力の値を初期化
			UNITY_INITIALIZE_OUTPUT(Input, o);
			//localPos追加
			o.localPos = v.vertex.xyz;
		}

		//http://nn-hokuson.hatenablog.com/entry/2016/11/14/203745
		//参考文献
		void surf (Input IN, inout SurfaceOutputStandard o) {
			float dist = distance(fixed3(0, 0, 0), IN.localPos);
			float val = abs(sin(dist * 2 - _Time * 50));
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			//if (val > 0.98) {
			//	o.Albedo = (c * _Color1).rgb;
			//}
			//else {
			//	o.Albedo = (c * _Color2).rgb;
			//}
			if (dist > 5) {
				clip(-1);
			}
			o.Albedo = c.rgb;
			o.Alpha = val * 0.3 * (5 - dist);

			// Albedo comes from a texture tinted by color
			//fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color1;
			//o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			//o.Smoothness = _Glossiness;
			//o.Alpha = c.a;
		}
		ENDCG
	}
	//FallBack "Diffuse"
}
