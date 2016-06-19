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
			"10Rnd_762x51_Box_Tracer", "10Rnd_762x51_Box_Tracer", "10Rnd_762x51_Box_Tracer", "10Rnd_762x51_Box_Tracer", "10Rnd_762x51_Box_Tracer"
		],
		/* Vest-Items */
		["ACE_muzzle_mzls_B", "muzzle_snds_B", DEFAULT_VESTITEMS]
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
		"BWA3_G28_Standard_equipped",
		/* Primary weapon Magazine */
		"10Rnd_762x51_Box_Tracer",
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
		[],
		/* Backpack-Magazines */
		[
			"SmokeShell","SmokeShell",
			"10Rnd_762x51_Box_Tracer", "10Rnd_762x51_Box_Tracer", "10Rnd_762x51_Box_Tracer", "10Rnd_762x51_Box_Tracer", "10Rnd_762x51_Box_Tracer",
			"10Rnd_762x51_Box_Tracer", "10Rnd_762x51_Box_Tracer", "10Rnd_762x51_Box_Tracer", "10Rnd_762x51_Box_Tracer", "10Rnd_762x51_Box_Tracer"
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