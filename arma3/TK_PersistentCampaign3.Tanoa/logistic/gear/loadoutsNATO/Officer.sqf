#include "_defines.hpp"

private["_result"];
_result = [
	/* Goggles */
	"",

	/* Headgear */
	"H_MilCap_tna_F",

	/* Binoculars */
	DEFAULT_BINOCULARS,

	/* Nightvision */
	"",

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
		"BWA3_Vest_Leader_Fleck",
		/* Vest-Weapons */
		[DEFAULT_VESTWEAPONS],
		/* Vest-Magazines */
		[DEFAULT_VESTMAGAZINES],
		/* Vest-Items */
		[DEFAULT_VESTITEMS]
	],

	/* Handgun Weapon */
	[
		"",
		/* Handgun Weapon Magazine */
		"",
		/* Handgun Weapon Items */
		[]
	],

	/* Primary Weapon */
	[
		"",
		/* Primary weapon Magazine */
		"",
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
		"",
		/* Backpack-Weapons */
		[],
		/* Backpack-Magazines */
		[],
		/* Backpack-Items */
		[]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, 0, 0, false]	
];

_result;