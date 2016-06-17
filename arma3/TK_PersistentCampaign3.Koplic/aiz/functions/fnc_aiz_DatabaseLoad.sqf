#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

// ------------------------------------------------------------------------------
// Aus der Datenbank laden
private "_database";
_database = profileNameSpace getVariable [(cfgAizDbPrefix + "_database"), []];

DEBUG_LOG("AIZ-Database: ------------------------ (begin)");
DEBUG_LOG("AIZ-Database: loading");
DEBUG_LOG_VAR(_database);
DEBUG_LOG("AIZ-Database: ------------------------ (end)");

// ------------------------------------------------------------------------------
// Result
_database;
