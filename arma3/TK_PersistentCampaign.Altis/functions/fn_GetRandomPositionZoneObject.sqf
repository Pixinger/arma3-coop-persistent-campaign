/* 
	Berechnet eine zufällige Position innerhalb einer Zone.

Parameter:
	zoneIndex: Der Index der Zone die den gültigen Bereich definiert.
	zoneSafetyBorder: Sicherheitsabstand zum Rand.
	objectPosition: Wenn angegeben, dann wird nicht nur die Zone, sondern auch diese Position und der folgende Radius verwendet um die Ergenis-Position zu bestimmen. 
	objectRadius: Der Radius (siehe objectPosition).

Return: 
	The random position. [0,0,0] if no position was found or markername was invalid.

/*-------------------------------------------------------------------*/

private["_zoneIndex"];
_zoneIndex = [_this, 0, 0, [0]] call BIS_fnc_param;
if (_zoneIndex < 0) then { _zoneIndex = 0; };
if (_zoneIndex >= pixZones_ZoneCount) then { ["ZoneIndex is too large (%1/%2)", _zoneIndex, pixZones_ZoneCount] call BIS_fnc_error; _zoneIndex = 0; };

private["_zoneSafetyBorder"];
_zoneSafetyBorder = [_this, 1, 0, [0]] call BIS_fnc_param;
if (_zoneSafetyBorder < 0) then { _zoneSafetyBorder = 0; };

private["_objectPosition"];
_objectPosition = [_this, 2, [0,0,0], [[]], [2,3]] call BIS_fnc_param;

private["_objectRadius"];
_objectRadius = [_this, 3, 0, [0]] call BIS_fnc_param;


/*-------------------------------------------------------------------*/

private["_result"];
_result = [0,0,0];

if ((str(_objectPosition) != "[0,0,0]") && (_objectRadius > 0)) then
{
	private["_loopLimit"];
	_loopLimit = 100;
	while { _loopLimit > 0 } do
	{ 
		_loopLimit = _loopLimit - 1;

		private ["_rnd"];
		_rnd = random 360;

		private["_position"];
		_position = [(_objectPosition select 0) + (cos _rnd * (random _objectRadius)),(_objectPosition select 1) +(sin _rnd * (random _objectRadius))];
		
		if ([_zoneIndex, _position, _zoneSafetyBorder] call PC_fnc_IsPositionInZone) then { _result = _position; _loopLimit = 0; };
	};
};					
_result;