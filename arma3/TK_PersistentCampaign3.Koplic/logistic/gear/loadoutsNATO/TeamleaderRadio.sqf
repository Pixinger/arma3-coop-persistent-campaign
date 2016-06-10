private["_result"];
_result = [
	/* Goggles */
	"",

	/* Headgear */
	"H_HelmetB",

	/* Binoculars */
	"Rangefinder",

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
		"arifle_Mk20_GL_plain_F",
		/* Primary weapon Magazine */
		"30Rnd_556x45_Stanag",
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
		"U_B_CombatUniform_mcam",
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
			"SmokeShell","SmokeShell",
			"SmokeShellGreen","SmokeShellGreen","SmokeShellRed","SmokeShellRed",
			"MiniGrenade","MiniGrenade"
		],
		/* Vest-Magazines */
		[
			"30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"
			,"30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"
			,"11Rnd_45ACP_Mag","11Rnd_45ACP_Mag"
		],
		/* Vest-Items */
		[
			"optic_Nightstalker","muzzle_snds_M"
		]
	],

	/* Backpack */
	[
		"tf_rt1523g",
		/* Backpack-Weapons */
		[],
		/* Backpack-Magazines */
		[
			"1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell",
			"1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_HE_Grenade_shell",
			"1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell"
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