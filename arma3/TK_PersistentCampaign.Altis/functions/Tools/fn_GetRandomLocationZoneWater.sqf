/* 
	Berechnet eine zufällige Position innerhalb einer Zone.
	Die Position muss auf dem "Wasser" liegen.
	
Parameter:
	zoneIndex: Der Index der Zone die den gültigen Bereich definiert.
	(optional) safetyBorder: Sicherheitsabstand zum Rand. (Default 25)
	(optional) objectPosition: Wenn angegeben, dann wird nicht nur die Zone, sondern auch diese Position und der folgende Radius verwendet um die Ergenis-Position zu bestimmen. 
	(optional) objectRadius: Der Radius (siehe objectPosition).
	(optional) minDepth: Gibt an, wie tief diese Position mindestens sein muss.
	(optional) maxDepth: Gibt an, wie tief diese Position maximal sein darf.

Return: 
	The random location. [[0,0,0],0] ([position, direction]) 
	If no position was found or markername is invalid: [[0,0,0],0]

/*-------------------------------------------------------------------*/

private["_zoneIndex"];
_zoneIndex = [_this, 0, 0, [0]] call BIS_fnc_param;
if (_zoneIndex < 0) then { _zoneIndex = 0; };
if (_zoneIndex >= pixZones_ZoneCount) then { ["ZoneIndex is too large (%1)", _zoneIndex] call BIS_fnc_error; _zoneIndex = 0; };

private["_safetyBorder"];
_safetyBorder = [_this, 1, 25, [0]] call BIS_fnc_param;
if (_safetyBorder < 0) then { _safetyBorder = 0; };

private["_objectPosition"];
_objectPosition = [_this, 2, [0,0,0], [[]], [2,3]] call BIS_fnc_param;

private["_objectRadius"];
_objectRadius = [_this, 3, 0, [0]] call BIS_fnc_param;

private["_minDepth"];
_minDepth = [_this, 4, 0, [0]] call BIS_fnc_param;

private["_maxDepth"];
_maxDepth = [_this, 5, 0, [0]] call BIS_fnc_param;

/*-------------------------------------------------------------------*/

private["_result"];
_result = [[0,0,0],0];

private["_loopLimit"];
_loopLimit = 100;
while { _loopLimit > 0 } do
{ 
	_loopLimit = _loopLimit - 1;
	private["_position"];	
	if ((str(_objectPosition) == "[0,0,0]") || (_objectRadius == 0)) then
	{
		_position = [_zoneIndex, _safetyBorder] call PC_fnc_GetRandomPositionZone;
	}
	else
	{
		_position = [_zoneIndex, _safetyBorder, _objectPosition, _objectRadius] call PC_fnc_GetRandomPositionZoneObject;
	};
	if (surfaceIsWater _position) then 
	{	
		private["_isValid"];
		_isValid = true;
		
		private["_depth"];
		_depth = getTerrainHeightASL _position; 
		if ((_minDepth < 0) && (_depth > _minDepth)) then {	_isValid = false; };
		if ((_maxDepth < 0) && (_depth < _maxDepth)) then {	_isValid = false; };		
		if (_isValid) then
		{
			_position set [2, (random _depth)];
			_result = [_position, random 360];
			_loopLimit = 0; /* Exit */
		};
	};
};

_result;