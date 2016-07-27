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
		DEFAULT_LINKEDITEMS_UAV		
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
		DEFAULT_VEST_UAV,
		/* Vest-Weapons */
		[DEFAULT_VESTWEAPONS_LIGHT],
		/* Vest-Magazines */
		[
			DEFAULT_VESTMAGAZINES_LIGHT, 
			"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag",
			"ACE_UAVBattery"
		],
		/* Vest-Items */
		[DEFAULT_VESTITEMS] //"ACE_muzzle_mzls_H", "muzzle_snds_H", 
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
		"arifle_SPAR_01_blk_F",
		/* Primary weapon Magazine */
		"30Rnd_556x45_Stanag",
		/* Primary Weapon Items */
		["optic_ERCO_blk_F","acc_pointer_IR","muzzle_snds_H"]
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
		"B_UAV_01_backpack_F",
		/* Backpack-Weapons */
		[
		],
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