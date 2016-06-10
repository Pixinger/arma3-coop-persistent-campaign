private["_result"];
_result = [
	/* Goggles */
	"", //G_Tactical_Clear

	/* Headgear */
	"H_Bandanna_mcamo",

	/* Binoculars */
	"Rangefinder",

	/* Nightvision */
	"",

	/* Linked Items */
	[
		"ItemMap",
		"ItemWatch",
		"ItemCompass",
		"ItemGps"
	],

	/* Primary Weapon */
	[
		"srifle_LRR_camo_F",
		/* Primary weapon Magazine */
		"7Rnd_408_Mag",
		/* Primary Weapon Items */
		["optic_LRPS"]
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
		"hgun_Pistol_heavy_01_F",
		/* Handgun Weapon Magazine */
		"11Rnd_45ACP_Mag",
		/* Handgun Weapon Items */
		["optic_MRD","muzzle_snds_acp"]
	],

	/* Uniform */
	[
		"U_B_GhillieSuit",
		/* Uniform-Weapons */
		[],
		/* Uniform-Magazines */
		[],
		/* Uniform-Items */
		[
			"ItemRadio","FirstAidKit","FirstAidKit","FirstAidKit","ACE_EarPlugs","ACE_CableTie","ACE_CableTie","ACE_CableTie"
		]
	],

	/* Vest */
	[
		"",
		/* Vest-Weapons */
		[],
		/* Vest-Magazines */
		[],
		/* Vest-Items */
		[
		]
	],

	/* Backpack */
	[
		"B_Kitbag_mcamo",
		/* Backpack-Weapons */
		[],
		/* Backpack-Magazines */
		[
			"7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag"
			,"11Rnd_45ACP_Mag","11Rnd_45ACP_Mag","11Rnd_45ACP_Mag","11Rnd_45ACP_Mag"
		],
		/* Backpack-Items */
		[
			"SmokeShell","SmokeShell",
			"SmokeShellRed","SmokeShellGreen",
			"NVGoggles"
		]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, false, 0, false]	
];

_result;