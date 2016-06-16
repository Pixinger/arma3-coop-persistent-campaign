private["_result"];
_result = [
	/* Goggles */
	"",

	/* Headgear */
	"BWA3_MICH_Fleck",

	/* Binoculars */
	"Binocular",

	/* Nightvision */
	"NVGoggles_OPFOR",

	/* Linked Items */
	[
		"ItemMap",
		"ItemWatch",
		"ItemCompass",
		"ItemGps"
	],

	/* Primary Weapon */
	[
		"BWA3_MG5_equipped", //TODO
		/* Primary weapon Magazine */
		"MG5_120Rnd_762x51_Box_Tracer",
		/* Primary Weapon Items */
		["","",""]
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
		"BWA3_Uniform2_idz_Fleck",
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
		"BWA3_Vest_Autorifleman_Fleck",
		/* Vest-Weapons */
		[
		],
		/* Vest-Magazines */
		[
			"MG5_120Rnd_762x51_Box_Tracer","MG5_120Rnd_762x51_Box_Tracer",
			"16Rnd_9x21_Mag","16Rnd_9x21_Mag"
		],
		/* Vest-Items */
		[
		]
	],

	/* Backpack */
	[
		"BWA3_Kitbag_Fleck",
		/* Backpack-Weapons */
		[
			"SmokeShell","SmokeShell",
			"SmokeShellGreen","SmokeShellRed"
		],
		/* Backpack-Magazines */
		[
			"MG5_120Rnd_762x51_Box_Tracer","MG5_120Rnd_762x51_Box_Tracer"
		],
		/* Backpack-Items */
		[
			"ACE_muzzle_mzls_B","muzzle_snds_B","BWA3_Beret_PzGren","BWA3_G_Combat_Clear", "ACE_SpareBarrel"
		]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, false, 0, false]	
];

_result;