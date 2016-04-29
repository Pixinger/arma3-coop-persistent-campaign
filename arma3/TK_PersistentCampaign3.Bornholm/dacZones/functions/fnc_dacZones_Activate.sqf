if (isServer) then
{
	diag_log format["fnc_dacZones_Activate: _this = %1", _this];

	private["_spalte"];
	_spalte = (_this select 0) - 1;
	private["_zeile"];
	_zeile = (_this select 1) - 1;

	private["_links"];
	_links = (sectorLinks select _zeile) select _spalte;

	{
		private["_linkSpalte"];
		_linkSpalte = _x select 0;
		private["_linkZeile"];
		_linkZeile = _x select 1;
		
		private["_sectorStatusZeile"];
		_sectorStatusZeile = sectorStatus select _linkZeile;
			
		// Referenzzähler erhöhen
		_sectorStatusZeile set [_linkSpalte, (_sectorStatusZeile select _linkSpalte) + 1];

		// Referenz auf Aktivierung prüfen
		if ((_sectorStatusZeile select _linkSpalte) == 1) then
		{
			[_linkSpalte, _linkZeile] call fnc_dacZones_GetCampData;
			[_linkSpalte, _linkZeile] call fnc_dacZones_GetZoneData;
			diag_log format["ZoneData: %1", _r];

			[] call compile format["tmp = [zx%1y%2] call DAC_Activate;", _linkSpalte, _linkZeile];
		};
	} foreach _links;
};