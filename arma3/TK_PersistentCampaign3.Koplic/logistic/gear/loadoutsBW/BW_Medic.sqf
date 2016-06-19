private["_result"];
_result = [
	/* Goggles */
	"", //G_Tactical_Clear

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
		"hlc_rifle_G36CMLIC_equipped",
		/* Primary weapon Magazine */
		"30Rnd_65x39_caseless_mag_Tracer",
		/* Primary Weapon Items */
		[""]
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
		"BWA3_Uniform_idz_Fleck",
		/* Uniform-Weapons */
		[],
		/* Uniform-Magazines */
		[],
		/* Uniform-Items */
		[
			"ItemRadio","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","ACE_EarPlugs","ACE_CableTie","ACE_CableTie","ACE_CableTie","ACE_CableTie","ACE_ATragMX","ACE_IR_Strobe_Item"
		]
	],

	/* Vest */
	[
		"BWA3_Vest_Medic_Fleck",
		/* Vest-Weapons */
		[
			"SmokeShell","SmokeShell","SmokeShell","SmokeShell",
			"SmokeShellPurple","SmokeShellPurple","SmokeShellPurple","SmokeShellPurple","SmokeShellPurple","SmokeShellPurple",
			"SmokeShellGreen","SmokeShellRed"
		],
		/* Vest-Magazines */
		[
			"30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer"
			,"30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer",
			"16Rnd_9x21_Mag","16Rnd_9x21_Mag"
		],
		/* Vest-Items */
		[
		]
	],

	/* Backpack */
	[
		"BWA3_AssaultPack_Fleck",
		/* Backpack-Weapons */
		[],
		/* Backpack-Magazines */
		[
			"30Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag_Tracer"
		],
		/* Backpack-Items */
		[
			"Medikit","FirstAidKit","FirstAidKit","ACE_muzzle_mzls_H","muzzle_snds_H","BWA3_Beret_PzGren","BWA3_G_Combat_Clear"
		]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, false, 2, false]	
];

_result;