diag_log format["deactive: _this = %1", _this];

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
		
	// Referenzzähler verringern
	_sectorStatusZeile set [_linkSpalte, (_sectorStatusZeile select _linkSpalte) - 1];

	// Referenz auf Deaktivierung prüfen
	if ((_sectorStatusZeile select _linkSpalte) <= 0) then
	{
		_code = format["tmp = [zx%1y%2] call DAC_Deactivate;", _linkSpalte, _linkZeile];
		diag_log _code;
		[] call compile _code;
		_sectorStatusZeile set [_linkSpalte, 0]; // Zur Sicherheit...
	};
} foreach _links;