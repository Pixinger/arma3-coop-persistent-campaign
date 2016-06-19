#include "_defines.hpp"

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

	/* Uniform */
	[
		DEFAULT_UNIFORM,
		/* Uniform-Weapons */
		[DEFAULT_UNIFORMWEAPONS],
		/* Uniform-Magazines */
		[DEFAULT_UNIFORMMAGAZINES],
		/* Uniform-Items */
		[DEFAULT_UNIFORMITEMS]
	],

	/* Vest */
	[
		DEFAULT_VESTAUTORIFLEMAN,
		/* Vest-Weapons */
		[DEFAULT_VESTWEAPONS],
		/* Vest-Magazines */
		[
			DEFAULT_VESTMAGAZINES
		],
		/* Vest-Items */
		[
			DEFAULT_VESTITEMS,
			"ACE_muzzle_mzls_B","muzzle_snds_B"
		]
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
		"BWA3_MG5_equipped",
		/* Primary weapon Magazine */
		"MG5_120Rnd_762x51_Box_Tracer",
		/* Primary Weapon Items */
		[]
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
		DEFAULT_BACKPACKLARGE,
		/* Backpack-Weapons */
		[
			DEFAULT_BACKPACKWEAPONS
		],
		/* Backpack-Magazines */
		[
			DEFAULT_BACKPACKMAGAZINES,
			"MG5_120Rnd_762x51_Box_Tracer", "MG5_120Rnd_762x51_Box_Tracer", "MG5_120Rnd_762x51_Box_Tracer"
		],
		/* Backpack-Items */
		[
			DEFAULT_BACKPACKITEMS,
			"ACE_SpareBarrel"
		]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, false, 0, false]	
];

_result;