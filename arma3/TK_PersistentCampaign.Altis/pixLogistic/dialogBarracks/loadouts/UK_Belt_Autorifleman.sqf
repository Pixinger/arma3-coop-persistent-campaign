private["_result"];
_result = [
	/* Goggles */
	"G_Sport_Red",
	
	/* Headgear */
	"H_Cap_khaki_specops_UK",
	
	/* Binoculars */
	"Laserdesignator",
	
	/* Nightvision */
	"NVGoggles",
	
	/* Linked Items */
	[
		"ItemMap",
		"ItemWatch",
		"ItemCompass",
		"B_UavTerminal"
	],
	
	/* Primary Weapon */
	[
		"LMG_Mk200_pointer_F", //TODO
		/* Primary weapon Magazine */
		"200Rnd_65x39_cased_Box",
		/* Primary Weapon Items */
		["optic_Arco","acc_pointer_IR","muzzle_snds_H_MG"]
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
		"U_B_CTRG_1", 
		/* Uniform-Weapons */
		[], 
		/* Uniform-Magazines */
		["SmokeShell","SmokeShell","HandGrenade","HandGrenade"],
		/* Uniform-Items */
		["ItemRadio","FirstAidKit","FirstAidKit"]
	],
	
	/* Vest */
	[	
		"V_PlateCarrierH_CTRG", 
		/* Vest-Weapons */
		[], 
		/* Vest-Magazines */
		[
			"200Rnd_65x39_cased_Box",
			"200Rnd_65x39_cased_Box",
			"200Rnd_65x39_cased_Box"
		],
		/* Vest-Items */
		[]
	],
	
	/* Backpack */
	[
		"B_Bergen_blk", 
		/* Backpack-Weapons */
		[], 
		/* Backpack-Magazines */
		[	
			"200Rnd_65x39_cased_Box",
			"200Rnd_65x39_cased_Box_Tracer",
			"200Rnd_65x39_cased_Box_Tracer"
		],
		/* Backpack-Items */
		[
			"H_HelmetB_snakeskin",
			"optic_DMS"
		]
	]
];

_result;