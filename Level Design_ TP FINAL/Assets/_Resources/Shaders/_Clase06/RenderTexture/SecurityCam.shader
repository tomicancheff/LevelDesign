// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SecurityCam"
{
	Properties
	{
		_Camera("Camera", 2D) = "white" {}
		_NoiseDensity2("NoiseDensity2", Range( 0 , 1)) = 0.4450203
		_SpeedNoise2("SpeedNoise2", Vector) = (0,1,0,0)
		_Tiling2("Tiling2", Range( 0 , 1)) = 0.6
		_SpeedNoise1("SpeedNoise1", Float) = 10
		_PixelRes("PixelRes", Float) = 2

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform sampler2D _Camera;
			uniform float _PixelRes;
			uniform float3 _SpeedNoise2;
			uniform float _SpeedNoise1;
			uniform float _Tiling2;
			uniform float _NoiseDensity2;
			float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }
			float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }
			float snoise( float3 v )
			{
				const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
				float3 i = floor( v + dot( v, C.yyy ) );
				float3 x0 = v - i + dot( i, C.xxx );
				float3 g = step( x0.yzx, x0.xyz );
				float3 l = 1.0 - g;
				float3 i1 = min( g.xyz, l.zxy );
				float3 i2 = max( g.xyz, l.zxy );
				float3 x1 = x0 - i1 + C.xxx;
				float3 x2 = x0 - i2 + C.yyy;
				float3 x3 = x0 - 0.5;
				i = mod3D289( i);
				float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
				float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
				float4 x_ = floor( j / 7.0 );
				float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
				float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 h = 1.0 - abs( x ) - abs( y );
				float4 b0 = float4( x.xy, y.xy );
				float4 b1 = float4( x.zw, y.zw );
				float4 s0 = floor( b0 ) * 2.0 + 1.0;
				float4 s1 = floor( b1 ) * 2.0 + 1.0;
				float4 sh = -step( h, 0.0 );
				float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
				float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
				float3 g0 = float3( a0.xy, h.x );
				float3 g1 = float3( a0.zw, h.y );
				float3 g2 = float3( a1.xy, h.z );
				float3 g3 = float3( a1.zw, h.w );
				float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
				g0 *= norm.x;
				g1 *= norm.y;
				g2 *= norm.z;
				g3 *= norm.w;
				float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
				m = m* m;
				m = m* m;
				float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
				return 42.0 * dot( m, px);
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				o.ase_texcoord2 = v.vertex;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				float4 color3 = IsGammaSpace() ? float4(0.3025543,0.3490566,0.2584995,0) : float4(0.07451008,0.09992068,0.05434537,0);
				float2 texCoord55 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_60_0 = ( _PixelRes * float2( 16,9 ) );
				float4 temp_output_2_0 = ( color3 * tex2D( _Camera, ( ceil( ( texCoord55 * temp_output_60_0 ) ) / temp_output_60_0 ) ) );
				float mulTime46 = _Time.y * _SpeedNoise1;
				float2 _Resolution2 = float2(16,9);
				float3 appendResult48 = (float3(_Resolution2.x , 0.0 , _Resolution2.y));
				float simplePerlin3D42 = snoise( ( ( _SpeedNoise2 * mulTime46 ) + ( i.ase_texcoord2.xyz * _Tiling2 * appendResult48 ) ) );
				simplePerlin3D42 = simplePerlin3D42*0.5 + 0.5;
				float4 temp_cast_0 = (( simplePerlin3D42 * _NoiseDensity2 )).xxxx;
				
				
				finalColor = saturate( ( temp_output_2_0 - temp_cast_0 ) );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
0;433;1365;566;3807.163;1259.762;4.417155;True;False
Node;AmplifyShaderEditor.CommentaryNode;62;-2136.351,-469.8769;Inherit;False;845.2996;413.5275;Pixelation;7;55;60;59;61;56;57;58;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;47;-1316.65,-1288.559;Inherit;False;1147.948;722.975;VertexNoise;13;50;42;51;44;41;45;39;48;43;46;40;49;54;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-2069.35,-301.3492;Inherit;False;Property;_PixelRes;PixelRes;6;0;Create;True;0;0;0;False;0;False;2;7.55;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;61;-2086.35,-220.3492;Inherit;False;Constant;_Vector0;Vector 0;6;0;Create;True;0;0;0;False;0;False;16,9;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;54;-1303.518,-1085.834;Inherit;False;Property;_SpeedNoise1;SpeedNoise1;5;0;Create;True;0;0;0;False;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;49;-1299.573,-714.2836;Inherit;False;Constant;_Resolution2;Resolution2;2;0;Create;True;0;0;0;False;0;False;16,9;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;55;-1975.814,-419.3072;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;-1899.349,-296.3492;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;46;-1144.05,-1080.722;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-1307.284,-851.2596;Inherit;False;Property;_Tiling2;Tiling2;4;0;Create;True;0;0;0;False;0;False;0.6;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;39;-1257.773,-1004.874;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-1737.482,-419.5767;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;48;-1132.833,-697.7359;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;43;-1263.964,-1240.873;Inherit;False;Property;_SpeedNoise2;SpeedNoise2;3;0;Create;True;0;0;0;False;0;False;0,1,0;0,1,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-1001.745,-1005.83;Inherit;True;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-993.9146,-1230.834;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CeilOpNode;57;-1585.149,-419.8767;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;44;-771.7295,-1230.759;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;58;-1443.049,-419.3428;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;5;-792.3754,-539.9903;Inherit;False;618.9988;480;BaseColor;3;3;1;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;3;-661.3756,-489.9903;Inherit;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;0;False;0;False;0.3025543,0.3490566,0.2584995,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;42;-563.5627,-1234.861;Inherit;True;Simplex3D;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-566.5298,-962.3574;Inherit;False;Property;_NoiseDensity2;NoiseDensity2;2;0;Create;True;0;0;0;False;0;False;0.4450203;0.121;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-742.3754,-289.9903;Inherit;True;Property;_Camera;Camera;0;0;Create;True;0;0;0;False;0;False;-1;None;21146dc1b4588d04fa4e9a2ff378e08b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-408.3767,-414.9903;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-302.5298,-1231.359;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;38;-2143.227,-47.09887;Inherit;False;1969.377;1122.002;QuadraNoise;27;7;9;27;8;15;12;20;31;25;6;22;10;29;21;13;4;14;30;19;18;16;17;35;28;34;11;24;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;52;-72.92146,-1024.079;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;-1392.017,891.9034;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PannerNode;29;-1309.529,756.7414;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-1629.246,899.2523;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;19;-1093.275,591.7198;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-1881.511,557.0009;Inherit;False;PanningSpeedVar;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;13;-1296.875,251.8847;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;31;-1588.964,756.2081;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;9;-1946.12,112.4935;Inherit;False;Constant;_Resolution;Resolution;2;0;Create;True;0;0;0;False;0;False;16,9;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1576.31,251.3513;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;30;-1066.192,750.6158;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;4;-1034.347,2.901135;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;53;78.83316,-1023.597;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;27;-1737.648,374.5446;Inherit;False;24;PanningSpeedVar;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-1616.048,597.3122;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;12.84805,-104.4578;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;14;-1053.537,245.759;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-704.4063,163.8652;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-1742.12,30.53532;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-2093.228,556.5281;Inherit;False;Constant;_PanningSpeed;PanningSpeed;2;0;Create;True;0;0;0;False;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;22;-1356.506,444.3724;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-630.8512,417.5463;Inherit;False;Constant;_NoiseQuantity;NoiseQuantity;2;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1950.12,28.49347;Inherit;False;Property;_NoiseTiling;NoiseTiling;1;0;Create;True;0;0;0;False;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;-1983.138,851.2494;Inherit;False;24;PanningSpeedVar;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1483.406,378.565;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1557.12,8.493477;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;21;-1336.613,597.8455;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;10;-1277.685,9.026804;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-1559.573,135.1567;Inherit;False;24;PanningSpeedVar;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;17;-408.8514,219.5464;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;795.9105,-345.3317;Float;False;True;-1;2;ASEMaterialInspector;100;1;SecurityCam;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;60;0;59;0
WireConnection;60;1;61;0
WireConnection;46;0;54;0
WireConnection;56;0;55;0
WireConnection;56;1;60;0
WireConnection;48;0;49;1
WireConnection;48;2;49;2
WireConnection;41;0;39;0
WireConnection;41;1;40;0
WireConnection;41;2;48;0
WireConnection;45;0;43;0
WireConnection;45;1;46;0
WireConnection;57;0;56;0
WireConnection;44;0;45;0
WireConnection;44;1;41;0
WireConnection;58;0;57;0
WireConnection;58;1;60;0
WireConnection;42;0;44;0
WireConnection;1;1;58;0
WireConnection;2;0;3;0
WireConnection;2;1;1;0
WireConnection;50;0;42;0
WireConnection;50;1;51;0
WireConnection;52;0;2;0
WireConnection;52;1;50;0
WireConnection;28;0;35;0
WireConnection;28;1;34;0
WireConnection;29;0;31;0
WireConnection;35;0;34;0
WireConnection;19;0;21;0
WireConnection;24;0;11;0
WireConnection;13;0;12;0
WireConnection;13;2;15;0
WireConnection;31;0;8;0
WireConnection;12;0;8;0
WireConnection;30;0;29;0
WireConnection;4;0;10;0
WireConnection;53;0;52;0
WireConnection;20;0;8;0
WireConnection;36;0;2;0
WireConnection;36;1;17;0
WireConnection;14;0;13;0
WireConnection;16;0;4;0
WireConnection;16;1;14;0
WireConnection;16;2;19;0
WireConnection;16;3;30;0
WireConnection;8;0;7;0
WireConnection;8;1;9;0
WireConnection;22;0;27;0
WireConnection;22;1;15;0
WireConnection;15;0;27;0
WireConnection;6;0;8;0
WireConnection;21;0;20;0
WireConnection;21;2;22;0
WireConnection;10;0;6;0
WireConnection;10;2;25;0
WireConnection;17;0;16;0
WireConnection;17;1;18;0
WireConnection;0;0;53;0
ASEEND*/
//CHKSM=75399277359E8E9516288DFB52DE83A5465AF78C