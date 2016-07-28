#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

if (isServer) then
{	
	waitUntil { aizZoneInitCompleted };
	waitUntil { !aizZonesSaving };
	aizZonesSaving = true;

	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	"AIZ-Database saving..." remoteExec ["hint"];	

	// ------------------------------------------------------------------------------
	// Durch alle Zonen interieren
	private _database = [];
	for "_i" from 0 to (cfgAizZoneCount-1) do
	{
		if (!isNil format["aizZoneData%1", _i]) then
		{
			private "_zoneData";
			call compile format["_zoneData = aizZoneData%1;", _i];			
			_zoneData params ["_campsTown", "_campsField", "_checkpoints", "_waypointPool", "_groupCount","_intelCount"];			
			if (_groupCount < 0) then { _groupCount = 0; };
			if (_intelCount < 0) then { _intelCount = 0; };

			// ------------------------------------------------------------------------------
			private _dataSetCampsTown = [];
			{			
				private _campCount = [(_x select 0) buildingPos (_x select 1), 5] call fnc_aiz_FindCampTownRespawnCount;
				if (_campCount > 0) then 
				{ 
					_dataSetCampsTown pushBack [getPos (_x select 0), (_x select 1)]; //=[_housePosition, buildingPosIndex]
				};
			} foreach _campsTown; //_x=[_houseObjekt, buildingPosIndex]

			// ------------------------------------------------------------------------------
			private _dataSetCampsField = [];
			{
				private _tentCount = [_x select 0, cfgAizCampFieldRadius] call fnc_aiz_FindCampFieldRespawnCount;
				if (_tentCount > 0) then 
				{ 
					_dataSetCampsField pushBack [_x select 0, _tentCount]; 
				};
			} foreach _campsField; //_x=[position, respawnCount];

			// ------------------------------------------------------------------------------
			private _dataSetCheckpoints = [];
			{
				if ((count (_x select 0)) == 3) then // Wenn ein Checkpoint zerstört wird, dann ist die position=[] anstatt z.B. position=[10,20,0];
				{ 
					_dataSetCheckpoints pushBack _x;
				};
			} foreach _checkpoints; //_x=[position, direction];

			// ------------------------------------------------------------------------------
			// DataSet für Zone "_i".
			_database pushBack [_dataSetCampsTown, _dataSetCampsField, _dataSetCheckpoints, _groupCount, _intelCount]; 
		}
		else
		{ 
			_database pushBack [];
			[format["No zoneData for zoneIndex %1 found.", _i]] call BIS_fnc_error; 
		};
	};	
	
	// ------------------------------------------------------------------------------
	// Debug Ausgabe
	diag_log "AIZ-Database: ------------------------ (begin)";
	diag_log "AIZ-Database: saving";
	{
		diag_log format["zoneIndex=%1 dataset=%2", _foreachIndex, _x];
		diag_log format["zoneIndex=%1 _dataSetCampsTown=%2", _foreachIndex, _x select 0];
		diag_log format["zoneIndex=%1 _dataSetCampsField=%2", _foreachIndex, _x select 1];
		diag_log format["zoneIndex=%1 _dataSetCheckpoints=%2", _foreachIndex, _x select 2];
		diag_log format["zoneIndex=%1 _groupCount=%2", _foreachIndex, _x select 3];
		diag_log format["zoneIndex=%1 _intelCount=%2", _foreachIndex, _x select 4];
	} foreach _database;
	diag_log "AIZ-Database: ------------------------ (end)";
	
	// ------------------------------------------------------------------------------
	// Datenbank speichern
	profileNameSpace setVariable [cfgAizDbPrefix + "_database", _database];

	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	"AIZ-Database saving completed!" remoteExec ["hint"];	

	// ------------------------------------------------------------------------------
	// Nachbereiten
	aizZonesSaving = false;
};
