//------------------------------------
// Datenbank erstellen
//------------------------------------
private["_database"];
_database = [[], [], []];
diag_log ["Cleared database";
profileNameSpace setVariable [dbProfilenamespacePrefix + "_database", _database];
