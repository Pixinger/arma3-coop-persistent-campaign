if (isServer) then
{
	diag_log format["fnc_dacZones_OnTriggerActivated: _this = %1 (zoneNameInices)", _this];

	private["_zoneRow"];
	_zoneRow = (_this select 0) - 1;
	private["_zoneLine"];
	_zoneLine = (_this select 1) - 1;

	private["_links"];
	_links = (sectorLinks select _zoneLine) select _zoneRow;

	{
		private["_linkRow"];
		_linkRow = (_x select 0) - 1;
		private["_linkLine"];
		_linkLine = (_x select 1) - 1;
		
		private["_sectorStatusLine"];
		_sectorStatusLine = sectorStatus select _linkLine;
			
		// Referenzzähler erhöhen
		_sectorStatusLine set [_linkRow, (_sectorStatusLine select _linkRow) +1];

		// Referenz auf Aktivierung prüfen
		if ((_sectorStatusLine select _linkRow) == 1) then
		{
			[_linkRow, _linkLine, 1] call fnc_dacZones_MessageQueuePush;
		};
	} foreach _links;
};