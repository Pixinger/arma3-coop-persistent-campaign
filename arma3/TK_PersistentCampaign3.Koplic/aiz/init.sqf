#include "..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

//[5] call fnc_aiz_ZoneInit;

if (isServer) then
{
	// ------------------------------------------------------------------------------
	// Datenbank laden
	private _database = [] call fnc_aiz_DatabaseLoad;
	
	// ------------------------------------------------------------------------------
	// Zonen initialisieren
	for "_i" from 0 to cfgAizZoneCount-1 do 
	{
		aizZoneActive pushBack 0;
		private _dataSet = if (count _database > _i) then { _database select _i } else { [] };
		[_i, _dataSet] call fnc_aiz_ZoneInit;
	};

	// ------------------------------------------------------------------------------
	// Beendigung signalisieren
	aizZoneInitCompleted = true;
	DEBUG_LOG_INFO("AIZ init is now completed");
};
