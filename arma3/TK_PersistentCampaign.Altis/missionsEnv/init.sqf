/*-----------------------------------------------------------------*/
/* Sicherstellen, dass die "pixZones" bereits initialisiert wurden */
/*-----------------------------------------------------------------*/
if (isNil "pixZones_Initialized") then
{
	player globalChat "ERROR: pixZones wurden noch nicht initialisiert.";
};

/*---------------------*/
/* Konfiguration laden */
/*---------------------*/
call compile preprocessFileLineNumbers "missionsEnv\config.sqf";
	
/*---------------------------------------------*/
/* Alle existierenden Missionen initialisieren */
/*---------------------------------------------*/
/*{ call compile preprocessFileLineNumbers format["missionsEnv\%1\init.sqf", _x select 0]; } foreach missionsEnv_Missions;*/