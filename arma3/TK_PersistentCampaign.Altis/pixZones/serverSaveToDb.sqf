if (isServer) then
{
	waitUntil { !pixZonesDbMutex };
	pixZonesDbMutex = true;

	/*-----------------------*/
	/* Die Datei vorbereiten */
	/*-----------------------*/
	private["_result"];
	_result = [] call fn_pixZones_DbBeginSave;
	if (_result == "OK") then
	{
		/*--------------------------------------*/
		/* Status-Array als String wegschreiben */
		/*--------------------------------------*/
		_result = [format["%1", pvehPixZones_ZoneStatus]] call fn_pixZones_DbWriteNext;
		if (_result != "OK") then
		{
			diag_log format["ERROR: fn_pixZones_DbWriteNext failed: %1", _result];
			player globalChat format["ERROR: fn_pixZones_DbWriteNext failed: %1", _result];
		};		

		/*----------------------------------------------------*/
		/* Die Datei letzendlich auf die Festplatte schreiben */
		/*----------------------------------------------------*/
		_result = [] call fn_pixZones_DbEndSave;
		if (_result == "OK") then
		{
			_result = call fn_pixZones_DbIsThreadFinished;
			while { _result == "INPROGRESS" } do {	Sleep 0.5; _result = call fn_pixZones_DbIsThreadFinished; };
			if (_result == "OK") then
			{	
				diag_log "INFO: pixZones: Db saved";
				player globalChat "INFO: pixZones: Db saved";
			}
			else
			{
				diag_log format["ERROR: fn_pixZones_DbEndSave=>fn_pixZones_DbIsThreadFinished failed: %1", _result];
				player globalChat format["ERROR: fn_pixZones_DbEndSave=>fn_pixZones_DbIsThreadFinished failed: %1", _result];
			};
		}
		else
		{
			diag_log format["ERROR: fn_pixZones_DbEndSave failed: %1", _result];
			player globalChat format["ERROR: fn_pixZones_DbEndSave failed: %1", _result];
		};
	}
	else
	{
		diag_log format["ERROR: fn_pixZones_DbBeginSave failed: %1", _result];
		player globalChat format["ERROR: fn_pixZones_DbBeginSave failed: %1", _result];
	};

	pixZonesDbMutex = false;
};