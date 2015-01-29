private["_result"];
_result = [
	/* Goggles */
	"",
	
	/* Headgear */
	"H_HelmetIA",
	
	/* Binoculars (Binocular,AGM_Vector,AGM_Vector)*/
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
		"arifle_Mk20_MRCO_pointer_F",
		/* Primary weapon Magazine */
		"30Rnd_556x45_Stanag",
		/* Primary Weapon Items */
		["muzzle_snds_M"]
	],
	
	/* Secondary Weapon */
	[
		"launch_NLAW_F",
		/* Secondary weapon Magazine */
		"NLAW_F",
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
			"AGM_Bandage","AGM_Bandage","AGM_Bandage","AGM_Bandage",
			"AGM_Morphine","AGM_Morphine","AGM_Morphine",
			"AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie"			
		]
	],
	
	/* Vest */
	[
		"V_PlateCarrierIA2_dgtl",
		/* Vest-Weapons */
		[
			"SmokeShell","SmokeShell","SmokeShell",
			"SmokeShellGreen","SmokeShellGreen","SmokeShellGreen"
		], 
		/* Vest-Magazines */
		[
			"30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"
		],
		/* Vest-Items */
		[
		]
	],
	
	/* Backpack */
	[
		"I_Fieldpack_oli_LAT", 
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