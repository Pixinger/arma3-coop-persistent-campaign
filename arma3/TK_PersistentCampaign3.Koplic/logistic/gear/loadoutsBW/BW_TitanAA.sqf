private["_result"];
_result = [
	/* Goggles */
	DEFAULT_GOOGLES,

	/* Headgear */
	DEFAULT_HEADGEAR,

	/* Binoculars */
	DEFAULT_BINOCULARS,

	/* Nightvision */
	DEFAULT_NIGHTVISION,

	/* Linked Items */
	[
		DEFAULT_LINKEDITEMS		
	],

	/* Primary Weapon */
	[
		"hlc_rifle_G36KMLIC_equipped",
		/* Primary weapon Magazine */
		"30Rnd_65x39_caseless_mag_Tracer",
		/* Primary Weapon Items */
		[]
	],

	/* Secondary Weapon */
	[
		"launch_I_Titan_F",
		/* Secondary weapon Magazine */
		"Titan_AA",
		/* Secondary Weapon Items */
		[]
	],

	/* Handgun Weapon */
	[
		DEFAULT_HANDGUNWEAPON,
		/* Handgun Weapon Magazine */
		DEFAULT_HANDGUNMAGAZINE,
		/* Handgun Weapon Items */
		[DEFAULT_HANDGUNITEMS]
	],

	/* Uniform */
	[
		DEFAULT_UNIFORM,
		/* Uniform-Weapons */
		[],
		/* Uniform-Magazines */
		[],
		/* Uniform-Items */
		[DEFAULT_UNIFORMITEMS]
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
			"Titan_AA"
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