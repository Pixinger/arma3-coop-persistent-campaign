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
		"srifle_EBR_ARCO_pointer_F", //TODO
		/* Primary weapon Magazine */
		"20Rnd_762x51_Mag",
		/* Primary Weapon Items */
		["optic_Arco","acc_pointer_IR","muzzle_snds_H"]
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
		"U_I_CombatUniform", 
		/* Uniform-Weapons */
		[], 
		/* Uniform-Magazines */
		["SmokeShell","SmokeShell","HandGrenade","HandGrenade", "SmokeShellRed"],
		/* Uniform-Items */
		["ItemRadio","ItemGps","FirstAidKit","FirstAidKit"]
	],
	
	/* Vest */
	[	
		"V_PlateCarrierIA2_dgtl", 
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
		"B_Carryall_oli", 
		/* Backpack-Weapons */
		[], 
		/* Backpack-Magazines */
		[	
			"NLAW_F",
			"NLAW_F",
			"SatchelCharge_Remote_Mag",
			"DemoCharge_Remote_Mag",
			"DemoCharge_Remote_Mag",
			"DemoCharge_Remote_Mag",
			"20Rnd_762x51_Mag"
		],
		/* Backpack-Items */
		[
			"H_HelmetIA",
			"optic_SOS",//TODO: MG?
			"ToolKit"
		]
	]
];

_result;