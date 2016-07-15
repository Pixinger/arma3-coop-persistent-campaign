#include "_defines.hpp"

private["_result"];
_result = [
	/* Goggles */
	DEFAULT_GOOGLES,

	/* Headgear */
	DEFAULT_HEADGEAR_LIGHT,

	/* Binoculars */
	"Binocular",

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
		DEFAULT_VEST_ATNLAW,
		/* Vest-Weapons */
		[DEFAULT_VESTWEAPONS],
		/* Vest-Magazines */
		[
			DEFAULT_VESTMAGAZINES, 
			"30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag"
		],
		/* Vest-Items */
		[DEFAULT_VESTITEMS]
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
		"arifle_MX_khk_F",
		/* Primary weapon Magazine */
		"30Rnd_65x39_caseless_mag",
		/* Primary Weapon Items */
		["optic_Hamr","acc_pointer_IR","muzzle_snds_H"]
	],

	/* Secondary Weapon */
	[
		"launch_NLAW_F",
		/* Secondary weapon Magazine */
		"NLAW_F",
		/* Secondary Weapon Items */
		[]
	],

	/* Backpack */
	[
		DEFAULT_BACKPACK,
		/* Backpack-Weapons */
		[
		],
		/* Backpack-Magazines */
		[
			"30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag",
			"30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag"
		],
		/* Backpack-Items */
		[DEFAULT_BACKPACKITEMS]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, 0, 0, false]	
];

_result;