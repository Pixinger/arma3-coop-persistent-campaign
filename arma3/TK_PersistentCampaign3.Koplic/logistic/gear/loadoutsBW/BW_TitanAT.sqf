private["_result"];
_result = [
	/* Goggles */
	"",

	/* Headgear */
	"BWA3_MICH_Fleck",

	/* Binoculars */
	"",

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
		"hlc_rifle_G36KMLIC_equipped",
		/* Primary weapon Magazine */
		"30Rnd_65x39_caseless_mag_Tracer",
		/* Primary Weapon Items */
		["",""]
	],

	/* Secondary Weapon */
	[
		"launch_I_Titan_short_F",
		/* Secondary weapon Magazine */
		"Titan_AT",
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
		"BWA3_Uniform_idz_Fleck",
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
		"BWA3_Vest_Rifleman1_Fleck",
		/* Vest-Weapons */
		[
			"SmokeShell","SmokeShell",
			"SmokeShellGreen","SmokeShellRed"
		],
		/* Vest-Magazines */
		[
			"30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer",
			"30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer",
			"16Rnd_9x21_Mag","16Rnd_9x21_Mag"
		],
		/* Vest-Items */
		[
			"ACE_muzzle_mzls_H","muzzle_snds_H","BWA3_Beret_PzGren","BWA3_G_Combat_Clear"
		]
	],

	/* Backpack */
	[
		"BWA3_Kitbag_Fleck",
		/* Backpack-Weapons */
		[],
		/* Backpack-Magazines */
		[
			"Titan_AT"
		],
		/* Backpack-Items */
		[
		]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, false, 0, false]	
];

_result;