#include "..\..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

if (isServer) then
{
	DEBUG_LOG("LOGISTIC-Database: ------------------------ (begin)");
	DEBUG_LOG("LOGISTIC-Database: saving");

	// ------------------------------------------------------------------------------
	// Vorbereiten
	waitUntil { logisticDbInitCompleted };
	waitUntil { !logisticDbSaving };
	logisticDbSaving = true;
	"LOGISTIC-Database saving" remoteExec ["hint"];

	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	#include "_databaseIndexes.hpp"

	//------------------------------------
	// Fahrzeuge
	//------------------------------------
	private["_databaseVehicles"];
	_databaseVehicles = [];
	if (count logisticDbVehicles > 0) then
	{
		// ...auf der Map finden
		private["_vehicles"];
		_vehicles = nearestObjects [logisticDbMapCenter, logisticDbVehicles, logisticDbMapRadiusSqr];
		{	
			// Nur wenn wir das Fahrzeug nicht ignorieren sollen
			if (!(_x getVariable ["dbIgnore", false])) then
			{
				_databaseVehicles pushBack [
					typeof(_x), 
					(getPosATL _x), 
					(getDir _x), 
					([_x] call fnc_logisticDb_GetVehicleDamageArray), 
					([_x] call fnc_logisticDb_GetVehicleCargoArray),
					(_x getVariable ["dbVar", []])
				];
			};
		} foreach _vehicles; 
		INFO_LOG_VAREX("saved vehicles: ", (count _vehicles));
	};


	//------------------------------------
	// ReammoBox
	//------------------------------------
	private["_databaseAmmoboxes"];
	_databaseAmmoboxes = [];
	if (count logisticDbAmmoboxes > 0) then
	{
		// Objekte suchen
		private["_ammoboxes"];
		_ammoboxes = nearestObjects [logisticDbMapCenter, logisticDbAmmoboxes, logisticDbMapRadiusSqr];
		{	
			// Nur wenn wir die Ammobox nicht ignorieren sollen
			if (!(_x getVariable ["dbIgnore", false])) then
			{
				_databaseAmmoboxes pushBack [
					typeof(_x), 
					(getPosATL _x), 
					(getDir _x), 
					(getDammage _x), 
					([_x] call fnc_logisticDb_GetVehicleCargoArray),
					(_x getVariable ["dbVar", []])
				];
			};
		} foreach _ammoboxes; 
		INFO_LOG_VAREX("saved ammoboxes: ", (count _ammoboxes));
	};

	//------------------------------------
	// Objekte
	//------------------------------------
	private["_databaseObjects"];
	_databaseObjects = [];
	if (count logisticDbObjects > 0) then
	{
		private["_objects"];
		_objects = nearestObjects [logisticDbMapCenter, logisticDbObjects, logisticDbMapRadiusSqr];
		{	
			// Nur wenn wir die Ammobox nicht ignorieren sollen
			if (!(_x getVariable ["dbIgnore", false])) then
			{
				_databaseObjects pushBack [
					typeof(_x), 
					(getPosATL _x), 
					(getDir _x), 
					(getDammage _x),
					(_x getVariable ["dbVar", []])
				];
			};
		} foreach _objects; 
		INFO_LOG_VAREX("saved objects: ", (count _objects));
	};

	//------------------------------------
	// TIME
	//------------------------------------
	private _databaseTime = date; // [year, month, day, hour, minute]	

	//------------------------------------
	// Datenbank erstellen
	//------------------------------------
	private["_database"];
	_database = [_databaseVehicles, _databaseAmmoboxes, _databaseObjects, _databaseTime];
	profileNameSpace setVariable [logisticDbPrefix + "_database", _database];
	//INFO_LOG_VAR(_database);
	DEBUG_LOG("LOGISTIC-Database: ------------------------ (end)");
	
	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	"LOGISTIC-Database saving complete" remoteExec ["hint"];

	// ------------------------------------------------------------------------------
	// Nachbereiten
	logisticDbSaving = false;
};