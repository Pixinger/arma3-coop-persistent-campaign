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
	for "_i" from 0 to aizZoneCount do 
	{
		if (!isNil format["aizZoneData%1", _i]) then
		{
			private "_zoneData";
			call compile format["_zoneData = aizZoneData%1;", _i];			
			_zoneData params ["_campsTown", "_campsField", "_checkpoints", "_waypointPool", "_groupCount"];			
			if (_groupCount < 0) then { _groupCount = 0; };

			// ------------------------------------------------------------------------------
			private _dataSetCampsTown = [];
			{			
				if (count ([(_x select 0) buildingPos (_x select 1), 5] call fnc_aiz_FindCampTownRespawnCount) > 0) then 
				{ 
					_dataSetCampsTown pushBack [getPos (_x select 0), (_x select 1)]; //=[_housePosition, buildingPosIndex]
				};
			} foreach _campsTown; //_x=[_houseObjekt, buildingPosIndex]

			// ------------------------------------------------------------------------------
			private _dataSetCampsField = [];
			{
				private _tentCount = [_x select 0, aizCampFieldRadius] call fnc_aiz_FindCampFieldRespawnCount;
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
			private _dataSet = [
				_dataSetCampsTown,
				_dataSetCampsField,
				_dataSetCheckpoints,
				_groupCount
				];
			_database pushBack _dataSet; // DataSet für Zone "_i".
		}
		else
		{ 
			_database pushBack [];
			[format["No zoneData for zoneIndex %1 found.", _i]] call BIS_fnc_error; 
		};
	};	
	
	// ------------------------------------------------------------------------------
	// Debug Ausgabe
	diag_log "aizDatabase: ----------------------";
	{
		diag_log format["aizDatabase-Save: Zone %1 = %2", _foreachIndex, _x];
	} foreach _database;
	diag_log "aizDatabase: ----------------------";
	
	// ------------------------------------------------------------------------------
	// Datenbank speichern
	profileNameSpace setVariable [aizDbPrefix + "_database", _database];
	diag_log format["AIZ-Database saved: %1", _database];	

	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	"AIZ-Database saving completed!" remoteExec ["hint"];	

	// ------------------------------------------------------------------------------
	// Nachbereiten
	aizZonesSaving = false;
};
