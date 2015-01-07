private["_result"];
_result = [
	/* Goggles */
	"G_Sport_Greenblack",
	
	/* Headgear */
	"H_HelmetB",
	
	/* Binoculars */
	"Laserdesignator",
	
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
		["optic_Arco","acc_pointer_IR","muzzle_snds_H"]
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
		"hgun_Pistol_heavy_01_MRD_F",
		/* Handgun Weapon Magazine */
		"11Rnd_45ACP_Mag",
		/* Handgun Weapon Items */
		["muzzle_snds_acp"]
	],
	
	/* Uniform */
	[
		"U_B_CombatUniform_mcam", 
		/* Uniform-Weapons */
		[], 
		/* Uniform-Magazines */
		["SmokeShell","SmokeShell","SmokeShell","SmokeShell","HandGrenade","HandGrenade"],
		/* Uniform-Items */
		["ItemRadio","ItemGps"]
	],
	
	/* Vest */
	[	
		"V_PlateCarrier3_rgr", 
		/* Vest-Weapons */
		[], 
		/* Vest-Magazines */
		[
			"30Rnd_65x39_caseless_mag",
			"30Rnd_65x39_caseless_mag",
			"30Rnd_65x39_caseless_mag",
			"30Rnd_65x39_caseless_mag"
		],
		/* Vest-Items */
		["FirstAidKit","FirstAidKit"]
	],
	
	/* Backpack */
	[
		"B_Bergen_sgg", 
		/* Backpack-Weapons */
		[], 
		/* Backpack-Magazines */
		[	
			"SmokeShellPurple",
			"SmokeShellPurple",
			"SmokeShellPurple",
			"AGM_CableTie",
			"AGM_CableTie",
			"AGM_CableTie",
			"AGM_CableTie",
			"AGM_CableTie"
		],
		/* Backpack-Items */
		[
			"Medikit",
			"FirstAidKit",
			"FirstAidKit",
			"FirstAidKit",
			"FirstAidKit",
			"FirstAidKit",
			"FirstAidKit"
		]
	],
	
	/* Code */
	"_unit setVariable ['AGM_IsMedic', true];"
];

_result;