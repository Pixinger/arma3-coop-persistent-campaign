/* 
	Berechnet eine zufällige Position innerhalb einer Zone.
	Die Position muss in einer Stadt liegen.
	
Parameter:
	_objectPosition: Die Position
	_objectRadius: Der Radius	

Return: 
	The random location. [[0,0,0],0] ([position, direction]) 
	If no position was found or markername is invalid: [[0,0,0],0]

/*-------------------------------------------------------------------*/

private["_objectPosition"];
_objectPosition = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;

private["_objectRadius"];
_objectRadius = [_this, 1, 0, [0]] call BIS_fnc_param;

/*-------------------------------------------------------------------*/

private["_result"];
_result = [[0,0,0],0];

private["_loopLimit"];
_loopLimit = 100;
while { _loopLimit > 0 } do
{ 
	_loopLimit = _loopLimit - 1;
	private["_position"];	
	_position = [_objectPosition, _objectRadius] call fnc_TownSM_GetRandomPositionCircle;
	
	private["_locations"];
	_locations = nearestLocations[_position, ["NameCityCapital","NameCity","NameVillage"], 1000];
	if (count _locations > 0) then
	{	
		_position = position (_locations select 0);
		if (((getPos _house) distance _objectPosition) < _objectRadius) then
		{
			_result = [_position, random 360];
			_loopLimit = 0; /* Exit */
		};
	};
};

_result;