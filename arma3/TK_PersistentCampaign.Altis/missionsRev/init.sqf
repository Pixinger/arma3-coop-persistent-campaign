/*-----------------------------------------------------------------*/
/* Sicherstellen, dass die "pixZones" bereits initialisiert wurden */
/*-----------------------------------------------------------------*/
/*if (isNil "pixZones_Initialized") then
{
	player globalChat "ERROR: pixZones wurden noch nicht initialisiert.";
};*/

/*---------------------*/
/* Konfiguration laden */
/*---------------------*/
call compile preprocessFileLineNumbers "missionsRev\config.sqf";