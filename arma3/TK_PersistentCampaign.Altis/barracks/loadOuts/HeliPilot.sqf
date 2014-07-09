private["_result"];
_result = [
	/* Goggles */
	"G_Sport_BlackWhite",
	
	/* Headgear */
	"H_PilotHelmetHeli_B",
	
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
		"SMG_01_Holo_F",
		/* Primary weapon Magazine */
		"30Rnd_45ACP_Mag_SMG_01",
		/* Primary Weapon Items */
		["acc_pointer_IR", "muzzle_snds_acp"]
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
		"U_B_HeliPilotCoveralls", 
		/* Uniform-Weapons */
		[], 
		/* Uniform-Magazines */
		["SmokeShell","HandGrenade","30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01"],
		/* Uniform-Items */
		["ItemRadio", "x39_earplug", "x39_bandage", "x39_morphine"]
	],
	
	/* Vest */
	[	
		"", 
		/* Vest-Weapons */
		[], 
		/* Vest-Magazines */
		[			
		],
		/* Vest-Items */
		[]
	],
	
	/* Backpack */
	[
		"B_Parachute", 
		/* Backpack-Weapons */
		[], 
		/* Backpack-Magazines */
		[	
		],
		/* Backpack-Items */
		[
		]
	],
	
	/* unit classname */
	"B_Helipilot_F"
];

_result;