// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Ejercicio4"
{
	Properties
	{
		_PatternRepetition("PatternRepetition", Float) = 0.4
		_Offset("Offset", Range( 0 , 2)) = 0
		_Width1("Width1", Range( -1 , 1)) = 0
		_Width2("Width2", Range( -1 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _Offset;
		uniform float _PatternRepetition;
		uniform float _Width1;
		uniform float _Width2;


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


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color5 = IsGammaSpace() ? float4(0,1,0,0) : float4(0,1,0,0);
			float4 color4 = IsGammaSpace() ? float4(1,0,0,0) : float4(1,0,0,0);
			float3 ase_worldPos = i.worldPos;
			float temp_output_15_0 = ( (ase_worldPos).x + _Offset );
			float2 temp_cast_0 = (temp_output_15_0).xx;
			float simplePerlin2D10 = snoise( temp_cast_0*_PatternRepetition );
			simplePerlin2D10 = simplePerlin2D10*0.5 + 0.5;
			float4 lerpResult7 = lerp( color5 , color4 , step( simplePerlin2D10 , _Width1 ));
			float4 color19 = IsGammaSpace() ? float4(0,0,1,0) : float4(0,0,1,0);
			float2 temp_cast_1 = (temp_output_15_0).xx;
			float simplePerlin2D29 = snoise( temp_cast_1*_PatternRepetition );
			simplePerlin2D29 = simplePerlin2D29*0.5 + 0.5;
			float4 lerpResult18 = lerp( lerpResult7 , color19 , step( simplePerlin2D29 , _Width2 ));
			o.Albedo = lerpResult18.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
1;438;681;560;1499.048;155.3138;1.882201;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-1567.57,31.20124;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;20;-1367.383,119.7981;Inherit;False;Property;_Offset;Offset;1;0;Create;True;0;0;0;False;0;False;0;0.35;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;14;-1343.114,27.24553;Inherit;False;True;False;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-1089.584,34.10094;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1351.633,347.0671;Inherit;False;Property;_PatternRepetition;PatternRepetition;0;0;Create;True;0;0;0;False;0;False;0.4;0.73;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;10;-854.7556,24.83135;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-811.3906,135.1743;Inherit;False;Property;_Width1;Width1;2;0;Create;True;0;0;0;False;0;False;0;0.67;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-766.8984,-190.7451;Inherit;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;5;-528.756,-323.3878;Inherit;False;Constant;_Color1;Color 1;1;0;Create;True;0;0;0;False;0;False;0,1,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;13;-532.5282,32.06695;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;29;-867.9058,320.1366;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-885.1086,450.6483;Inherit;False;Property;_Width2;Width2;3;0;Create;True;0;0;0;False;0;False;0;0.02;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;19;-368.6681,137.7754;Inherit;False;Constant;_Color2;Color 2;3;0;Create;True;0;0;0;False;0;False;0,0,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;7;-271.1837,-17.5803;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;28;-593.7596,323.643;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;18;-65.80672,268.1922;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;149.4428,270.8618;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Ejercicio4;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;1;0
WireConnection;15;0;14;0
WireConnection;15;1;20;0
WireConnection;10;0;15;0
WireConnection;10;1;9;0
WireConnection;13;0;10;0
WireConnection;13;1;30;0
WireConnection;29;0;15;0
WireConnection;29;1;9;0
WireConnection;7;0;5;0
WireConnection;7;1;4;0
WireConnection;7;2;13;0
WireConnection;28;0;29;0
WireConnection;28;1;31;0
WireConnection;18;0;7;0
WireConnection;18;1;19;0
WireConnection;18;2;28;0
WireConnection;0;0;18;0
ASEEND*/
//CHKSM=570D828E2B2122AC9E403EE1AEE83175BEC1BA80