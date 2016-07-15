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
		DEFAULT_VEST_MEDIC,
		/* Vest-Weapons */
		[DEFAULT_VESTWEAPONS],
		/* Vest-Magazines */
		[
			DEFAULT_VESTMAGAZINES, 
			"30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag"
		],
		/* Vest-Items */
		[
			DEFAULT_VESTITEMS, 
			"SmokeShellOrange", "SmokeShellOrange",
			"ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing",
			"ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing"
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
		"arifle_MX_khk_F",
		/* Primary weapon Magazine */
		"30Rnd_65x39_caseless_mag",
		/* Primary Weapon Items */
		["optic_Hamr","acc_pointer_IR","muzzle_snds_H"]
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
		DEFAULT_BACKPACKRADIO,
		/* Backpack-Weapons */
		[],
		/* Backpack-Magazines */
		[
		],
		/* Backpack-Items */
		[
			"ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", 
			"ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", 
			"ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", 
			"ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", 
			"ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", "ACE_fieldDressing", 
			"ACE_morphine", "ACE_morphine", 
			"ACE_epinephrine", "ACE_epinephrine", "ACE_epinephrine", "ACE_epinephrine", "ACE_epinephrine",
			"ACE_epinephrine", "ACE_epinephrine", "ACE_epinephrine", "ACE_epinephrine", "ACE_epinephrine",
			"ACE_bloodIV_250", "ACE_bloodIV_250", "ACE_bloodIV_250", "ACE_bloodIV_250", 
			"ACE_tourniquet", "ACE_tourniquet"
		]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, 0, 2, false]	
];

_result;