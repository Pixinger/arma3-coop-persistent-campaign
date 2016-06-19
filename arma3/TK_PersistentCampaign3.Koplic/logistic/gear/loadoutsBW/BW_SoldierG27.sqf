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
		DEFAULT_VEST,
		/* Vest-Weapons */
		[DEFAULT_VESTWEAPONS],
		/* Vest-Magazines */
		[
			DEFAULT_VESTMAGAZINES, 
			"20Rnd_762x51_Mag_Tracer", "20Rnd_762x51_Mag_Tracer", "20Rnd_762x51_Mag_Tracer", "20Rnd_762x51_Mag_Tracer", "20Rnd_762x51_Mag_Tracer"
		],
		/* Vest-Items */
		[DEFAULT_VESTITEMS, "ACE_muzzle_mzls_H", "muzzle_snds_H"]
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
		"BWA3_G27_equipped",
		/* Primary weapon Magazine */
		"20Rnd_762x51_Mag_Tracer",
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
		DEFAULT_BACKPACK,
		/* Backpack-Weapons */
		[
		],
		/* Backpack-Magazines */
		[
			"20Rnd_762x51_Mag_Tracer","20Rnd_762x51_Mag_Tracer","20Rnd_762x51_Mag_Tracer","20Rnd_762x51_Mag_Tracer",
			"20Rnd_762x51_Mag_Tracer","20Rnd_762x51_Mag_Tracer","20Rnd_762x51_Mag_Tracer","20Rnd_762x51_Mag_Tracer",
			"20Rnd_762x51_Mag_Tracer","20Rnd_762x51_Mag_Tracer"
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