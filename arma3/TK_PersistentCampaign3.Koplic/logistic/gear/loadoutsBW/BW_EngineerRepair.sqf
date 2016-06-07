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
		"hlc_rifle_G36CMLIC_equipped",
		/* Primary weapon Magazine */
		"30Rnd_65x39_caseless_mag_Tracer",
		/* Primary Weapon Items */
		["acc_pointer_IR"]
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
		[
		],
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
			"SmokeShellPurple","SmokeShellPurple",
			"SmokeShellGreen","SmokeShellRed"
		],
		/* Vest-Magazines */
		[
			"30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer"
			,"30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer"
			,"30Rnd_65x39_caseless_mag_Tracer",
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
		],
		/* Backpack-Magazines */
		[
		"30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer"
		],
		/* Backpack-Items */
		[
			"ToolKit","MineDetector","BWA3_G_Combat_Clear","BWA3_Beret_PzGren",
			"ACE_muzzle_mzls_H","muzzle_snds_H"
		]
	],

	/* Code */
	"player setVariable [""ACE_isEOD"", false, true];player setVariable [""ACE_IsEngineer"", true, true];player setVariable [""ace_medical_medicclass"",0, true];"
];

_result;