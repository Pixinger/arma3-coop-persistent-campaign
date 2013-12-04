private["_result"];
_result = [
	/* Goggles */
	"G_Sport_Greenblack",
	
	/* Headgear */
	"H_Cap_blk_Raven",
	
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
		"launch_NLAW_F",
		/* Secondary weapon Magazine */
		"NLAW_F",
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
		"U_I_CombatUniform_shortsleeve", 
		/* Uniform-Weapons */
		[], 
		/* Uniform-Magazines */
		["SmokeShell","SmokeShell","HandGrenade","HandGrenade", "SmokeShellRed"],
		/* Uniform-Items */
		["ItemRadio","FirstAidKit","FirstAidKit"]
	],
	
	/* Vest */
	[	
		"V_PlateCarrierIA2_dgtl", 
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
		"B_FieldPack_oli", 
		/* Backpack-Weapons */
		[], 
		/* Backpack-Magazines */
		[	
			"NLAW_F",
			"NLAW_F"
		],
		/* Backpack-Items */
		[
			"H_HelmetIA",
			"optic_DMS",//TODO: MG?
			"ToolKit",
			"100Rnd_65x39_caseless_mag",
			"200Rnd_65x39_cased_Box_Tracer",
			"200Rnd_65x39_cased_Box_Tracer"
		]
	]
];

_result;