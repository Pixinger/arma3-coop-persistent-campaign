if (isServer) then
{
	diag_log "LOGISTIC-Database saving";

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
		diag_log format["saving %1 vehicles", count _vehicles];
		//_vehicles = nearestObjects [getpos player, logisticDbVehicles, 1000];
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
		//_ammoboxes = nearestObjects [getpos player, logisticDbAmmoboxes, 1000];
		_ammoboxes = nearestObjects [logisticDbMapCenter, logisticDbAmmoboxes, logisticDbMapRadiusSqr];
		diag_log format["saving %1 ammoboxes", count _ammoboxes];

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
		//_objects = nearestObjects [getpos player, logisticDbObjects, 1000];
		diag_log format["saving %1 objects", count _objects];

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
	if (pixDebug) then { diag_log format["Final database: %1", _database]; };
	profileNameSpace setVariable [logisticDbPrefix + "_database", _database];
	
	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	"LOGISTIC-Database saving complete" remoteExec ["hint"];

	// ------------------------------------------------------------------------------
	// Nachbereiten
	logisticDbSaving = false;
};