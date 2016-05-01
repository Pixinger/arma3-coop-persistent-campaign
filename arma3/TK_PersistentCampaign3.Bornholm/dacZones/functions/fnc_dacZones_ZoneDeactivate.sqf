diag_log format["fnc_dacZones_ZoneDeactivate: _this = %1", _this];
private["_zoneId"];
if (count _this == 1) then
{
	_zoneId = _this select 0;
}
else
{
	private["_zoneRow"];
	_zoneRow = (_this select 0);
	private["_zoneLine"];
	_zoneLine = (_this select 1);
	_zoneId = [_zoneRow, _zoneLine] call fnc_dacZones_GetZoneIdFromXy;
};

waituntil{DAC_NewZone == 0};
diag_log format["DEBUG: Delete Zone: %1", _zoneId];
[format["dacZone%1", _zoneId]] call DAC_fDeleteZone;
waituntil{DAC_NewZone == 0};