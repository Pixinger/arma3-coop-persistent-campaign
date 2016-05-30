if (isServer) then
{	
	waitUntil { townInitCompleted };
	waitUntil { !townDatabaseSaving };
	townDatabaseSaving = true;

	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	"TOWN-Database saving..." remoteExec ["hint"];	

	// ------------------------------------------------------------------------------
	// Durch alle Zonen interieren
	private _database = [];
	for "_i" from 0 to townTownCount-1 do 
	{
		
		if (count townInfos > 0) then
		{
			(townInfos select _i) params ["_supplies", "_civilianCount", "_houseCount"];

			private _dataSet = [_supplies, _civilianCount];
			_database pushBack _dataSet; // DataSet für Town "_i".
		}
		else
		{ 
			_database pushBack [];
			[format["No townData for townIndex %1 found.", _i]] call BIS_fnc_error; 
		};
	};	
	
	// ------------------------------------------------------------------------------
	// Debug Ausgabe
	diag_log "TOWN-Database: ----------------------";
	{
		diag_log format["TOWN-Database-Save: Town %1 = %2", _foreachIndex, _x];
	} foreach _database;
	diag_log "TOWN-Database: ----------------------";
	
	// ------------------------------------------------------------------------------
	// Datenbank speichern
	profileNameSpace setVariable [townDbPrefix + "_database", _database];
	diag_log format["TOWN-Database saved: %1", _database];	

	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	"TOWN-Database saving completed!" remoteExec ["hint"];	

	// ------------------------------------------------------------------------------
	// Nachbereiten
	townDatabaseSaving = false;
};
