private["_goggles"];
_goggles = _this select 0;
private["_helmet"];
_helmet = _this select 1;
private["_uniform"];
_uniform = _this select 2;
private["_vest"];
_vest = _this select 3;
private["_backpack"];
_backpack = _this select 4;
private["_classname"];
_classname = _this select 5;


private["_result"];
_result = [
	/* Goggles */
	_goggles,

	/* Headgear */
	_helmet,

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
		"arifle_MX_GL_Black_F",
		/* Primary weapon Magazine */
		"30Rnd_65x39_caseless_mag",
		/* Primary Weapon Items */
		["optic_Hamr","acc_pointer_IR","muzzle_snds_H"]
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
		_uniform,
		/* Uniform-Weapons */
		[],
		/* Uniform-Magazines */
		["SmokeShell","SmokeShell","HandGrenade","HandGrenade"],
		/* Uniform-Items */
		["ItemRadio","x39_medikit","x39_earplug"]
	],

	/* Vest */
	[
		_vest,
		/* Vest-Weapons */
		[],
		/* Vest-Magazines */
		[			
			"30Rnd_65x39_caseless_mag",
			"30Rnd_65x39_caseless_mag",
			"30Rnd_65x39_caseless_mag",
			"30Rnd_65x39_caseless_mag",
			"30Rnd_65x39_caseless_mag",
			"30Rnd_65x39_caseless_mag",
			"30Rnd_65x39_caseless_mag",
			"30Rnd_65x39_caseless_mag",
			"30Rnd_65x39_caseless_mag",
			"30Rnd_65x39_caseless_mag_Tracer",
			"30Rnd_65x39_caseless_mag_Tracer",
			"30Rnd_65x39_caseless_mag_Tracer",
			"30Rnd_65x39_caseless_mag_Tracer",
			"30Rnd_65x39_caseless_mag_Tracer"
		],
		/* Vest-Items */
		[ 	
			"optic_Nightstalker",
			"x39_bandage",	
			"x39_bandage",	
			"x39_bandage",	
			"x39_bandage",	
			"x39_bandage",	
			"x39_bandage",	
			"x39_bandage",	
			"x39_morphine",
			"x39_morphine",
			"x39_morphine",
			"x39_morphine",
			"x39_morphine"
			]
	],

	/* Backpack */
	[
		_backpack,
		/* Backpack-Weapons */
		[],
		/* Backpack-Magazines */
		[
			"x39_bandage",	
			"x39_bandage",	
			"x39_bandage",	
			"x39_bandage",	
			"x39_bandage",	
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_HE_Grenade_shell",
			"3Rnd_Smoke_Grenade_shell",
			"3Rnd_Smoke_Grenade_shell",
			"3Rnd_Smoke_Grenade_shell",
			"3Rnd_Smoke_Grenade_shell"
		],
		/* Backpack-Items */
		[
			
		]
	]
];

player sidechat str(_result);
_result;