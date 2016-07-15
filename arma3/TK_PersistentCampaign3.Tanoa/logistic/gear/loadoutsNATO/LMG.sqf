#include "_defines.hpp"

private["_result"];
_result = [
	/* Goggles */
	DEFAULT_GOOGLES,

	/* Headgear */
	DEFAULT_HEADGEAR_LIGHT,

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
		DEFAULT_VEST_LMG,
		/* Vest-Weapons */
		[DEFAULT_VESTWEAPONS],
		/* Vest-Magazines */
		[
			DEFAULT_VESTMAGAZINES, "100Rnd_65x39_caseless_mag", "100Rnd_65x39_caseless_mag_Tracer"
		],
		/* Vest-Items */
		[
			DEFAULT_VESTITEMS
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
		"arifle_MX_SW_khk_F",
		/* Primary weapon Magazine */
		"100Rnd_65x39_caseless_mag",
		/* Primary Weapon Items */
		["optic_Hamr", "acc_pointer_IR", "muzzle_snds_H", "bipod_01_F_blk"]
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
		DEFAULT_BACKPACK,
		/* Backpack-Weapons */
		[
			DEFAULT_BACKPACKWEAPONS
		],
		/* Backpack-Magazines */
		[
			DEFAULT_BACKPACKMAGAZINES,
			"100Rnd_65x39_caseless_mag_Tracer", "100Rnd_65x39_caseless_mag_Tracer"
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