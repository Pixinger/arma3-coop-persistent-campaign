// ------------------------------------------------------------------------------
// Aus der Datenbank laden
private "_database";
_database = profileNameSpace getVariable [(aizDbPrefix + "_database"), []];
diag_log format["AIZ-Database loaded: %1", _database];	
//private _database = [];	

// ------------------------------------------------------------------------------
// Debug Ausgabe
diag_log "aizDatabase: ----------------------";
{
	diag_log format["aizDatabase-Load: Zone %1 = %2", _foreachIndex, _x];
} foreach _database;
diag_log "aizDatabase: ----------------------";

// ------------------------------------------------------------------------------
// Result
_database;
