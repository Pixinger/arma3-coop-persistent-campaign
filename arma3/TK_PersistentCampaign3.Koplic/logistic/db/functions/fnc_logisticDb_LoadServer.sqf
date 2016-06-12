#include "_databaseIndexes.hpp"

if (isServer) then
{
	// ------------------------------------------------------------------------------
	// Vorbereiten
	waitUntil { !logisticDbSaving };
	logisticDbSaving = true;
	"LOGISTIC-Database loading" remoteExec ["hint"];
	diag_log "LOGISTIC-Database: ------------------------";
	diag_log "LOGISTIC-Database: loading";
	
	// Datenbank aus dem VAR-Bereich lesen
	//private _database = [];
	private _database = profileNameSpace getVariable [(logisticDbPrefix + "_database"), []];
	diag_log format["LOGISTIC-Database loaded: %1", _database];

	//------------------------------------
	// Fahrzeuge aus der Datenbank laden und erstellen
	//------------------------------------
	if (count _database > VEHICLE_INDEX) then
	{
		private _vehicles = _database select VEHICLE_INDEX;
		diag_log format["loaded %1 _vehicles", count _vehicles];

		{	
			if (getText(configFile >> "cfgVehicles" >> (_x select 0) >> "vehicleClass") != "") then 
			{
				// _x = [_classname, _position, _direction, _damageArray, _cargoArray, dbVar(optional)];	
				// Fahrzeug erstellen
				private _vehicle = [(_x select 0), (_x select 1), (_x select 2)] call fnc_logisticDb_CreateVehicleCorrected;
				// Schaden hinzufügen
				[_vehicle, (_x select 3)] call  fnc_logisticDb_SetVehicleDamageArray;
				// Ladung hinzufügen
				[_vehicle, (_x select 4)] call  fnc_logisticDb_SetVehicleCargoArray;
				// dbVar
				if (count _x > 5) then { _vehicle setVariable["dbVar", (_x select 5), true]; };		
			};
		} foreach _vehicles; 
	};

	//------------------------------------
	// Ammoboxen aus der Datenbank laden und erstellen
	//------------------------------------
	if (count _database > AMMOBOX_INDEX) then
	{
		private _ammoboxes = _database select AMMOBOX_INDEX;
		diag_log format["loaded %1 _ammoboxes", count _ammoboxes];

		{	
			if (getText(configFile >> "cfgVehicles" >> (_x select 0) >> "vehicleClass") != "") then 
			{
				// _x = [_classname, _position, _direction, _damageArray, _cargoArray, dbVar(optional)];	
				// Fahrzeug erstellen
				private _vehicle = [(_x select 0), (_x select 1), (_x select 2)] call fnc_logisticDb_CreateVehicleCorrected;
				// Schaden hinzufügen
				_vehicle setDamage (_x select 3);
				// Ladung hinzufügen
				[_vehicle, (_x select 4)] call  fnc_logisticDb_SetVehicleCargoArray;
				// dbVar
				if (count _x > 5) then { _vehicle setVariable["dbVar", (_x select 5), true]; };
			};
		} foreach _ammoboxes; 
	};

	//------------------------------------
	// Objekte aus der Datenbank laden und erstellen
	//------------------------------------
	if (count _database > OBJECT_INDEX) then
	{
		private _objects = _database select OBJECT_INDEX;
		diag_log format["loaded %1 _objects", count _objects];

		{	
			if (getText(configFile >> "cfgVehicles" >> (_x select 0) >> "vehicleClass") != "") then 
			{
				// _x = [_classname, _position, _direction, _damageArray, _cargoArray, dbVar(optional)];	
				// Fahrzeug erstellen
				private _vehicle = [(_x select 0), (_x select 1), (_x select 2)] call fnc_logisticDb_CreateVehicleCorrected;
				// Schaden hinzufügen
				_vehicle setDamage (_x select 3);
				// dbVar
				if (count _x > 5) then { _vehicle setVariable["dbVar", (_x select 5), true]; };
			};
		} foreach _objects; 
	};

	//------------------------------------
	// TIME/DATE aus der Datenbank laden 
	//------------------------------------
	private _dateTime = [2016, 06, 11, 15, 00]; // [year, month, day, hour, minute] 
	if (count _database > TIME_INDEX) then
	{
		private _dateTime = _database select TIME_INDEX;
	};
	diag_log format["loaded %1 date/time", _dateTime];
	format["%1", _dateTime] remoteExec ["fnc_logisticDb_SetDateTime"]; // Überall ausführen
	setTimeMultiplier 2;
	
	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	"LOGISTIC-Database loading complete" remoteExec ["hint"];

	// ------------------------------------------------------------------------------
	// Nachbereiten
	logisticDbSaving = false;
};