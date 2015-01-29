private["_result"];
_result = [
	/* Goggles */
	"",//G_Tactical_Clear
	
	/* Headgear */
	"H_HelmetIA_net",
	
	/* Binoculars */
	"Binocular",
	
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
		"U_I_CombatUniform_tshirt", 
		/* Uniform-Weapons */
		[], 
		/* Uniform-Magazines */
		[
		],
		/* Uniform-Items */
		[
			"ItemRadio",
			"AGM_Epipen","AGM_Epipen","AGM_Epipen",
			"AGM_Bandage","AGM_Bandage","AGM_Bandage","AGM_Bandage",
			"AGM_Morphine","AGM_Morphine","AGM_Morphine","AGM_Morphine",			
			"AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie","AGM_CableTie"			
		]
	],
	
	/* Vest */
	[
		"V_PlateCarrierIA1_dgtl",
		/* Vest-Weapons */
		[
			"SmokeShell","SmokeShell",
			"SmokeShellGreen","SmokeShellGreen"
		], 
		/* Vest-Magazines */
		[
			"AGM_IR_Strobe_Item",
			"AGM_Bandage","AGM_Bandage","AGM_Bandage","AGM_Bandage",
			"MiniGrenade","MiniGrenade",
			"30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag",
			"9Rnd_45ACP_Mag"
		],
		/* Vest-Items */
		[
		]
	],
	
	/* Backpack */
	[
		"I_Fieldpack_oli_Repair",
		/* Backpack-Weapons */
		[
		], 
		/* Backpack-Magazines */
		[
			"MiniGrenade","MiniGrenade","MiniGrenade","MiniGrenade",
			"9Rnd_45ACP_Mag","9Rnd_45ACP_Mag"
		],
		/* Backpack-Items */
		[
		]
	],
	
	/* Code */
	"_unit setVariable ['AGM_IsEOD', true];_unit setVariable ['AGM_IsMedic', false];"
];

_result;