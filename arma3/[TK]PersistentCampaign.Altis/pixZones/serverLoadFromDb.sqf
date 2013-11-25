waitUntil { !pixZonesDbMutex };
pixZonesDbMutex = true;

private["_result"];
_result = [] call fn_pixZones_DbBeginLoad;
if (_result == "OK") then
{
	_result = call fn_pixZones_DbIsThreadFinished;
	while { _result == "INPROGRESS" } do {	Sleep 0.5; _result = call fn_pixZones_DbIsThreadFinished; };
	if (_result == "OK") then
	{	
		_result = [] call fn_pixZones_DbReadNext;
		if (_result != "EOF") then
		{
			/* Das ist der Normalfall */
			pvehPixZones_ZoneStatus = call compile _result;
			
			/* Nun die Datei noch sauber schließen */
			_result = [] call fn_pixZones_DbReadNext; /* Eigentlich sollte direkt schluss sein */
			while  { _result != "EOF" } do
			{
				/* Sollte fälschlicherweise mehr als nur eine Zeile in der Datei vorhanden sein, lesen  wir bis zum Ende */
				diag_log "WARNING: pixZones Db-File contains to many lines. only one line is allowed.";
				player sideChat "WARNING: pixZones Db-File contains to many lines. only one line is allowed.";	
				_result = [] call fn_pixZones_DbReadNext; /* Eigentlich sollte direkt schluss sein */
			};			
		}
		else
		{
			/* Die Datei scheint leer zu sein => Standard verwenden... */
			diag_log "WARNING: fn_pixZones_DbReadNext returned no pvehPixZones_ZoneStatus array. using default data instead.";
			player sidechat "WARNING: fn_pixZones_DbReadNext returned no pvehPixZones_ZoneStatus array. using default data instead.";
			
			/* Staus ID's:
			0 = Sperrzone
			1 = Aktivierte/Angegriffene Zone
			2 = Freundliche Zone 
			*/
			pvehPixZones_ZoneStatus = [];
			pvehPixZones_ZoneStatus set [0, 2]; 
			private["_i"];
			for "_i" from 1 to (pixZones_ZoneCount - 1) do { pvehPixZones_ZoneStatus set [_i, 0];	};
		};

		/*------------------------------------------*/
		/* Gelesene Daten soweit möglich überprüfen */
		/*------------------------------------------*/
		while {count pvehPixZones_ZoneStatus < pixZones_ZoneCount} do
		{		
			diag_log "WARNING: ((count pvehPixZones_ZoneStatus) < pixZones_ZoneCount). Element will be added.";
			player sideChat "WARNING: ((count pvehPixZones_ZoneStatus) < pixZones_ZoneCount). Element will be added.";
			pvehPixZones_ZoneStatus = pvehPixZones_ZoneStatus + [0];
		};
		if (count pvehPixZones_ZoneStatus > pixZones_ZoneCount) then 
		{
			diag_log "WARNING: ((count pvehPixZones_ZoneStatus) > pixZones_ZoneCount). Elements will be removed.";
			player sideChat "WARNING: ((count pvehPixZones_ZoneStatus) > pixZones_ZoneCount). Elements will be removed.";
			pvehPixZones_ZoneStatus resize pixZones_ZoneCount;
		};
		private["_o"];
		for "_o" from 0 to (pixZones_ZoneCount - 1) do 
		{
			if (typeName (pvehPixZones_ZoneStatus select _o) != "SCALAR") then { pvehPixZones_ZoneStatus set [_o, 0];};
			if ((pvehPixZones_ZoneStatus select _o) < 0) then { pvehPixZones_ZoneStatus set [_o, 0];};
			if ((pvehPixZones_ZoneStatus select _o) == 1) then { pvehPixZones_ZoneStatus set [_o, 0];}; /* Angegriffene Zonen zurücksetzen*/
			if ((pvehPixZones_ZoneStatus select _o) > 2) then { pvehPixZones_ZoneStatus set [_o, 2];};
		};
		
		/*---------------------------------------------------------------------*/
		/* Nun sollte alles stimmen und die Daten können veröffentlicht werden */
		/*---------------------------------------------------------------------*/
		publicVariable "pvehPixZones_ZoneStatus";	
		if (!isDedicated) then	{ call compile preprocessFileLineNumbers "pixZones\pvehPixZones_ZoneStatus.sqf"; }; /* PublicVariableEventHandler simulieren */
	}
	else
	{
		diag_log format["ERROR: fn_pixZones_DbBeginLoad=>fn_pixZones_DbIsThreadFinished failed: %1", _result];
		player sidechat format["ERROR: fn_pixZones_DbBeginLoad=>fn_pixZones_DbIsThreadFinished failed: %1", _result];
	};
}
else
{
	diag_log format["ERROR: fn_pixZones_DbBeginLoad failed: %1", _result];
	player sidechat format["ERROR: fn_pixZones_DbBeginLoad failed: %1", _result];
};
 
player sidechat "INFO: pixZones: Loading successfull";
pixZonesDbMutex = false;