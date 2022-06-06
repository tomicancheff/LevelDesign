// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ToonShading"
{
	Properties
	{
		_Step3Intensity("Step 3 Intensity", Range( 0 , 1)) = 0
		_Step2Intensity("Step 2 Intensity", Range( 0 , 1)) = 0
		_Step1("Step 1", Range( 0 , 1)) = 0.6869891
		_Step2("Step2", Range( 0 , 1)) = 0.6869891
		_Step3("Step3", Range( 0 , 1)) = 0.6869891
		_ShadowIntensity("ShadowIntensity", Float) = 0
		_HatchingMin("HatchingMin", Range( 0 , 1)) = 0
		_HatchingMax("HatchingMax", Range( 0 , 1)) = 0
		_HatchingTex("HatchingTex", 2D) = "white" {}
		_HatchingTiling("HatchingTiling", Float) = 0
		_HatchingIntensity("HatchingIntensity", Range( 0 , 1)) = 0
		_LightAttenuation("LightAttenuation", Range( 0 , 1)) = 0.5
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			float3 worldPos;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _Step1;
		uniform float _Step2;
		uniform float _Step2Intensity;
		uniform float _Step3;
		uniform float _Step3Intensity;
		uniform float _ShadowIntensity;
		uniform float _LightAttenuation;
		uniform float _HatchingMin;
		uniform float _HatchingMax;
		uniform sampler2D _HatchingTex;
		uniform float _HatchingTiling;
		uniform float _HatchingIntensity;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult6 = dot( ase_worldNormal , ase_worldlightDir );
			float temp_output_8_0 = (dotResult6*0.5 + 0.5);
			float temp_output_22_0 = ( ( 1.0 - step( temp_output_8_0 , _Step1 ) ) + saturate( ( ( 1.0 - step( temp_output_8_0 , _Step2 ) ) - ( 1.0 - _Step2Intensity ) ) ) + saturate( ( ( 1.0 - step( temp_output_8_0 , _Step3 ) ) - ( 1.0 - _Step3Intensity ) ) ) );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float smoothstepResult40 = smoothstep( _HatchingMin , _HatchingMax , temp_output_8_0);
			float2 temp_cast_1 = (_HatchingTiling).xx;
			float2 uv_TexCoord47 = i.uv_texcoord * temp_cast_1;
			float Hatching60 = ( ( 1.0 - smoothstepResult40 ) * tex2D( _HatchingTex, uv_TexCoord47 ).r * _HatchingIntensity );
			float4 temp_cast_2 = (Hatching60).xxxx;
			c.rgb = ( ( tex2D( _TextureSample0, uv_TextureSample0 ) * float4( ( saturate( ( saturate( temp_output_22_0 ) + ( 1.0 - ( ( 1.0 - ceil( temp_output_22_0 ) ) * _ShadowIntensity ) ) ) ) * ase_lightColor.rgb * ase_lightColor.a * saturate( ( ase_lightAtten + _LightAttenuation ) ) ) , 0.0 ) ) - temp_cast_2 ).rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
8;549;1517;482;-762.5514;248.2044;2.0539;True;False
Node;AmplifyShaderEditor.CommentaryNode;7;-1065.166,208.8319;Inherit;False;532.3618;388.6422;Light Direction;3;2;3;6;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;10;-527.5082,207.38;Inherit;False;487.5653;310.2295;Half Lambert;2;9;8;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;3;-1015.166,414.4745;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;2;-978.2915,258.9635;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;9;-477.5082,401.6095;Inherit;False;Constant;_HalfLambert;HalfLambert;0;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;29;-39.10844,759.0804;Inherit;False;997.642;273.2027;Third Step;7;23;24;25;26;27;28;31;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;6;-767.8038,258.8319;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;15;-23.6844,474.2121;Inherit;False;951.8243;264.0964;Second Step;7;21;19;18;16;20;17;30;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-10.69403,826.251;Inherit;False;Property;_Step3;Step3;4;0;Create;True;0;0;0;False;0;False;0.6869891;0.53;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;8;-256.9429,257.38;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-23.1468,557.2133;Inherit;False;Property;_Step2;Step2;3;0;Create;True;0;0;0;False;0;False;0.6869891;0.77;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;14;-23.0146,201.5309;Inherit;False;644.6243;247.1964;First Step;3;11;12;13;;1,1,1,1;0;0
Node;AmplifyShaderEditor.StepOpNode;24;317.2571,809.0804;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;180.4548,666.9488;Inherit;False;Property;_Step2Intensity;Step 2 Intensity;1;0;Create;True;0;0;0;False;0;False;0;0.53;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;16;308.4984,540.2463;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;117.3784,936.0812;Inherit;False;Property;_Step3Intensity;Step 3 Intensity;0;0;Create;True;0;0;0;False;0;False;0;0.74;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;25;442.895,809.0804;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;31;473.2684,941.4128;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;26.98541,332.7273;Inherit;False;Property;_Step1;Step 1;2;0;Create;True;0;0;0;False;0;False;0.6869891;0.9;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;30;501.281,671.5529;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;18;435.96,542.0699;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;11;316.9718,251.5309;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;19;658.9752,541.749;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;623.5336,809.2831;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;27;793.5334,811.2831;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;13;442.6098,249.3309;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;21;784.7756,542.449;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;22;994.2178,389.3031;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;63;1278.369,470.2384;Inherit;False;647.9268;266.8999;Shadow;5;67;35;36;34;33;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CeilOpNode;33;1322.788,524.4245;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;49;-605.0283,1084.621;Inherit;False;1478.735;506.1903;Hatching;10;48;60;44;46;40;41;45;47;43;62;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;36;1427.969,628.1151;Inherit;False;Property;_ShadowIntensity;ShadowIntensity;5;0;Create;True;0;0;0;False;0;False;0;0.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;34;1461.169,523.6383;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-353.7387,1154.376;Inherit;False;Property;_HatchingMin;HatchingMin;6;0;Create;True;0;0;0;False;0;False;0;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;1625.865,522.2383;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-354.1935,1240.163;Inherit;False;Property;_HatchingMax;HatchingMax;7;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-555.0283,1404.629;Inherit;False;Property;_HatchingTiling;HatchingTiling;9;0;Create;True;0;0;0;False;0;False;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;56;1624.354,755.9747;Inherit;False;867.3982;386.3354;Light Color & Intensity;6;50;51;53;54;55;52;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;67;1769.151,522.9349;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-340.5478,1379.77;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightAttenuation;52;1727.861,944.4954;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;32;1473.207,388.0846;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;53;1672.879,1026.31;Inherit;False;Property;_LightAttenuation;LightAttenuation;11;0;Create;True;0;0;0;False;0;False;0.5;0.46;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;40;-34.68335,1153.262;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;44;156.4901,1154.292;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;54;1997.89,965.0344;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;45;-37.93167,1305.383;Inherit;True;Property;_HatchingTex;HatchingTex;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;62;7.898958,1514.396;Inherit;False;Property;_HatchingIntensity;HatchingIntensity;10;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;37;1937.865,396.9559;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;38;2162.596,396.4464;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;51;2076.514,805.9747;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;385.2577,1211.897;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;55;2139.963,965.236;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;60;668.0399,1207.897;Inherit;False;Hatching;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;66;2247.306,20.56338;Inherit;True;Property;_TextureSample0;Texture Sample 0;12;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;2329.752,805.975;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;77;1117.148,-387.8084;Inherit;False;832.3956;536.8828;Para poner una textura en luz y otra en oscuridad;5;76;72;73;74;75;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;2593.109,567.5475;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;2630.613,805.7313;Inherit;False;60;Hatching;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;1787.544,-66.91561;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;75;1621.447,-106.6266;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;71;2889.153,559.483;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;73;1251.858,-337.8084;Inherit;True;Property;_TextureSample2;Texture Sample 2;13;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;72;1167.148,38.07433;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;74;1252.166,-147.6756;Inherit;True;Property;_TextureSample3;Texture Sample 3;14;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3165.044,321.8253;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;ToonShading;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;2;0
WireConnection;6;1;3;0
WireConnection;8;0;6;0
WireConnection;8;1;9;0
WireConnection;8;2;9;0
WireConnection;24;0;8;0
WireConnection;24;1;28;0
WireConnection;16;0;8;0
WireConnection;16;1;17;0
WireConnection;25;0;24;0
WireConnection;31;0;23;0
WireConnection;30;0;20;0
WireConnection;18;0;16;0
WireConnection;11;0;8;0
WireConnection;11;1;12;0
WireConnection;19;0;18;0
WireConnection;19;1;30;0
WireConnection;26;0;25;0
WireConnection;26;1;31;0
WireConnection;27;0;26;0
WireConnection;13;0;11;0
WireConnection;21;0;19;0
WireConnection;22;0;13;0
WireConnection;22;1;21;0
WireConnection;22;2;27;0
WireConnection;33;0;22;0
WireConnection;34;0;33;0
WireConnection;35;0;34;0
WireConnection;35;1;36;0
WireConnection;67;0;35;0
WireConnection;47;0;48;0
WireConnection;32;0;22;0
WireConnection;40;0;8;0
WireConnection;40;1;41;0
WireConnection;40;2;43;0
WireConnection;44;0;40;0
WireConnection;54;0;52;0
WireConnection;54;1;53;0
WireConnection;45;1;47;0
WireConnection;37;0;32;0
WireConnection;37;1;67;0
WireConnection;38;0;37;0
WireConnection;46;0;44;0
WireConnection;46;1;45;1
WireConnection;46;2;62;0
WireConnection;55;0;54;0
WireConnection;60;0;46;0
WireConnection;50;0;38;0
WireConnection;50;1;51;1
WireConnection;50;2;51;2
WireConnection;50;3;55;0
WireConnection;57;0;66;0
WireConnection;57;1;50;0
WireConnection;76;0;75;0
WireConnection;75;0;73;0
WireConnection;75;1;74;0
WireConnection;75;2;72;0
WireConnection;71;0;57;0
WireConnection;71;1;61;0
WireConnection;0;13;71;0
ASEEND*/
//CHKSM=54C4478C447AAA65BB1579348B75A1792ECD417C