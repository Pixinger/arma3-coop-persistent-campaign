#include "_defines.hpp"

private["_result"];
_result = [
	/* Goggles */
	"",

	/* Headgear */
	"",

	/* Binoculars */
	"",

	/* Nightvision */
	"",

	/* Linked Items */
	[
		DEFAULT_LINKEDITEMS		
	],

	/* Uniform */
	[
		DEFAULT_UNIFORM_FREETIME,
		/* Uniform-Weapons */
		[DEFAULT_UNIFORMWEAPONS],
		/* Uniform-Magazines */
		[DEFAULT_UNIFORMMAGAZINES],
		/* Uniform-Items */
		[DEFAULT_UNIFORMITEMS]
	],

	/* Vest */
	[
		"",
		/* Vest-Weapons */
		[],
		/* Vest-Magazines */
		[],
		/* Vest-Items */
		[]
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
		"", //TODO
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