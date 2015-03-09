/* 
	Berechnet eine zufällige Position innerhalb einer Zone.
	Die Position muss auf dem "Wasser" liegen.
	
Parameter:
	_objectPosition: Die Position
	_objectRadius: Der Radius
	(optional) minDepth: Gibt an, wie tief diese Position mindestens sein muss.
	(optional) maxDepth: Gibt an, wie tief diese Position maximal sein darf.

Return: 
	The random location. [0,0,0] 
	If no position was found or markername is invalid: [0,0,0]

/*-------------------------------------------------------------------*/

private["_objectPosition"];
_objectPosition = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;

private["_objectRadius"];
_objectRadius = [_this, 1, 0, [0]] call BIS_fnc_param;

private["_minDepth"];
_minDepth = [_this, 2, 0, [0]] call BIS_fnc_param;

private["_maxDepth"];
_maxDepth = [_this, 3, 0, [0]] call BIS_fnc_param;

/*-------------------------------------------------------------------*/

private["_result"];
_result = [0,0,0];

private["_loopLimit"];
_loopLimit = 100;
while { _loopLimit > 0 } do
{ 
	_loopLimit = _loopLimit - 1;
	private["_position"];	
	_position = [_objectPosition, _objectRadius] call fnc_TownSM_GetRandomPositionCircle;
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
			_result = _position;
			_loopLimit = 0; /* Exit */
		};
	};
};

_result;