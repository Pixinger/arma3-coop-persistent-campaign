// ------------------------------------------------------------------------------
// Aus der Datenbank laden
private "_database";
_database = profileNameSpace getVariable [(townDbPrefix + "_database"), []];
diag_log format["TOWN-Database loaded: %1", _database];	
//private _database = [];	

// ------------------------------------------------------------------------------
// Debug Ausgabe
diag_log "TOWN-Database: ----------------------";
{
	diag_log format["TOWN-Database-Load: Town %1 = %2", _foreachIndex, _x];
} foreach _database;
diag_log "TOWN-Database: ----------------------";

// ------------------------------------------------------------------------------
// Result
_database;
