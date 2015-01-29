private["_result"];
_result = [
	/* Goggles */
	"", //G_Tactical_Clear
	
	/* Headgear */
	"H_HelmetIA",
	
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
		"arifle_Mk20_MRCO_pointer_F",
		/* Primary weapon Magazine */
		"30Rnd_556x45_Stanag",
		/* Primary Weapon Items */
		["muzzle_snds_M"]
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
		"hgun_ACPC2_F",
		/* Handgun Weapon Magazine */
		"9Rnd_45ACP_Mag",
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
			"SmokeShellPurple","SmokeShellPurple","SmokeShellPurple",
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
		"tf_anprc155",
		/* Backpack-Weapons */
		[], 
		/* Backpack-Magazines */
		[],
		/* Backpack-Items */
		[
			"AGM_Bandage","AGM_Bandage","AGM_Bandage","AGM_Bandage","AGM_Bandage",
			"AGM_Bandage","AGM_Bandage","AGM_Bandage","AGM_Bandage","AGM_Bandage",
			"AGM_Morphine","AGM_Morphine","AGM_Morphine","AGM_Morphine","AGM_Morphine",
			"AGM_Morphine","AGM_Morphine","AGM_Morphine","AGM_Morphine","AGM_Morphine",
			"AGM_Epipen",	"AGM_Epipen",	"AGM_Epipen",	"AGM_Epipen",	"AGM_Epipen",
			"AGM_Epipen",	"AGM_Epipen",	"AGM_Epipen",	"AGM_Epipen",	"AGM_Epipen",
			"AGM_Bloodbag","AGM_Bloodbag","AGM_Bloodbag","AGM_Bloodbag","AGM_Bloodbag","AGM_Bloodbag"
		]
	],
	
	/* Code */
	"_unit setVariable ['AGM_IsEOD', false];_unit setVariable ['AGM_IsMedic', true];"
];

_result;