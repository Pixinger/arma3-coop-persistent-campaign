#include "..\..\debug.hpp"
//DEBUG_LOG_FILE
//DEBUG_LOG_THIS

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
			ERROR_LOG_VAREX("No townData for townIndex ", _i);
		};
	};	
	
	// ------------------------------------------------------------------------------
	// Debug Ausgabe
	INFO_LOG "TOWN-Database: ----------------------";
	{
		INFO_LOG("TOWN:");
		INFO_LOG_VAR(_foreachIndex);
		INFO_LOG_VAR(_x);
	} foreach _database;
	INFO_LOG "TOWN-Database: ----------------------";
	
	// ------------------------------------------------------------------------------
	// Datenbank speichern
	profileNameSpace setVariable [townDbPrefix + "_database", _database];
	DEBUG_LOG_VAREX("TOWN-Database saved: ", _database);

	// ------------------------------------------------------------------------------
	// Bestätigung ausgeben
	"TOWN-Database saving completed!" remoteExec ["hint"];	

	// ------------------------------------------------------------------------------
	// Nachbereiten
	townDatabaseSaving = false;
};
