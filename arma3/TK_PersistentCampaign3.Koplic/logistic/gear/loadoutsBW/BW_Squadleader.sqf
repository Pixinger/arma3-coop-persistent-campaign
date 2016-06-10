private["_result"];
_result = [
	/* Goggles */
	"",

	/* Headgear */
	"BWA3_MICH_Fleck",

	/* Binoculars */
	"Rangefinder",

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
		"hlc_rifle_G36MLIC_equipped",
		/* Primary weapon Magazine */
		"30Rnd_65x39_caseless_mag_Tracer",
		/* Primary Weapon Items */
		["acc_pointer_IR","optic_MRCO"]
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
		["optic_MRD"]
	],

	/* Uniform */
	[
		"BWA3_Uniform3_idz_Fleck",
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
		"BWA3_Vest_Leader_Fleck",
		/* Vest-Weapons */
		[
			"SmokeShell","SmokeShell",
			"SmokeShellGreen","SmokeShellGreen","SmokeShellRed","SmokeShellRed",
			"MiniGrenade","MiniGrenade"
		],
		/* Vest-Magazines */
		[
			"30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer"
			,"30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer"
			,"11Rnd_45ACP_Mag","11Rnd_45ACP_Mag"
		],
		/* Vest-Items */
		[
			"optic_Nightstalker"
		]
	],

	/* Backpack */
	[
		"tf_rt1523g_bwmod",
		/* Backpack-Weapons */
		[],
		/* Backpack-Magazines */
		[],
		/* Backpack-Items */
		[
			"ACE_muzzle_mzls_H","muzzle_snds_H","BWA3_Beret_PzGren","BWA3_G_Combat_Clear"
		]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, false, 0, false]	
];

_result;