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
		"ItemMap",
		"ItemWatch",
		"ItemCompass"
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
	
	/* Handgun Weapon */
	[
		"",
		/* Handgun Weapon Magazine */
		"",
		/* Handgun Weapon Items */
		[]
	],
	
	/* Uniform */
	[
		"U_I_CombatUniform_shortsleeve", 
		/* Uniform-Weapons */
		[], 
		/* Uniform-Magazines */
		[],
		/* Uniform-Items */
		["ItemRadio"]
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
	"_unit setVariable ['AGM_IsEOD', false];_unit setVariable ['AGM_IsMedic', false];"
];

_result;