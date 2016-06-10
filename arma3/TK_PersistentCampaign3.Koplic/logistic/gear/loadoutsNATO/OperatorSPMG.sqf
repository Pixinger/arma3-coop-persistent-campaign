private["_result"];
_result = [
	/* Goggles */
	"",

	/* Headgear */
	"H_HelmetB_light_snakeskin",

	/* Binoculars */
	"Binocular",

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
		"MMG_02_black_F", //TODO
		/* Primary weapon Magazine */
		"130Rnd_338_Mag",
		/* Primary Weapon Items */
		["optic_Hamr","bipod_01_F_blk","acc_pointer_IR","muzzle_snds_338_black"]
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
		"U_B_CTRG_3",
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
		"V_PlateCarrierL_CTRG",
		/* Vest-Weapons */
		[
		],
		/* Vest-Magazines */
		[
			"130Rnd_338_Mag","130Rnd_338_Mag",
			"11Rnd_45ACP_Mag","11Rnd_45ACP_Mag"
		],
		/* Vest-Items */
		[
		]
	],

	/* Backpack */
	[
		"B_AssaultPack_rgr",
		/* Backpack-Weapons */
		[
			"SmokeShell","SmokeShell",
			"SmokeShellGreen","SmokeShellRed"
		],
		/* Backpack-Magazines */
		[
			"130Rnd_338_Mag","130Rnd_338_Mag"
		],
		/* Backpack-Items */
		[]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, false, 0, false]	
];

_result;