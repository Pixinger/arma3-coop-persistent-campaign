/* Die Farben der Zonen aktualisieren */
if (isServer) then
{
	if (pvehPixZones_SaveDatabase) then
	{
		pvehPixZones_SaveDatabase = false;
		publicVariable "pvehPixZones_SaveDatabase";

		[] call compile preprocessFileLineNumbers "pixZones\serverSaveToDb.sqf";
	};
};
