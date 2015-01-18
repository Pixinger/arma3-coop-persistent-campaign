private["_result"];
_result = [
	/* Goggles */
	"G_Tactical_Clear",
	
	/* Headgear */
	"H_HelmetB",
	
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
		"srifle_EBR_ARCO_pointer_F", //TODO
		/* Primary weapon Magazine */
		"20Rnd_762x51_Mag",
		/* Primary Weapon Items */
		["optic_Arco","acc_pointer_IR","muzzle_snds_B"]
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
		[""]
	],
	
	/* Uniform */
	[
		"U_B_CombatUniform_mcam", 
		/* Uniform-Weapons */
		[], 
		/* Uniform-Magazines */
		["SmokeShell","SmokeShell","HandGrenade","HandGrenade"],
		/* Uniform-Items */
		["ItemRadio","FirstAidKit","FirstAidKit"]
	],
	
	/* Vest */
	[	
		"V_PlateCarrier3_rgr", 
		/* Vest-Weapons */
		[], 
		/* Vest-Magazines */
		[
			"20Rnd_762x51_Mag",
			"20Rnd_762x51_Mag",
			"20Rnd_762x51_Mag",
			"20Rnd_762x51_Mag"
		],
		/* Vest-Items */
		[]
	],
	
	/* Backpack */
	[
		"B_Bergen_sgg", 
		/* Backpack-Weapons */
		[], 
		/* Backpack-Magazines */
		[	
			"SatchelCharge_Remote_Mag",
			"DemoCharge_Remote_Mag",
			"AGM_CableTie",
			"AGM_CableTie",
			"AGM_CableTie",
			"AGM_CableTie",
			"AGM_CableTie"
		],
		/* Backpack-Items */
		[
			"ToolKit"
		]
	],
	
	/* Code */
	"_unit setVariable ['AGM_IsEOD', true];"
];

_result;