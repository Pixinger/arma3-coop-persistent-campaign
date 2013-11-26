/* bestimmen aus welchen Opfor Zonen die Bluefor Zone angegriffen werden KÖNNTE */
private["_attackedZoneIndex"];
_attackedZoneIndex = _this select 0;

private["_result"];
_result = [];

private["_possibleAttackingZones"];
_possibleAttackingZones = [_attackedZoneIndex] call fn_pixZones_GetConnectedHostileZones;
if (count _possibleAttackingZones > 0) then
{		
	/* bestimmen wieviele Zonen am Angriff teilnehmen */
	private["_attackingZoneCount"];
	_attackingZoneCount = floor(random(count _possibleAttackingZones));
	
	/* bestimmen welche Zonen nun auch wirklich angreifen */
	while { (count _result < _attackingZoneCount) } do
	{
		private["_index"];
		_index = floor(random(count _attackingZoneCount));
		if (!(_possibleAttackingZones select _index in _result)) then
		{
			_result =_result + [_possibleAttackingZones select _index];
		};
	};
};

_result;