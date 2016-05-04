/* 
	Berechnet eine zufällige Position innerhalb einer Zone.
	Die Position muss auf dem "freien Feld" liegen.
	
Parameter:
	_objectPosition: Die Position
	_objectRadius: Der Radius	
	_maxElevation: (optional) die maximal erlaubte Elevation

Return: 
	The random location. [[0,0,0],0] ([position, direction]) 
	If no position was found or markername is invalid: [[0,0,0],0]

/*-------------------------------------------------------------------*/

private["_objectPosition"];
_objectPosition = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;

private["_objectRadius"];
_objectRadius = [_this, 1, 0, [0]] call BIS_fnc_param;

private["_maxElevation"];
_maxElevation = [_this, 2, 100, [0]] call BIS_fnc_param;

/*-------------------------------------------------------------------*/

private["_result"];
_result = [[0,0,0],0];

private["_loopLimit"];
_loopLimit = 100;
while { _loopLimit > 0 } do
{ 
	_loopLimit = _loopLimit - 1;
	private["_position"];	
	_position = [_objectPosition, _objectRadius] call fnc_aiz_GetRandomPositionCircle;

	if (!surfaceIsWater _position) then 
	{	
		//_position = _position findEmptyPosition [0,50];
		//if (count _position > 0) then
		//{
			_position set [2,0];
			if (count (_position nearObjects ["House", 20]) == 0) then
			{
				if (count (_position nearRoads 20) == 0) then
				{
					if (_maxElevation <= 100) then
					{
						if ([_position, 10, _maxElevation] call fnc_TownSM_IsFlat) then
						{
							_result = [_position, random 360];
							_loopLimit = 0; /* Exit */
						};
					}
					else
					{
						_result = [_position, random 360];
						_loopLimit = 0; /* Exit */
					};
				};
			};
		//};
	};
};

_result;
