private["_result"];
_result = [
	/* Goggles */
	"",
	
	/* Headgear */
	"H_PilotHelmetHeli_I",
	
	/* Binoculars */
	"",
	
	/* Nightvision */
	"NVGoggles_INDEP",
	
	/* Linked Items */
	[
		"ItemMap",
		"ItemWatch",
		"ItemCompass",
		"ItemGps"
	],
	
	/* Primary Weapon */
	[
		"hgun_PDW2000_Holo_F",
		/* Primary weapon Magazine */
		"30Rnd_9x21_Mag",
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
		"U_I_CombatUniform", 
		/* Uniform-Weapons */
		[], 
		/* Uniform-Magazines */
		[],
		/* Uniform-Items */
		[
			"ItemRadio",
			"AGM_Epipen","AGM_Epipen","AGM_Epipen",
			"AGM_Bandage","AGM_Bandage","AGM_Bandage",
			"AGM_Morphine","AGM_Morphine","AGM_Morphine",
			"AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie"			
		]
	],
	
	/* Vest */
	[	
		"V_TacVest_oli", 
		/* Vest-Weapons */
		[], 
		/* Vest-Magazines */
		[		
			"30Rnd_9x21_Mag",	"30Rnd_9x21_Mag",	"30Rnd_9x21_Mag",	"30Rnd_9x21_Mag",	"30Rnd_9x21_Mag"
		],
		/* Vest-Items */
		[
			"AGM_Bandage",
			"AGM_Morphine"
		]
	],
	
	/* Backpack */
	[
		"tf_anprc155", 
		/* Backpack-Weapons */
		[], 
		/* Backpack-Magazines */
		[	
		],
		/* Backpack-Items */
		[
		]
	],
	
	/* Code */
	"_unit setVariable ['AGM_IsEOD', false];_unit setVariable ['AGM_IsMedic', false];"
];

_result;