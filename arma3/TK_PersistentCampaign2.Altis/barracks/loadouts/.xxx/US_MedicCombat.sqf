private["_result"];
_result = [
	/* Goggles */
	"", //G_Tactical_Clear
	
	/* Headgear */
	"H_HelmetB_light_desert",
	
	/* Binoculars */
	"AGM_Vector",
	
	/* Nightvision */
	"NVGoggles",
	
	/* Linked Items */
	[
		"ItemMap",
		"ItemWatch",
		"ItemCompass",
		"ItemGps"
	],
	
	/* Primary Weapon */
	[
		"arifle_MX_F",
		/* Primary weapon Magazine */
		"30Rnd_65x39_caseless_mag",
		/* Primary Weapon Items */
		["optic_Arco"]
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
		"hgun_P07_F",
		/* Handgun Weapon Magazine */
		"16Rnd_9x21_Mag",
		/* Handgun Weapon Items */
		[]
	],
	
	/* Uniform */
	[
		"U_B_CombatUniform_mcam_tshirt", 
		/* Uniform-Weapons */
		[], 
		/* Uniform-Magazines */
		[],
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
		"V_PlateCarrierSpec_rgr", //V_PlateCarrier1_rgr
		/* Vest-Weapons */
		[
			"SmokeShell","SmokeShell",
			"SmokeShellPurple","SmokeShellPurple",
			"SmokeShellGreen","SmokeShellGreen"
		], 
		/* Vest-Magazines */
		[
			"30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag",
			"16Rnd_9x21_Mag","16Rnd_9x21_Mag"
		],
		/* Vest-Items */
		[
		]
	],
	
	/* Backpack */
	[
		"B_AssaultPack_mcamo", //B_Bergen_sgg
		/* Backpack-Weapons */
		[], 
		/* Backpack-Magazines */
		[],
		/* Backpack-Items */
		[
			"AGM_Bandage",
			"AGM_Bandage",
			"AGM_Bandage",
			"AGM_Bandage",
			"AGM_Bandage",
			"AGM_Morphine",
			"AGM_Morphine",
			"AGM_Morphine",
			"AGM_Morphine",
			"AGM_Morphine",
			"AGM_Epipen",
			"AGM_Epipen",
			"AGM_Epipen",
			"AGM_Epipen",
			"AGM_Epipen",
			"AGM_Bloodbag",
			"AGM_Bloodbag",
			"AGM_Bloodbag",
			"AGM_Bloodbag",
			"AGM_Bloodbag",
			"AGM_Bloodbag"
		]
	],
	
	/* Code */
	"_unit setVariable ['AGM_IsMedic', true];"
];

_result;