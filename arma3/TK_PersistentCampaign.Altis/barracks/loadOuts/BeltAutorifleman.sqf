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
		"LMG_Mk200_pointer_F", //TODO
		/* Primary weapon Magazine */
		"200Rnd_65x39_cased_Box",
		/* Primary Weapon Items */
		["optic_Hamr","acc_pointer_IR","muzzle_snds_H_MG"]
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
			"200Rnd_65x39_cased_Box",
			"200Rnd_65x39_cased_Box",
			"200Rnd_65x39_cased_Box"
		],
		/* Vest-Items */
		[]
	],

	/* Backpack */
	[
		_backpack,
		/* Backpack-Weapons */
		[],
		/* Backpack-Magazines */
		[
			"200Rnd_65x39_cased_Box_Tracer",
			"200Rnd_65x39_cased_Box_Tracer",
			"200Rnd_65x39_cased_Box_Tracer"
		],
		/* Backpack-Items */
		[
			"x39_bandage",	
			"x39_bandage",
			"x39_bandage",
			"x39_bandage",
			"x39_bandage",
			"x39_bandage",
			"x39_bandage",
			"x39_bandage",
			"x39_bandage",
			"x39_bandage",
			"x39_bandage",	
			"x39_bandage",
			"x39_bandage",
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
			"x39_morphine",			
			"x39_morphine",
			"x39_morphine",
			"x39_morphine",
			"x39_morphine",
			"x39_morphine",			
			"optic_DMS"
		]
	]
];

player sidechat str(_result);
_result;