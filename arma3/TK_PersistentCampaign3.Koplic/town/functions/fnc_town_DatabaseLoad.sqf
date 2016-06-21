#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

// ------------------------------------------------------------------------------
// Aus der Datenbank laden
private "_database";
_database = profileNameSpace getVariable [(townDbPrefix + "_database"), []];
DEBUG_LOG_VAREX("TOWN-Database loaded: ", _database);
//private _database = [];	

// ------------------------------------------------------------------------------
// Debug Ausgabe
INFO_LOG("TOWN-Database: ----------------------");
{
	INFO_LOG("TOWN:");
	INFO_LOG_VAR(_foreachIndex);
	INFO_LOG_VAR(_x);
} foreach _database;
INFO_LOG("TOWN-Database: ----------------------");

// ------------------------------------------------------------------------------
// Result
_database;