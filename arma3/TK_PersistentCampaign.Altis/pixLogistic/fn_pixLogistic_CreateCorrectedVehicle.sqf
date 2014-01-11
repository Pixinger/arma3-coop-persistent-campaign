/* Dieses Skript arbeitet eigentlich genau wie createVehicle, nur werden noch alle Laderäume gelöscht */
private["_classname"];
_classname = _this select 0;
private["_position"];
_position = _this select 1;

/* Fahrzeug erstellen */
private["_object"];
_object = _classname createVehicle _position;
waitUntil {!isNil "_object"};
/*Sleep 0.2;*/

/* Fahrzeuge bei denen der Frachtraum geleert wird */
private["_vehicleClearCargoTypes"];
_vehicleClearCargoTypes = [
	"B_APC_Wheeled_01_cannon_F",
	"B_APC_Tracked_01_AA_F",
	"B_APC_Tracked_01_rcws_F",
	"B_APC_Tracked_01_CRV_F",
	"B_MBT_01_cannon_F",
	"B_MBT_01_arty_F",
	"B_MBT_01_mlrs_F",
	"B_Heli_Light_01_armed_F",
	"B_Heli_Attack_01_F",
	"B_Heli_Light_01_F",
	"B_Heli_Transport_01_F",
	"B_Heli_Transport_01_camo_F",
	"I_Plane_Fighter_03_AA_F",
	"I_Plane_Fighter_03_CAS_F",
	"B_Truck_01_mover_F",
	"B_Truck_01_box_F",
	"B_Truck_01_transport_F",
	"B_Truck_01_covered_F",
	"B_MRAP_01_F",
	"B_MRAP_01_gmg_F",
	"B_MRAP_01_hmg_F",
	"B_Quadbike_01_F",
	"B_Truck_01_Repair_F",
	"B_Truck_01_ammo_F",
	"B_Truck_01_medical_F",
	"B_Truck_01_fuel_F",
	"B_UGV_01_rcws_F",
	"B_UGV_01_F",
	"B_UAV_02_CAS_F",
	"B_UAV_02_F",
	"B_UAV_01_F",
	"B_Boat_Transport_01_F",
	"B_Lifeboat",
	"B_Boat_Armed_01_minigun_F",
	"B_SDV_01_F"
];

/* Frachtraum löschen */
if (_classname in _vehicleClearCargoTypes) then
{ 
	clearMagazineCargoGlobal _object;
	clearWeaponCargoGlobal _object;
	clearItemCargoGlobal _object;
};

/* UAV Fix */
if(getNumber(configFile >> "CfgVehicles" >> _classname >> "isUav")==1) then 
{
	createVehicleCrew _object; 
	
	if (_classname == "B_UGV_01_F") then
	{
		_object setCaptive 1;
	};
	if (_classname == "B_UAV_01_F") then
	{
		_object setCaptive 1;
		_object setPos [((getPos _object) select 0), ((getPos _object) select 1), 0.3];		
	};
};

/* BOX: Empty */
if (_classname == "Box_NATO_AmmoVeh_F") then
{ 
	clearMagazineCargoGlobal _object;
	clearWeaponCargoGlobal _object;
	clearItemCargoGlobal _object;
	clearBackpackCargoGlobal _object;
};

/* BOX: Waffen */
if (_classname == "Box_NATO_Wps_F") then
{ 
	clearMagazineCargoGlobal _object;
	clearWeaponCargoGlobal _object;
	clearItemCargoGlobal _object;
	clearBackpackCargoGlobal _object;
};

/* BOX: Waffen spezial */
if (_classname == "Box_NATO_WpsSpecial_F") then
{ 
	clearMagazineCargoGlobal _object;
	clearWeaponCargoGlobal _object;
	clearItemCargoGlobal _object;
	clearBackpackCargoGlobal _object;
};

/* BOX: Ammunition */
if (_classname == "Box_NATO_Ammo_F") then
{ 
	clearMagazineCargoGlobal _object;
	clearWeaponCargoGlobal _object;
	clearItemCargoGlobal _object;
	clearBackpackCargoGlobal _object;

	_object	addMagazineCargoGlobal["30Rnd_65x39_caseless_mag", 7];
	_object	addMagazineCargoGlobal["30Rnd_65x39_caseless_mag_Tracer", 7];
	_object	addMagazineCargoGlobal["100Rnd_65x39_caseless_mag", 7];
	_object	addMagazineCargoGlobal["100Rnd_65x39_caseless_mag_Tracer", 7];
	_object	addMagazineCargoGlobal["200Rnd_65x39_cased_Box", 7];
	_object	addMagazineCargoGlobal["200Rnd_65x39_cased_Box_Tracer", 7];
	_object	addMagazineCargoGlobal["20Rnd_762x51_Mag", 7];
	_object	addMagazineCargoGlobal["11Rnd_45ACP_Mag", 7];
	_object	addMagazineCargoGlobal["7Rnd_408_Mag", 7];
};

/* BOX: Launcher */
if (_classname == "Box_LAUNCHER") then
{ 
	clearMagazineCargoGlobal _object;
	clearWeaponCargoGlobal _object;
	clearItemCargoGlobal _object;
	clearBackpackCargoGlobal _object;

	_object	addMagazineCargoGlobal["NLAW_F",10];
	_object	addMagazineCargoGlobal["Titan_AT",10];
	_object	addMagazineCargoGlobal["Titan_AP",10];
	_object	addMagazineCargoGlobal["Titan_AA",10];	
};
	
/* BOX: Explosives */
if (_classname == "Box_NATO_AmmoOrd_F") then
{ 
	clearMagazineCargoGlobal _object;
	clearWeaponCargoGlobal _object;
	clearItemCargoGlobal _object;
	clearBackpackCargoGlobal _object;

	_object	addItemCargoGlobal["MineDetector",1];
	_object	addMagazineCargoGlobal["SatchelCharge_Remote_Mag",10];
	_object	addMagazineCargoGlobal["DemoCharge_Remote_Mag",10];
	_object	addMagazineCargoGlobal["ATMine_Range_Mag",10];
	_object	addMagazineCargoGlobal["APERSMine_Range_Mag",10];
	_object	addMagazineCargoGlobal["APERSBoundingMine_Range_Mag",10];
	_object	addMagazineCargoGlobal["SLAMDirectionalMine_Wire_Mag",10];
	_object	addMagazineCargoGlobal["APERSTripMine_Wire_Mag",10];	
};

/* BOX: Grenades */
if (_classname == "Box_NATO_Grenades_F") then
{ 
	clearMagazineCargoGlobal _object;
	clearWeaponCargoGlobal _object;
	clearItemCargoGlobal _object;
	clearBackpackCargoGlobal _object;

	_object	addMagazineCargoGlobal["HandGrenade",10];
	_object	addMagazineCargoGlobal["SmokeShell",10];
	_object	addMagazineCargoGlobal["SmokeShellPurple",10];
	_object	addMagazineCargoGlobal["SmokeShellRed",10];
	_object	addMagazineCargoGlobal["Chemlight_green",5];
	_object	addMagazineCargoGlobal["Chemlight_red",5];
	_object	addMagazineCargoGlobal["3Rnd_HE_Grenade_shell",10];	
	_object	addMagazineCargoGlobal["1Rnd_HE_Grenade_shell",10];		
};

/* BOX: Items */
if (_classname == "Box_NATO_Support_F") then
{ 
	clearMagazineCargoGlobal _object;
	clearWeaponCargoGlobal _object;
	clearItemCargoGlobal _object;
	clearBackpackCargoGlobal _object;

	_object	addItemCargoGlobal["FirstAidKit", 30];
	_object	addItemCargoGlobal["Toolkit", 1];
	_object	addItemCargoGlobal["Rangefinder", 1];
	_object	addItemCargoGlobal["optic_TWS", 1];
	_object	addItemCargoGlobal["optic_TWS_MG", 1];
	_object	addItemCargoGlobal["optic_Holosight", 1];
	_object	addItemCargoGlobal["optic_Arco", 1];
	_object	addItemCargoGlobal["optic_Hamr", 1];
	_object	addItemCargoGlobal["optic_MRCO", 1];	 	
	_object addItemCargoGlobal["optic_SOS", 1];		
	/*_object	addItemCargoGlobal["ItemRadio", 5];	*/
};

_object