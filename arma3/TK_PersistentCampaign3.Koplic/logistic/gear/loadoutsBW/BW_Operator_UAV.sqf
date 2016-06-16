private["_result"];
_result = [
	/* Goggles */
	"BWA3_G_Combat_Clear",

	/* Headgear */
	"BWA3_MICH_Fleck",

	/* Binoculars */
	"Rangefinder",

	/* Nightvision */
	"NVGoggles",

	/* Linked Items */
	[
		"ItemMap",
		"ItemWatch",
		"ItemCompass",
		"B_UavTerminal"
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
		"B_UAV_01_backpack_F",
		/* Backpack-Weapons */
		[],
		/* Backpack-Magazines */
		[],
		/* Backpack-Items */
		[]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, false, 0, false]	
];

_result;