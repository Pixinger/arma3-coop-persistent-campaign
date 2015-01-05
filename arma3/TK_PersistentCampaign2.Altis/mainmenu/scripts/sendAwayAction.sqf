private["_unit"];
_unit = cursorTarget;
if ((_unit isKindOf "Civilian_F") && (_unit distance player < 5) && (alive _unit))	then
{
	private["_position"];
	_position = getPos player;
	_position = [(_position select 0) - 200 + random 400, (_position select 1) - 200 + random 400,0];
	
	_position = _position findEmptyPosition [0, 100, "Civilian_F"]; 
	if (count _position > 0) then
	{
		_unit domove _position;
		hint "Verlassen Sie bitte diesen Platz! Hier ist es nicht sicher für Sie!";
	};	
};

