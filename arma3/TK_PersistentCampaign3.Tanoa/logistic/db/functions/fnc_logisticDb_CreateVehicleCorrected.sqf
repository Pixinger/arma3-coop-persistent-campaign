#include "..\..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

// Dieses Skript arbeitet eigentlich genau wie createVehicle, nur werden noch nachträglich noch änderungen durchgeführt.
private["_classname"];
_classname = _this select 0;
private["_position"];
_position = _this select 1;
private["_direction"];
_direction = _this select 2;

// Classname Translation
if (_classname == "Land_HBarrier_1_F") then { _classname = "Land_HBarrier_01_line_1_green_F"; };
if (_classname == "Land_HBarrier_3_F") then { _classname = "Land_HBarrier_01_line_3_green_F"; };
if (_classname == "Land_HBarrier_5_F") then { _classname = "Land_HBarrier_01_line_5_green_F"; };
if (_classname == "Land_BagFence_Long_F") then { _classname = "Land_BagFence_01_long_green_F"; };
if (_classname == "Land_BagBunker_Small_F") then { _classname = "Land_BagBunker_01_small_green_F"; };
if (_classname == "Land_BagBunker_Large_F") then { _classname = "Land_BagBunker_01_large_green_F"; };

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