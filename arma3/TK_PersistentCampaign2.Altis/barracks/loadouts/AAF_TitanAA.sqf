private["_result"];
_result = [
	/* Goggles */
	"",
	
	/* Headgear */
	"H_HelmetIA_camo",
	
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
		"arifle_Mk20C_ACO_pointer_F",
		/* Primary weapon Magazine */
		"30Rnd_556x45_Stanag",
		/* Primary Weapon Items */
		["muzzle_snds_M","optic_MRCO"]
	],
	
	/* Secondary Weapon */
	[
		"launch_I_Titan_F",
		/* Secondary weapon Magazine */
		"Titan_AA",
		/* Secondary Weapon Items */
		[]
	],
	
	/* Handgun Weapon */
	[
		"hgun_ACPC2_F",
		/* Handgun Weapon Magazine */
		"9Rnd_45ACP_Mag",
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
		"V_PlateCarrierIA2_dgtl",
		/* Vest-Weapons */
		[
			"SmokeShell","SmokeShell",
			"SmokeShellGreen","SmokeShellGreen"
		], 
		/* Vest-Magazines */
		[
			"30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"
		],
		/* Vest-Items */
		[
			"AGM_Bandage",
			"AGM_Morphine"
		]
	],	
	
	/* Backpack */
	[
		"I_Fieldpack_oli_AA", 
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