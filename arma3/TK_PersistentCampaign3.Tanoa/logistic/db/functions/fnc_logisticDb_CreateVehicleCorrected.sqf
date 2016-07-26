#include "..\..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

// Dieses Skript arbeitet eigentlich genau wie createVehicle, nur werden noch nachtr�glich noch �nderungen durchgef�hrt.
private["_classname"];
_classname = _this select 0;
private["_position"];
_position = _this select 1;
private["_direction"];
_direction = _this select 2;

// Fahrzeug erstellen
private["_object"];
_object = createVehicle [_classname, [_position select 0, _position select 1, _position select 2], [], 0, "CAN_COLLIDE"]; //_object = _classname createVehicle _position;
waitUntil {!isNil "_object"};
_object setPosATL [_position select 0, _position select 1, _position select 2];
_object setDir _direction;

// Bei einem UAV/UGV autmatisch die Crew erstellen
if ((_object isKindOf "UGV_01_base_F") || (_object isKindOf "UAV_01_base_F") || (_object isKindOf "UAV_02_base_F") || (_object isKindOf "UAV_03_base_F")) then 
{
	createVehicleCrew _object; 
};
if (_object isKindOf "Land_BarGate_F") then 
{
	_object allowDamage false;
};

clearItemCargoGlobal _object;
clearWeaponCargoGlobal _object;
clearMagazineCargoGlobal _object;
clearBackpackCargoGlobal _object;

_object;