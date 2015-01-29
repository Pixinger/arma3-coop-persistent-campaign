private["_result"];
_result = [
	/* Goggles */
	"",//G_Tactical_Clear
	
	/* Headgear */
	"H_HelmetB_light",
	
	/* Binoculars */
	"AGM_Vector",
	
	/* Nightvision */
	"NVGoggles",
	
	/* Linked Items */
	[
		"ItemMap",
		"ItemWatch",
		"ItemCompass",
		"ItemGps"
	],
	
	/* Primary Weapon */
	[
		"arifle_MXC_ACO_pointer_snds_F",
		/* Primary weapon Magazine */
		"30Rnd_65x39_caseless_mag",
		/* Primary Weapon Items */
		["optic_Arco"]
	],
	
	/* Secondary Weapon */
	[
		"",
		/* Secondary weapon Magazine */
		"",
		/* Secondary Weapon Items */
		[]
	],
	
	/* Handgun Weapon */
	[
		"hgun_P07_snds_F",
		/* Handgun Weapon Magazine */
		"16Rnd_9x21_Mag",
		/* Handgun Weapon Items */
		[]
	],
	
	/* Uniform */
	[
		"U_B_CombatUniform_mcam_tshirt", 
		/* Uniform-Weapons */
		[], 
		/* Uniform-Magazines */
		[
		],
		/* Uniform-Items */
		[
			"ItemRadio",
			"AGM_Epipen","AGM_Epipen","AGM_Epipen",
			"AGM_Bandage","AGM_Bandage","AGM_Bandage","AGM_Bandage",
			"AGM_Morphine","AGM_Morphine","AGM_Morphine","AGM_Morphine",			
			"AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie"			
		]
	],
	
	/* Vest */
	[
		"V_Chestrig_rgr", //V_PlateCarrier1_rgr
		/* Vest-Weapons */
		[
			"SmokeShell","SmokeShell",
			"SmokeShellPurple","SmokeShellPurple",
			"SmokeShellGreen","SmokeShellGreen"
		], 
		/* Vest-Magazines */
		[
			"AGM_Bandage","AGM_Bandage","AGM_Bandage","AGM_Bandage",
			"MiniGrenade","MiniGrenade","MiniGrenade","MiniGrenade",
			"30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag",
			"16Rnd_9x21_Mag","16Rnd_9x21_Mag"
		],
		/* Vest-Items */
		[
		]
	],
	
	/* Backpack */
	[
		"B_Bergen_sgg", //tf_rt1523g_rhs
		/* Backpack-Weapons */
		[
		], 
		/* Backpack-Magazines */
		[
			"SatchelCharge_Remote_Mag",
			"DemoCharge_Remote_Mag"
		],
		/* Backpack-Items */
		[
			"MineDetector",
			"ToolKit"
		]
	],
	
	/* Code */
	"_unit setVariable ['AGM_IsEOD', true];"
];

_result;