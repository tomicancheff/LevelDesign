// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Acid"
{
	Properties
	{
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 15
		_Height("Height", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Height;
		uniform float _TessValue;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		float4 tessFunction( )
		{
			return _TessValue;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float2 temp_cast_0 = (0.02352941).xx;
			float2 temp_cast_1 = (1.0).xx;
			float2 temp_cast_2 = (11.0).xx;
			float2 uv_TexCoord18 = v.texcoord.xy * temp_cast_1 + temp_cast_2;
			float2 panner19 = ( 1.0 * _Time.y * temp_cast_0 + uv_TexCoord18);
			float simplePerlin2D17 = snoise( panner19*4.0 );
			simplePerlin2D17 = simplePerlin2D17*0.5 + 0.5;
			float NoiseHeight26 = simplePerlin2D17;
			float3 lerpResult24 = lerp( float3( 0,0,0 ) , ( float3(0,1,0) * _Height ) , NoiseHeight26);
			v.vertex.xyz += lerpResult24;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color8 = IsGammaSpace() ? float4(0.3005355,0.764151,0.01802243,0) : float4(0.07350438,0.5448383,0.001394925,0);
			float4 color9 = IsGammaSpace() ? float4(0.06004083,0.2641509,0.008721969,0) : float4(0.004900483,0.05672633,0.000675075,0);
			float2 temp_cast_0 = (0.02352941).xx;
			float2 temp_cast_1 = (1.0).xx;
			float2 temp_cast_2 = (11.0).xx;
			float2 uv_TexCoord18 = i.uv_texcoord * temp_cast_1 + temp_cast_2;
			float2 panner19 = ( 1.0 * _Time.y * temp_cast_0 + uv_TexCoord18);
			float simplePerlin2D17 = snoise( panner19*4.0 );
			simplePerlin2D17 = simplePerlin2D17*0.5 + 0.5;
			float NoiseHeight26 = simplePerlin2D17;
			float4 lerpResult7 = lerp( color8 , color9 , NoiseHeight26);
			o.Emission = lerpResult7.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
110;444;1267;547;1611.903;-165.4034;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;25;-2081.161,-288.0215;Inherit;False;1199.708;465.2845;Noise;8;26;18;22;21;17;23;19;31;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-2030.989,-138.5135;Inherit;False;Constant;_Float1;Float 1;2;0;Create;True;0;0;0;False;0;False;11;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-2031.161,-223.9209;Inherit;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1881.977,-27.35822;Inherit;False;Constant;_Float3;Float 3;2;0;Create;True;0;0;0;False;0;False;0.02352941;0;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-1834.836,-238.0215;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-1498.989,50.48649;Inherit;False;Constant;_Float2;Float 2;2;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;19;-1546.836,-92.02154;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;14;-1240.29,358.6141;Inherit;False;252;479.9106;Nodos a usar;3;2;5;6;;1,1,1,1;0;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;17;-1320.26,11.62749;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1177.218,722.5247;Inherit;False;Property;_Height;Height;5;0;Create;True;0;0;0;False;0;False;1;0.32;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;5;-1179.911,560.3919;Inherit;False;Constant;_DireccionY;DireccionY;0;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;26;-1105.201,9.776443;Inherit;False;NoiseHeight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;29;-484.9871,-42.63686;Inherit;False;26;NoiseHeight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;9;-507.3354,-254.8068;Inherit;False;Constant;_Color1;Color 1;1;0;Create;True;0;0;0;False;0;False;0.06004083,0.2641509,0.008721969,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-812.5408,428.2481;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;28;-671.426,550.6942;Inherit;False;26;NoiseHeight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;8;-503.5355,-427.2068;Inherit;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;0;False;0;False;0.3005355,0.764151,0.01802243,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;24;-372.4683,318.1769;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;2;-1190.29,408.6143;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;7;-148.4667,-163.3003;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Acid;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;1;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;18;0;21;0
WireConnection;18;1;22;0
WireConnection;19;0;18;0
WireConnection;19;2;31;0
WireConnection;17;0;19;0
WireConnection;17;1;23;0
WireConnection;26;0;17;0
WireConnection;16;0;5;0
WireConnection;16;1;6;0
WireConnection;24;1;16;0
WireConnection;24;2;28;0
WireConnection;7;0;8;0
WireConnection;7;1;9;0
WireConnection;7;2;29;0
WireConnection;0;2;7;0
WireConnection;0;11;24;0
ASEEND*/
//CHKSM=F74AA2E78FD2EDA11844965885E53FB3A4A1B443