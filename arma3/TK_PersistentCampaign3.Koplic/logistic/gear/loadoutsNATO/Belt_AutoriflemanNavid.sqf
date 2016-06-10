private["_result"];
_result = [
	/* Goggles */
	"",

	/* Headgear */
	"H_HelmetB",

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
		"MMG_01_tan_F", //TODO
		/* Primary weapon Magazine */
		"150Rnd_93x64_Mag",
		/* Primary Weapon Items */
		["optic_MRCO","acc_pointer_IR","bipod_01_F_blk"]
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
		"hgun_P07_F",
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
		[],
		/* Uniform-Items */
		[
			"ItemRadio","FirstAidKit","FirstAidKit","FirstAidKit","ACE_EarPlugs","ACE_CableTie","ACE_CableTie","ACE_CableTie"
		]
	],

	/* Vest */
	[
		"V_PlateCarrier2_rgr",
		/* Vest-Weapons */
		[
		],
		/* Vest-Magazines */
		[
			"150Rnd_93x64_Mag","150Rnd_93x64_Mag",
			"16Rnd_9x21_Mag","16Rnd_9x21_Mag"
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
			"150Rnd_93x64_Mag","150Rnd_93x64_Mag"
		],
		/* Backpack-Items */
		[
			"muzzle_snds_93mmg"
		]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, false, 0, false]	
];

_result;