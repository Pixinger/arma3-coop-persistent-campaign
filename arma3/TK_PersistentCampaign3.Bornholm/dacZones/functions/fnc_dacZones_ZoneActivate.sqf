diag_log format["fnc_dacZones_ZoneActivate: _this = %1", _this];
private["_zoneRow"];
private["_zoneLine"];
private["_zoneId"];
if (count _this == 1) then
{
	_zoneId = _this select 0;
	private["_xy"];
	_xy = _zoneId call fnc_dacZones_GetZoneXyFromId;
	_zoneRow = (_xy select 0);
	_zoneLine = (_xy select 1);
}
else
{
	_zoneRow = (_this select 0);
	_zoneLine = (_this select 1);
	_zoneId = [_zoneRow, _zoneLine] call fnc_dacZones_GetZoneIdFromXy;
};

private["_trigger"];
call compile format["_trigger = zx%1y%2",_zoneRow + 1, _zoneLine + 1];
private["_triggerArea"];
_triggerArea = triggerArea _trigger;
private["_triggerPosition"];
_triggerPosition = getPos _trigger;

private["_values"];
_values = [ format["dacZone%1", _zoneId], [_zoneId, 0,0,0], [1,1,20,10], [], [], [], [0,0,0,1,1] ];

waituntil{DAC_NewZone == 0};
diag_log format["DEBUG: New Zone: %1", _values];
[(getPos _trigger),_triggerArea select 0, _triggerArea select 1,1,0, _values] call DAC_fNewZone;
waituntil{DAC_NewZone == 0};