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
			DEFAULT_VESTMAGAZINES, "150Rnd_556x45_Drum_Mag_F", "150Rnd_556x45_Drum_Mag_F"
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
		"arifle_SPAR_02_blk_F",
		/* Primary weapon Magazine */
		"150Rnd_556x45_Drum_Mag_F",
		/* Primary Weapon Items */
		["optic_ERCO_blk_F", "acc_pointer_IR", "muzzle_snds_M"]
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
			"150Rnd_556x45_Drum_Mag_F", "150Rnd_556x45_Drum_Mag_F"
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