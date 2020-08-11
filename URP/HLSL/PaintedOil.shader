Shader "Unlit/PaintedOil"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}

        _InputImage("Texture", 2D) = "white" {}
        _Noise("Texture Noise", 2D)= "white" {}
        _NoiseFactor ("Noise factor", Float) = 0.5 

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _InputImage;
            sampler2D _Noise;
            float _NoiseFactor;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                float4 noise = tex2D(_Noise, i.uv);
                i.uv.x *= -1;
                i.uv.y *= -1;
                float2 noiseUV = noise.xy;

                float4 dogImage = tex2D(_InputImage ,i.uv + (noiseUV * _NoiseFactor));
                // apply fog

                return dogImage;

                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
