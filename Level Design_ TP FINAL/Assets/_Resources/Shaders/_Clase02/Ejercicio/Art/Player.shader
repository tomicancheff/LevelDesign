// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Player"
{
	Properties
	{
		_Shorts("Shorts", 2D) = "white" {}
		_Socks("Socks", 2D) = "white" {}
		_Shirt("Shirt", 2D) = "white" {}
		_ColorA("Color A", Color) = (0,0,0,0)
		_ColorB("Color B", Color) = (0,0,0,0)
		_ColorC("Color C", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _ColorA;
		uniform sampler2D _Shirt;
		uniform float4 _Shirt_ST;
		uniform float4 _ColorB;
		uniform float4 _ColorC;
		uniform sampler2D _Shorts;
		uniform float4 _Shorts_ST;
		uniform sampler2D _Socks;
		uniform float4 _Socks_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 A62 = _ColorA;
			float2 uv_Shirt = i.uv_texcoord * _Shirt_ST.xy + _Shirt_ST.zw;
			float4 break16 = ( tex2D( _Shirt, uv_Shirt ) * i.vertexColor.r );
			float4 B66 = _ColorB;
			float4 C70 = _ColorC;
			float2 uv_Shorts = i.uv_texcoord * _Shorts_ST.xy + _Shorts_ST.zw;
			float4 break18 = ( tex2D( _Shorts, uv_Shorts ) * i.vertexColor.g );
			float2 uv_Socks = i.uv_texcoord * _Socks_ST.xy + _Socks_ST.zw;
			float4 break19 = ( tex2D( _Socks, uv_Socks ) * i.vertexColor.b );
			o.Albedo = saturate( ( saturate( ( ( A62 * break16.r ) + ( B66 * break16.g ) + ( C70 * break16.b ) ) ) + saturate( ( ( A62 * break18.r ) + ( B66 * break18.g ) + ( C70 * break18.b ) ) ) + saturate( ( ( A62 * break19.r ) + ( B66 * break19.g ) + ( C70 * break19.b ) ) ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
11;436;1448;555;839.3829;174.3643;1.44016;True;True
Node;AmplifyShaderEditor.VertexColorNode;7;-1249.08,160.381;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-832.0014,574.3165;Inherit;True;Property;_Socks;Socks;1;0;Create;True;0;0;0;False;0;False;-1;None;1fcbb574a32d32f4792d2d98c2c21d37;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-828.048,162.4723;Inherit;True;Property;_Shorts;Shorts;0;0;Create;True;0;0;0;False;0;False;-1;None;1fcbb574a32d32f4792d2d98c2c21d37;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-820.0287,-168.5057;Inherit;True;Property;_Shirt;Shirt;2;0;Create;True;0;0;0;False;0;False;-1;None;1fcbb574a32d32f4792d2d98c2c21d37;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-371.0845,216.4111;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-410.2177,-92.42832;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;5;-634.3259,-671.827;Inherit;False;Property;_ColorB;Color B;4;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.9245283,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;4;-631.6766,-847.6594;Inherit;False;Property;_ColorA;Color A;3;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0.73295,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-626.3644,-486.9136;Inherit;False;Property;_ColorC;Color C;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.4327459,0,0.9716981,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-440.0487,566.7146;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;16;-183.1907,-94.68723;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;18;-147.4232,215.5973;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;62;-425.9308,-846.7389;Inherit;False;A;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;70;-412.3992,-484.6602;Inherit;False;C;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;19;-195.2604,574.4506;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;66;-422.0103,-669.9619;Inherit;False;B;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;64;47.43137,95.3252;Inherit;False;62;A;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;67;4.063313,-261.5192;Inherit;False;66;B;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;28;36.11965,-173.3839;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;48.4951,-89.78219;Inherit;False;70;C;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;29;66.18844,7.708619;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;63;-88.3049,-446.7052;Inherit;False;62;A;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;27;-8.419853,-354.3951;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;44;239.456,299.6224;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;68;214.2703,225.4316;Inherit;False;66;B;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;43;57.67729,193.5504;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;329.2804,806.5323;Inherit;False;70;C;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;53;177.0013,748.5051;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;69;144.2564,656.9515;Inherit;False;66;B;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;52;8.417485,589.405;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;65;-15.118,499.7742;Inherit;False;62;A;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;45;425.3872,422.0044;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;72;414.2752,330.0511;Inherit;False;70;C;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RelayNode;54;352.1069,916.607;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;145.3842,519.9998;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;116.2162,-440.027;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;224.7886,110.6748;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;245.7283,-84.09;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;582.1543,352.345;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;498.909,811.2581;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;393.9216,230.8655;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;211.7655,-258.4365;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;319.6265,663.1031;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;58;684.7106,641.0187;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;49;747.4392,113.2027;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;39;494.757,-279.295;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;41;691.9111,-275.3562;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;50;911.8444,112.7588;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;59;877.031,638.8337;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;51;1227.368,60.52662;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;60;1358.642,58.6987;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1522.401,57.88897;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Player;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;1;0
WireConnection;9;1;7;2
WireConnection;10;0;3;0
WireConnection;10;1;7;1
WireConnection;8;0;2;0
WireConnection;8;1;7;3
WireConnection;16;0;10;0
WireConnection;18;0;9;0
WireConnection;62;0;4;0
WireConnection;70;0;6;0
WireConnection;19;0;8;0
WireConnection;66;0;5;0
WireConnection;28;0;16;1
WireConnection;29;0;16;2
WireConnection;27;0;16;0
WireConnection;44;0;18;1
WireConnection;43;0;18;0
WireConnection;53;0;19;1
WireConnection;52;0;19;0
WireConnection;45;0;18;2
WireConnection;54;0;19;2
WireConnection;56;0;65;0
WireConnection;56;1;52;0
WireConnection;36;0;63;0
WireConnection;36;1;27;0
WireConnection;46;0;64;0
WireConnection;46;1;43;0
WireConnection;40;0;71;0
WireConnection;40;1;29;0
WireConnection;48;0;72;0
WireConnection;48;1;45;0
WireConnection;55;0;73;0
WireConnection;55;1;54;0
WireConnection;47;0;68;0
WireConnection;47;1;44;0
WireConnection;38;0;67;0
WireConnection;38;1;28;0
WireConnection;57;0;69;0
WireConnection;57;1;53;0
WireConnection;58;0;56;0
WireConnection;58;1;57;0
WireConnection;58;2;55;0
WireConnection;49;0;46;0
WireConnection;49;1;47;0
WireConnection;49;2;48;0
WireConnection;39;0;36;0
WireConnection;39;1;38;0
WireConnection;39;2;40;0
WireConnection;41;0;39;0
WireConnection;50;0;49;0
WireConnection;59;0;58;0
WireConnection;51;0;41;0
WireConnection;51;1;50;0
WireConnection;51;2;59;0
WireConnection;60;0;51;0
WireConnection;0;0;60;0
ASEEND*/
//CHKSM=43E8BE70EF4C3F83B62C969DF73A7495F6B00188