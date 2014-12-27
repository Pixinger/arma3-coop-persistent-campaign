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
		"B_UavTerminal"
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
			"20Rnd_762x51_Mag",
			"20Rnd_762x51_Mag",
			"20Rnd_762x51_Mag",
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
			"DemoCharge_Remote_Mag"
		],
		/* Backpack-Items */
		[
			"ToolKit"
		]
	],
	
	/* unit classname */
	"B_engineer_F"
];

_result;