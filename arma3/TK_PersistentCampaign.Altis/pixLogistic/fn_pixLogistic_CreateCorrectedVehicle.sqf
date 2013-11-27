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
};

/* ACRE Box fixen */
if (_classname == "ACRE_RadioBox") then
{ 
	clearMagazineCargoGlobal _object;
	clearWeaponCargoGlobal _object;
	clearItemCargoGlobal _object;
	removeallweapons _object;  
	removeallassigneditems _object;  
	removeuniform _object;  
	removevest _object;  
	removebackpack _object; 
	_object	addItemCargoGlobal["ACRE_PRC148",50];
	_object addItemCargoGlobal ["ACRE_PRC119",25];	
	_object addBackpackCargoGlobal ["ACRE_PRC117F",25];	
};

if (_classname == "Box_NATO_AmmoVeh_F") then
{ 
	_object	addItemCargoGlobal["optic_Arco",10];
	_object	addItemCargoGlobal["optic_Hamr",10];
	_object	addItemCargoGlobal["optic_MRCO",10];	 	
	_object addItemCargoGlobal["optic_Holosight",25];	 	
	_object addItemCargoGlobal["optic_SOS",3];	
	_object addItemCargoGlobal["optic_TWS",3];	
	_object addItemCargoGlobal["optic_TWS_MG",3];	
};

if (_classname == "Box_NATO_Wps_F") then
{ 
	clearMagazineCargoGlobal _object;
	clearWeaponCargoGlobal _object;
	clearItemCargoGlobal _object;
	clearBackpackCargoGlobal _object;

	_object	addItemCargoGlobal["ItemGPS",8];
	_object	addItemCargoGlobal["Rangefinder",8];
	_object addItemCargoGlobal["optic_Holosight",8];
	_object addItemCargoGlobal["optic_TWS",1];	
	_object addItemCargoGlobal["optic_TWS_MG",1];	
	_object	addWeaponCargoGlobal["arifle_MX_GL_Hamr_pointer_F",3];
	_object	addWeaponCargoGlobal["arifle_MXM_SOS_pointer_F",3];
	_object	addWeaponCargoGlobal["LMG_Zafir_pointer_F",2];
	_object	addWeaponCargoGlobal["srifle_EBR_ARCO_pointer_F",2];
	_object	addWeaponCargoGlobal["srifle_GM6_SOS_F",1];
	_object	addWeaponCargoGlobal["srifle_LRR_SOS_F",1];
};


_object