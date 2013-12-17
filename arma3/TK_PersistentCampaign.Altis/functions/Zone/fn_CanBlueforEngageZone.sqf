/* 
	 Prüft ob eine bestimmte Zone von den BlueFor Kräften angegriffen werden kann.

Parameter:
	_redZoneIndex: Der Index der Zone die angegriffen werden soll.

Return: 
	true wenn ein Angriff möglich ist, sonst false.

/*-------------------------------------------------------------------*/

private["_redZoneIndex"];
_redZoneIndex = [_this, 0, 0, [0]] call BIS_fnc_param;

/*-------------------------------------------------------------------*/

private["_redZoneIndex"];
_redZoneIndex = _this select 0;

private["_result"];
_result = false;

private["_zoneStatusCount"];
_zoneStatusCount = count pvehPixZones_ZoneStatus;

if (_redZoneIndex < _zoneStatusCount) then /* pvehPixZones_ZoneStatus könnte == [] sein */
{
	/* Angriff geht grundsätzlich nur auf Zonen die noch feindlich sind. */
	/* Staus ID's:
		0 = Sperrzone
		1 = Aktivierte/Angegriffene Zone
		2 = Freundliche Zone */
	if ((pvehPixZones_ZoneStatus select _redZoneIndex) == 0) then
	{
		/* Gesprochen prüfen wir hier folgendes: _redZoneIndex can be engaged when one of the Zones in '_greenZones' is GREEN. */
		private["_greenZones"];
		_greenZones = pixZones_ZoneConnectionsBlueFor select _redZoneIndex;
		
		{
			if (_x < _zoneStatusCount) then /* Für den Fall das ein zu hoher Index im Array steht. */
			{
				if ((pvehPixZones_ZoneStatus select _x) == 2) exitWith { _result = true; };
			};
		} foreach _greenZones;
	};
} 
else
{
	_result = false;
};

_result;