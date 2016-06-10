private["_result"];
_result = [
	/* Goggles */
	"G_Balaclava_oli", //G_Tactical_Clear

	/* Headgear */
	"",

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
		"srifle_DMR_05_tan_f",
		/* Primary weapon Magazine */
		"10Rnd_93x64_DMR_05_Mag",
		/* Primary Weapon Items */
		["optic_KHS_tan","bipod_02_F_tan","muzzle_snds_93mmg_tan","acc_pointer_IR"]
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
		"U_B_FullGhillie_sard",
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
		"B_Kitbag_rgr",
		/* Backpack-Weapons */
		[],
		/* Backpack-Magazines */
		[
			"10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag"
			,"10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag","10Rnd_93x64_DMR_05_Mag"
			,"11Rnd_45ACP_Mag","11Rnd_45ACP_Mag","11Rnd_45ACP_Mag","11Rnd_45ACP_Mag"
		],
		/* Backpack-Items */
		[
			"SmokeShell","SmokeShell",
			"SmokeShellRed","SmokeShellRed",
			"SmokeShellGreen","SmokeShellGreen",
			"NVGoggles"
		]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, false, 0, false]	
];

_result;