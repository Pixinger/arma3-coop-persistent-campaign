#include "_databaseIndexes.hpp"

//------------------------------------
// Fahrzeuge
//------------------------------------
// ...auf der Map finden
private["_vehicles"];
//_vehicles = nearestObjects [dbMapCenter, dbVehicles, dbMapRadiusSqr];
_vehicles = nearestObjects [getpos player, dbVehicles, 1000];
diag_log format["_vehicles=%1", _vehicles];

// Datenbank-Array erstellen
private["_databaseVehicles"];
_databaseVehicles = [];
{	
	// Nur wenn wir das Fahrzeug nicht ignorieren sollen
	if (!(_x getVariable ["dbIgnore", false])) then
	{
		diag_log format["db-save-vehicle: %1", _x];
		_databaseVehicles pushBack [typeof(_x), (getPosATL _x), (getDir _x), ([_x] call fnc_db_GetVehicleDamageArray), ([_x] call fnc_db_GetVehicleCargoArray)];
	};
} foreach _vehicles; 


//------------------------------------
// ReammoBox
//------------------------------------
private["_ammoboxes"];
//_vehicles = nearestObjects [dbMapCenter, dbAmmoboxes, dbMapRadiusSqr];
_ammoboxes = nearestObjects [getpos player, dbAmmoboxes, 1000];
diag_log format["_ammoboxes=%1", _ammoboxes];

// Datenbank-Array erstellen
private["_databaseAmmoboxes"];
_databaseAmmoboxes = [];
{	
	// Nur wenn wir die Ammobox nicht ignorieren sollen
	if (!(_x getVariable ["dbIgnore", false])) then
	{
		diag_log format["db-save-ammobox: %1", _x];
		_databaseAmmoboxes pushBack [typeof(_x), (getPosATL _x), (getDir _x), (getDammage _x), ([_x] call fnc_db_GetVehicleCargoArray)];
	};
} foreach _ammoboxes; 

//------------------------------------
// Objekte
//------------------------------------
private["_objects"];
//_objects = nearestObjects [dbMapCenter, dbObjects, dbMapRadiusSqr];
_objects = nearestObjects [getpos player, dbObjects, 1000];
diag_log format["_objects=%1", _objects];

// Datenbank-Array erstellen
private["_databaseObjects"];
_databaseObjects = [];
{	
	// Nur wenn wir die Ammobox nicht ignorieren sollen
	if (!(_x getVariable ["dbIgnore", false])) then
	{
		diag_log format["db-save-_objects: %1", _x];
		_databaseObjects pushBack [typeof(_x), (getPosATL _x), (getDir _x), (getDammage _x)];
	};
} foreach _objects; 

//------------------------------------
// Datenbank erstellen
//------------------------------------
private["_database"];
_database = [_databaseVehicles, _databaseAmmoboxes, _databaseObjects];
diag_log format["Final database: %1", _database];
profileNameSpace setVariable [dbProfilenamespacePrefix + "_database", _database];
