if (isServer) then
{
	diag_log format["fnc_dacZones_OnTriggerDeactivated: _this = %1", _this];

	_this spawn {
		Sleep 3; // Das Deaktivieren verzögern, damit die Aktivierungstrigger auch SICHER vorher durchgelaufen sind.
		private["_zoneRow"];
		_zoneRow = (_this select 0) -1;
		private["_zoneLine"];
		_zoneLine = (_this select 1) -1;

		private["_links"];
		_links = (sectorLinks select _zoneLine) select _zoneRow;

		{
			private["_linkRow"];
			_linkRow = (_x select 0) -1;
			private["_linkLine"];
			_linkLine = (_x select 1) -1;
			
			private["_sectorStatusLine"];
			_sectorStatusLine = sectorStatus select _linkLine;
				
			// Referenzzähler verringern
			_sectorStatusLine set [_linkRow, (_sectorStatusLine select _linkRow) -1];

			// Referenz auf Deaktivierung prüfen
			if ((_sectorStatusLine select _linkRow) <= 0) then
			{
				[_linkRow, _linkLine, 0] call fnc_dacZones_MessageQueuePush;
				//_sectorStatusLine set [_linkRow, 0]; // Zur Sicherheit...
			};
		} foreach _links;
	};
};