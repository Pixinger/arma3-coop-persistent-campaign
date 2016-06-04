private["_result"];
_result = [
	/* Goggles */
	"",

	/* Headgear */
	"H_HelmetB",

	/* Binoculars */
	"Binocular",

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
		"arifle_Mk20_MRCO_plain_F",
		/* Primary weapon Magazine */
		"30Rnd_556x45_Stanag",
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
		"U_B_CombatUniform_mcam_vest",
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
		"V_PlateCarrier2_rgr",
		/* Vest-Weapons */
		[
			"SmokeShell","SmokeShell",
			"SmokeShellPurple","SmokeShellPurple",
			"SmokeShellGreen","SmokeShellRed"
		],
		/* Vest-Magazines */
		[
			"30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"
			,"30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"
			,"30Rnd_556x45_Stanag",
			"16Rnd_9x21_Mag","16Rnd_9x21_Mag"
		],
		/* Vest-Items */
		[
		]
	],

	/* Backpack */
	[
		"B_Kitbag_rgr",
		/* Backpack-Weapons */
		[
		],
		/* Backpack-Magazines */
		[
		"30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"
		],
		/* Backpack-Items */
		[
			"ToolKit","MineDetector","muzzle_snds_M"
		]
	],

	/* Code */
	"player setVariable [""ACE_isEOD"", true, true];player setVariable [""ACE_IsEngineer"", false, true];player setVariable [""ace_medical_medicclass"",0, true];"
];

_result;

//ACE_IsEngineer
//unit getVariable [QGVAR(medicClass)			=> 		_unit getVariable ["ace_medical_medicClass", false]
//_vehicle getVariable [QGVAR(medicClass)		=> 		_vehicle getVariable ["ace_medical_medicClass", false]