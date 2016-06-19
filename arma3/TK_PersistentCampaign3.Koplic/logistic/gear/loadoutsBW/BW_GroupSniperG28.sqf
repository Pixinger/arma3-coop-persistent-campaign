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
		"BWA3_G28_Standard_equipped",
		/* Primary weapon Magazine */
		"10Rnd_762x51_Box_Tracer",
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
		"hgun_Pistol_heavy_01_F",
		/* Handgun Weapon Magazine */
		"11Rnd_45ACP_Mag",
		/* Handgun Weapon Items */
		["optic_MRD"]
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
			"ItemRadio","FirstAidKit","FirstAidKit","FirstAidKit","ACE_EarPlugs","ACE_CableTie","ACE_CableTie","ACE_CableTie","ACE_CableTie","ACE_ATragMX","ACE_IR_Strobe_Item"
		]
	],

	/* Vest */
	[
		"BWA3_Vest_Marksman_Fleck",
		/* Vest-Weapons */
		[
			"SmokeShell","SmokeShell",
			"SmokeShellRed","SmokeShellRed",
			"SmokeShellGreen","SmokeShellGreen"
		],
		/* Vest-Magazines */
		[
			"10Rnd_762x51_Box_Tracer","10Rnd_762x51_Box_Tracer","10Rnd_762x51_Box_Tracer","10Rnd_762x51_Box_Tracer","10Rnd_762x51_Box_Tracer",
			"10Rnd_762x51_Box_Tracer","11Rnd_45ACP_Mag","11Rnd_45ACP_Mag"
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
		[],
		/* Backpack-Items */
		[
			"SmokeShell","SmokeShell",
			"10Rnd_762x51_Box_Tracer","10Rnd_762x51_Box_Tracer","10Rnd_762x51_Box_Tracer","10Rnd_762x51_Box_Tracer",
			"10Rnd_762x51_Box_Tracer","10Rnd_762x51_Box_Tracer","10Rnd_762x51_Box_Tracer","10Rnd_762x51_Box_Tracer",
			"ACE_muzzle_mzls_B","muzzle_snds_B","BWA3_Beret_PzGren","ACE_ATragMX","ACE_Kestrel4500","BWA3_G_Combat_Clear"
		]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, false, 0, false]	
];

_result;