#include "_defines.hpp"

private["_result"];
_result = [
	/* Goggles */
	"",

	/* Headgear */
	"H_CrewHelmetHeli_B",

	/* Binoculars */
	"",

	/* Nightvision */
	DEFAULT_NIGHTVISION,

	/* Linked Items */
	[
		DEFAULT_LINKEDITEMS		
	],

	/* Uniform */
	[
		"BWA3_Uniform_Helipilot",
		/* Uniform-Weapons */
		[DEFAULT_UNIFORMWEAPONS],
		/* Uniform-Magazines */
		[
			DEFAULT_UNIFORMMAGAZINES, 
			"C1987_40Rnd_46x30_mp7", 
			"SmokeShellBlue", "SmokeShellBlue", "SmokeShellBlue"
		],
		/* Uniform-Items */
		[DEFAULT_UNIFORMITEMS]
	],

	/* Vest */
	[
		"",
		/* Vest-Weapons */
		[],
		/* Vest-Magazines */
		[],
		/* Vest-Items */
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

	/* Primary Weapon */
	[
		"C1987_MP7_equipped",
		/* Primary weapon Magazine */
		"C1987_40Rnd_46x30_mp7",
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

	/* Backpack */
	[
		"",
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
	[false, 0, 0, false]	
];

_result;