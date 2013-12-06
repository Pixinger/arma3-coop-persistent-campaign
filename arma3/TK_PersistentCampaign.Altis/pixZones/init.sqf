/* ---------------------------------- */
/* Configuration laden und überprüfen */
/* ---------------------------------- */
call compile preprocessFileLineNumbers "pixZones\config.sqf";
if (count pixZones_ZoneConnectionsBlueFor != pixZones_ZoneCount) then { player globalChat "ERROR: (count pixZones_ZoneConnectionsBlueFor != pixZones_ZoneCount)";};
if (count pixZones_ZoneConnectionsOpFor != pixZones_ZoneCount) then { player globalChat "ERROR: (count pixZones_ZoneConnectionsOpFor != pixZones_ZoneCount)";};

/* -------------------------------- */
/* Spezielle Funktionen kompilieren */
/* -------------------------------- */
fn_pixZones_IsZoneForbidden = compile preprocessFileLineNumbers "pixZones\fn_pixZones_IsZoneForbidden.sqf";
fn_pixZones_CanBlueforEngageZone = compile preprocessFileLineNumbers "pixZones\fn_pixZones_CanBlueforEngageZone.sqf";
fn_pixZones_GetConnectedHostileZones = compile preprocessFileLineNumbers "pixZones\fn_pixZones_GetConnectedHostileZones.sqf";
fn_pixZones_AllMissionsFinished = compile preprocessFileLineNumbers "pixZones\fn_pixZones_AllMissionsFinished.sqf";
fn_pixZones_AllMissionsSuccessfull = compile preprocessFileLineNumbers "pixZones\fn_pixZones_AllMissionsSuccessfull.sqf";
fn_pixZones_UpdateMarkerColor = compile preprocessFileLineNumbers "pixZones\fn_pixZones_UpdateMarkerColor.sqf";

/* ---------------------------------------------------- */
/* Noch fehlende globale Variablen automatisch erzeugen */
/* ---------------------------------------------------- */
pixZones_ActiveIndex = -1;
pixZones_MarkerNames = []; 		/* ["Zone0", "Zone1", "Zone2", ..] */
pixZones_ZoneCoordinates = []; 	/* Koordinaten des jeweiligen Markers [[Left1, Top1, Right1, Bottom1], ..] */
pixZones_ReverseAttackTime = pixParamReverseAttack;
if (pixDebug) then { player globalChat format["pixZones_ReverseAttackTime: %1", pixZones_ReverseAttackTime];};

if (isNil "pvehPixZones_OnRequestActivation") then { pvehPixZones_OnRequestActivation = -1;};
if (isNil "pvehPixZones_MissionInfos") then { pvehPixZones_MissionInfos = [];};
if (isNil "pvehPixZones_MissionStatus") then { pvehPixZones_MissionStatus = [];};
if (isNil "pvehPixZones_ZoneStatus") then { pvehPixZones_ZoneStatus = [];};

for "_i" from 0  to (pixZones_ZoneCount - 1) do
{
	private["_name"];
	_name = format["Zone%1", _i];
	if (str(getMarkerPos _name) == "[0,0,0]") then { player globalChat format["ERROR: Marker '%1' not found.", _name];	};
	
	private["_pos"];
	private["_size"];
	_pos = getMarkerPos _name;
	_size = getMarkerSize _name;
	pixZones_MarkerNames = pixZones_MarkerNames + [_name];
	pixZones_ZoneCoordinates = pixZones_ZoneCoordinates + [[(_pos select 0) - (_size select 0), (_pos select 1) - (_size select 1), (_pos select 0) + (_size select 0), (_pos select 1) + (_size select 1)]]; 
};

/* -------------------------------------------------------------------------- */
/* EventHandler, wenn ein Client beim Server den Start einer Zone beauftragt. */
/* Dieser EventHandler wird nur auf dem Server empfangen.*/
/* -------------------------------------------------------------------------- */
"pvehPixZones_OnRequestActivation" addPublicVariableEventHandler 
{
	call compile preprocessFileLineNumbers "pixZones\pvehPixZones_OnRequestActivation.sqf";
};
/*------------------------------------------------------------------------------------------------------------*/
/* EventHandler, wenn eine Mission gestartet wurde */
/* Der Server selbst startet die Mission. Der Client fragt vorher über "pvehPixZones_OnRequestActivation" an. */
/*------------------------------------------------------------------------------------------------------------*/
"pvehPixZones_MissionInfos" addPublicVariableEventHandler 
{
	call compile preprocessFileLineNumbers "pixZones\pvehPixZones_MissionInfos.sqf";
};
/*-------------------------------------------------------------------------------------------------*/
/* EventHandler, wenn sich der Status einer Mission ändert */
/* Hier wird momentan nur eine Anzeige vorgenommen. Dies Skripte selbst pollen den Missionsstatus. */
/*-------------------------------------------------------------------------------------------------*/
"pvehPixZones_MissionStatus" addPublicVariableEventHandler 
{
	call compile preprocessFileLineNumbers "pixZones\pvehPixZones_MissionStatus.sqf";
};

/*------------------------------------------------------------------------------------------------------------*/
/* EventHandler, wenn sich der Status eines Sektors ändert.
/*------------------------------------------------------------------------------------------------------------*/
"pvehPixZones_ZoneStatus" addPublicVariableEventHandler 
{
	call compile preprocessFileLineNumbers "pixZones\pvehPixZones_ZoneStatus.sqf";
};


/* ------------------------- */
/* Server, oder Serverclient */
/* ------------------------- */
if (isServer) then
{
	/* --------------------------------------- */
	/* Spezielle Server-Funktionen kompilieren */
	/* --------------------------------------- */
	fn_pixZones_DbBeginLoad = compile preprocessFileLineNumbers "pixZones\fn_pixZones_DbBeginLoad.sqf";
	fn_pixZones_DbBeginSave = compile preprocessFileLineNumbers "pixZones\fn_pixZones_DbBeginSave.sqf";
	fn_pixZones_DbEndSave = compile preprocessFileLineNumbers "pixZones\fn_pixZones_DbEndSave.sqf";
	fn_pixZones_DbWriteNext = compile preprocessFileLineNumbers "pixZones\fn_pixZones_DbWriteNext.sqf";
	fn_pixZones_DbReadNext = compile preprocessFileLineNumbers "pixZones\fn_pixZones_DbReadNext.sqf";
	fn_pixZones_DbIsThreadFinished = compile preprocessFileLineNumbers "pixZones\fn_pixZones_DbIsThreadFinished.sqf";
	fn_pixZones_DbVersion = compile preprocessFileLineNumbers "pixZones\fn_pixZones_DbVersion.sqf";
	fn_pixZones_DbCleanup = compile preprocessFileLineNumbers "pixZones\fn_pixZones_DbCleanup.sqf";

	diag_log format["pixZones: %1", call fn_pixZones_DbVersion];
	if (pixDebug) then { player globalChat format["INFO: pixZones: %1", call fn_pixZones_DbVersion];};

	/* ------------------------ */
	/* Variablen Initialisieren */
	/* ------------------------ */
	pixZonesDbMutex = false;

	/* -------------------------------------------------------------- */
	/* Zur Sicherheit einmal aufräumen (evtl. vorherige Skriptfehler) */
	/* -------------------------------------------------------------- */
	if (call fn_pixZones_DbCleanup != "OK") then
	{
		diag_log format["ERROR: fn_pixZones_DbCleanup failed: %1", _result];
		player globalChat format["ERROR: fn_pixZones_DbCleanup failed: %1", _result];
	};

	/*------------------------------------------------*/
	/* pvehPixZones_ZoneStatus von der Datenbank laden. */
	/*------------------------------------------------*/
	[] call compile preprocessFileLineNumbers "pixZones\serverLoadFromDb.sqf";
};

/* ------------------------- */
/* Client, oder Serverclient */
/* ------------------------- */
if (!isServer || !isDedicated) then
{
	/* Zonenüberwachung für den Spieler starten */
	private["_tmp"];
	_tmp = [] execVM "pixZones\observePlayer.sqf";
	
	/* Die Farben der Zonen aktualisieren */
	if (!isServer || !isDedicated) then	{ call fn_pixZones_UpdateMarkerColor; };	
	
	/* Sollte bereits eine Zone aktiv sein, dann diese nachstarten */
	if (str(pvehPixZones_MissionInfos) != "[]") then
	{
		private["_tmp"];
		_tmp = [] execVM "pixZones\zoneRun.sqf"; /* liest aus "pvehPixZones_MissionInfos" aus */
	};
};

/* -------------------------- */
/* Bereitschaft signalisieren */
/* -------------------------- */
pixZones_Initialized = true;
