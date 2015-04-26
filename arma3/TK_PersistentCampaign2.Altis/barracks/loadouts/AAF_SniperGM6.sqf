private["_result"];
_result = [
	/* Goggles */
	"", //G_Tactical_Clear
	
	/* Headgear */
	"H_MilCap_dgtl",
	
	/* Binoculars */
	"LaserDesignator",
	
	/* Nightvision */
	"NVGoggles_INDEP",
	
	/* Linked Items */
	[
		"ItemMap",
		"ItemWatch",
		"ItemCompass",
		"ItemGps"
	],
	
	/* Primary Weapon */
	[
		"srifle_GM6_SOS_F",
		/* Primary weapon Magazine */
		"5Rnd_127x108_Mag",
		/* Primary Weapon Items */
		[]
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
		"hgun_ACPC2_F",
		/* Handgun Weapon Magazine */
		"9Rnd_45ACP_Mag",
		/* Handgun Weapon Items */
		[]
	],
	
	/* Uniform */
	[
		"U_I_GhillieSuit", 
		/* Uniform-Weapons */
		[], 
		/* Uniform-Magazines */
		[],
		/* Uniform-Items */
		[
			"ItemRadio",
			"AGM_Epipen","AGM_Epipen","AGM_Epipen",
			"AGM_Bandage","AGM_Bandage","AGM_Bandage","AGM_Bandage",
			"AGM_Morphine","AGM_Morphine","AGM_Morphine",
			"AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie"			
		]
	],
		
	/* Vest */
	[
		"V_Chestrig_oli",
		/* Vest-Weapons */
		[
			"SmokeShell","SmokeShell",
			"SmokeShellRed","SmokeShellRed",
			"SmokeShellGreen","SmokeShellGreen"
		], 
		/* Vest-Magazines */
		[
			"5Rnd_127x108_Mag","5Rnd_127x108_Mag","5Rnd_127x108_Mag","5Rnd_127x108_Mag","5Rnd_127x108_Mag"
		],
		/* Vest-Items */
		[
		]
	],
	
	/* Backpack */
	[
		"B_AssaultPack_dgtl",
		/* Backpack-Weapons */
		[], 
		/* Backpack-Magazines */
		[
			"5Rnd_127x108_APDS_Mag","5Rnd_127x108_APDS_Mag","5Rnd_127x108_APDS_Mag","5Rnd_127x108_APDS_Mag","5Rnd_127x108_APDS_Mag","5Rnd_127x108_APDS_Mag"
		],
		/* Backpack-Items */
		[			
			"AGM_Epipen","AGM_Epipen","AGM_Epipen",
			"AGM_Bandage","AGM_Bandage","AGM_Bandage","AGM_Bandage",
			"AGM_Morphine","AGM_Morphine","AGM_Morphine",
			"SmokeShell","SmokeShell",
			"SmokeShellRed","SmokeShellRed",
			"SmokeShellGreen","SmokeShellGreen"			
		]
	],
	
	/* Code */
	"_unit setVariable ['AGM_IsEOD', false];_unit setVariable ['AGM_IsMedic', false];"
];

_result;