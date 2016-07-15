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
		DEFAULT_VEST_SNIPERROUP, 
		/* Vest-Weapons */
		[DEFAULT_VESTWEAPONS],
		/* Vest-Magazines */
		[
			DEFAULT_VESTMAGAZINES,
			"20Rnd_762x51_Mag", "20Rnd_762x51_Mag"
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
		"arifle_SPAR_03_blk_F",
		/* Primary weapon Magazine */
		"20Rnd_762x51_Mag",
		/* Primary Weapon Items */
		["acc_pointer_IR", "optic_SOS", "bipod_01_F_blk", "muzzle_snds_B"]
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
		[],
		/* Backpack-Magazines */
		[
			"SmokeShell","SmokeShell",
			"20Rnd_762x51_Mag", "20Rnd_762x51_Mag", "20Rnd_762x51_Mag", "20Rnd_762x51_Mag", "20Rnd_762x51_Mag",
			"20Rnd_762x51_Mag", "20Rnd_762x51_Mag", "20Rnd_762x51_Mag", "20Rnd_762x51_Mag", "20Rnd_762x51_Mag"
		],
		/* Backpack-Items */
		["ACE_Kestrel4500", "ACE_ATragMX", DEFAULT_BACKPACKITEMS]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, 0, 0, false]	
];

_result;