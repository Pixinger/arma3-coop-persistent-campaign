private["_result"];
_result = [
	/* Goggles */
	"",

	/* Headgear */
	"H_PilotHelmetHeli_B",

	/* Binoculars */
	"",

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
		"SMG_01_F",
		/* Primary weapon Magazine */
		"30Rnd_45ACP_Mag_SMG_01_Tracer_Red",
		/* Primary Weapon Items */
		["optic_Aco_smg"]
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
		"",
		/* Handgun Weapon Magazine */
		"",
		/* Handgun Weapon Items */
		[]
	],

	/* Uniform */
	[
		"U_B_HeliPilotCoveralls",
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
		"V_TacVest_blk",
		/* Vest-Weapons */
		[
			"SmokeShell","SmokeShell",
			"SmokeShellGreen","SmokeShellRed"
		],
		/* Vest-Magazines */
		[
			"30Rnd_45ACP_Mag_SMG_01_Tracer_Red","30Rnd_45ACP_Mag_SMG_01_Tracer_Red","30Rnd_45ACP_Mag_SMG_01_Tracer_Red"
			,"30Rnd_45ACP_Mag_SMG_01_Tracer_Red","30Rnd_45ACP_Mag_SMG_01_Tracer_Red"
		],
		/* Vest-Items */
		[
		]
	],

	/* Backpack */
	[
		"B_Parachute",
		/* Backpack-Weapons */
		[],
		/* Backpack-Magazines */
		[
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