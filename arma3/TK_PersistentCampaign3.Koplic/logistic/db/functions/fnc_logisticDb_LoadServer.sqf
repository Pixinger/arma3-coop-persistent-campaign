#include "..\..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

#include "_databaseIndexes.hpp"

if (isServer) then
{
	// ------------------------------------------------------------------------------
	// Vorbereiten
	waitUntil { !logisticDbSaving };
	logisticDbSaving = true;
	"LOGISTIC-Database loading" remoteExec ["hint"];
	DEBUG_LOG("LOGISTIC-Database: ------------------------ (begin)");
	DEBUG_LOG("LOGISTIC-Database: loading");
	
	// Datenbank aus dem VAR-Bereich lesen
	//private _database = [];
	private _database = profileNameSpace getVariable [(logisticDbPrefix + "_database"), []];

	//------------------------------------
	// Fahrzeuge aus der Datenbank laden und erstellen
	//------------------------------------
	if (count _database > VEHICLE_INDEX) then
	{
		private _vehicles = _database select VEHICLE_INDEX;
		DEBUG_LOG_VAREX_INFO("loaded vehicles: ", (count _vehicles));

		{	
			if (getText(configFile >> "cfgVehicles" >> (_x select 0) >> "vehicleClass") != "") then // Prüfen ob der Classname im Addon enthalten ist
			{
				// _x = [_classname, _position, _direction, _damageArray, _cargoArray, dbVar(optional)];	
				// Fahrzeug erstellen
				//private _vehicle = [(_x select 0), (_x select 1), (_x select 2)] call fnc_logisticDb_CreateVehicleCorrected;
				private _vehicle = [(_x select 0), (_x select 1), 0] call fnc_logisticDb_CreateVehicleCorrected;
				// Schaden hinzufügen
				[_vehicle, (_x select 3)] call  fnc_logisticDb_SetVehicleDamageArray;
				// Ladung hinzufügen
				[_vehicle, (_x select 4)] call  fnc_logisticDb_SetVehicleCargoArray;
				// dbVar
				if (count _x > 5) then 
				{
					_vehicle setVariable["dbVar", (_x select 5), true]; 
				};
			};
		} foreach _vehicles; 
	};

	//------------------------------------
	// Ammoboxen aus der Datenbank laden und erstellen
	//------------------------------------
	if (count _database > AMMOBOX_INDEX) then
	{
		private _ammoboxes = _database select AMMOBOX_INDEX;
		DEBUG_LOG_VAREX_INFO("loaded ammoboxes: ", (count _ammoboxes));

		{	
			if (getText(configFile >> "cfgVehicles" >> (_x select 0) >> "vehicleClass") != "") then // Prüfen ob der Classname im Addon enthalten ist
			{
				// _x = [_classname, _position, _direction, _damageArray, _cargoArray, dbVar(optional)];	
				// Fahrzeug erstellen
				private _vehicle = [(_x select 0), (_x select 1), (_x select 2)] call fnc_logisticDb_CreateVehicleCorrected;
				// Schaden hinzufügen
				_vehicle setDamage (_x select 3);
				// Ladung hinzufügen
				[_vehicle, (_x select 4)] call  fnc_logisticDb_SetVehicleCargoArray;
				// dbVar
				if (count _x > 5) then 
				{
					_vehicle setVariable["dbVar", (_x select 5), true]; 
				};
			};
		} foreach _ammoboxes; 
	};

	//------------------------------------
	// Objekte aus der Datenbank laden und erstellen
	//------------------------------------
	if (count _database > OBJECT_INDEX) then
	{
		private _objects = _database select OBJECT_INDEX;
		DEBUG_LOG_VAREX_INFO("loaded objects: ", (count _objects));

		{	
			if (getText(configFile >> "cfgVehicles" >> (_x select 0) >> "vehicleClass") != "") then // Prüfen ob der Classname im Addon enthalten ist
			{
				// _x = [_classname, _position, _direction, _damageArray, dbVar(optional)];	//ACHTUNG! Kein CargoArray wie bei 'ammoboxes' und 'vehicles'
				// Fahrzeug erstellen
				private _vehicle = [(_x select 0), (_x select 1), (_x select 2)] call fnc_logisticDb_CreateVehicleCorrected;
				// Schaden hinzufügen
				_vehicle setDamage (_x select 3);
				// dbVar
				if (count _x > 4) then 
				{
					_vehicle setVariable["dbVar", (_x select 4), true]; 
				};
				
				if (_x select 0 == "B_Slingload_01_Repair_F") then 
				{
					_vehicle setVariable ["ACE_isRepairFacility", 1, true];
				};
			};
		} foreach _objects; 
	};

	//------------------------------------
	// TIME/DATE aus der Datenbank laden 
	//------------------------------------
	private _dateTime = [2016, 06, 11, 15, 00]; // [year, month, day, hour, minute] 
	if (count _database > TIME_INDEX) then
	{
		_dateTime = _database select TIME_INDEX;
	};
	DEBUG_LOG_VAREX_INFO("loaded date: ", _dateTime);
	DEBUG_LOG("LOGISTIC-Database: ------------------------ (end)");
	format["%1", _dateTime] remoteExec ["fnc_logisticDb_SetDateTime"]; // Überall ausführen
	setTimeMultiplier 2;	

	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	"LOGISTIC-Database loading complete" remoteExec ["hint"];

	// ------------------------------------------------------------------------------
	// Nachbereiten
	logisticDbSaving = false;
};