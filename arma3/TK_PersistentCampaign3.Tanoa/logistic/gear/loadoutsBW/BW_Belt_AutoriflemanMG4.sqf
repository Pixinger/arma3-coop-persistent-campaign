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
			"ACE_muzzle_mzls_H","muzzle_snds_H"
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
		"BWA3_MG4_equipped",
		/* Primary weapon Magazine */
		"200Rnd_65x39_cased_Box_Tracer",
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
			"200Rnd_65x39_cased_Box_Tracer", "200Rnd_65x39_cased_Box_Tracer", "200Rnd_65x39_cased_Box_Tracer"
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
	[false, 0, 0, false]	
];

_result;