/* 
	Berechnet eine zufällige Position innerhalb einer Zone.
	Die Position ist die Position eines Gebäudes.
	
Parameter:
	_objectPosition: Die Position
	_objectRadius: Der Radius	

Return: 
	The random location. [[0,0,0], 0] ([position, building position]) 
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
	_position = [_objectPosition, _objectRadius] call fnc_aiz_GetRandomPositionCircle;
	
	private["_house"];
	_house = nearestObject [_position, "house"];
	if (!isNull _house) then
	{
		if (((getPos _house) distance _objectPosition) < _objectRadius) then
		{
			private["_maxIndex"];
			_maxIndex = 0;
			while { str(_house buildingPos _maxIndex) != "[0,0,0]" } do { _maxIndex = _maxIndex + 1;};
			if ((_maxIndex < 8) && (_maxIndex > 0)) then
			{
				_maxIndex = floor(random(_maxIndex));
				_result = [_house buildingPos _maxIndex, _maxIndex];
				_loopLimit = 0;
			};
		};
	};
};

_result;
