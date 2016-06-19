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

	/* Primary Weapon */
	[
		DEFAULT_PRIMARYWEAPON,
		/* Primary weapon Magazine */
		DEFAULT_PRIMARYMAGAZINE,
		/* Primary Weapon Items */
		[DEFAULT_PRIMARYITEMS]
	],

	/* Secondary Weapon */
	[
		DEFAULT_SECONDARYWEAPON,
		/* Secondary weapon Magazine */
		DEFAULT_SECONDARYMAGAZINE-,
		/* Secondary Weapon Items */
		[]
	],

	/* Handgun Weapon */
	[
		DEFAULT_HANDGUNWEAPON,
		/* Handgun Weapon Magazine */
		DEFAULT_HANDGUNMAGAZINE,
		/* Handgun Weapon Items */
		[DEFAULT_HANDGUNITEMS]
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
		[DEFAULT_VESTMAGAZINES],
		/* Vest-Items */
		[DEFAULT_VESTITEMS]
	],

	/* Backpack */
	[
		DEFAULT_BACKPACK,
		/* Backpack-Weapons */
		[DEFAULT_BACKPACKWEAPONS],
		/* Backpack-Magazines */
		[DEFAULT_BACKPACKMAGAZINES],
		/* Backpack-Items */
		[DEFAULT_BACKPACKITEMS]
	],

	/* Code */
	"",
	
	/* Unit Type Array: [ACE_isEOD, ACE_IsEngineer, ace_medical_medicclass, isPioneer] */
	[false, false, 0, false]	
];

_result;