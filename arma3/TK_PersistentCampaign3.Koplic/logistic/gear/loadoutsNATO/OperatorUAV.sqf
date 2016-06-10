private["_result"];
_result = [
	/* Goggles */
	"G_Lowprofile",

	/* Headgear */
	"H_HelmetB_light_snakeskin",

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
		"arifle_TRG20_F",
		/* Primary weapon Magazine */
		"30Rnd_556x45_Stanag",
		/* Primary Weapon Items */
		["muzzle_snds_M","acc_pointer_IR","optic_Hamr","muzzle_snds_338_black"]
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
		["optic_MRD","muzzle_snds_acp"]
	],

	/* Uniform */
	[
		"U_B_CTRG_3",
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
		"V_PlateCarrierL_CTRG",
		/* Vest-Weapons */
		[
			"SmokeShell","SmokeShell",
			"SmokeShellGreen","SmokeShellRed"
		],
		/* Vest-Magazines */
		[
			"30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"
			,"30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"
			,"30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"
			,"Handgrenade","Handgrenade"
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
		[
		]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, false, 0, false]	
];

_result;