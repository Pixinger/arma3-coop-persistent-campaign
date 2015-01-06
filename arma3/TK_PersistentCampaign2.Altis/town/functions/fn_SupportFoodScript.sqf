if (call fnc_Town_SupportFoodCond) then
{
	private["_vehicle"];
	_vehicle = cursorTarget;

	private["_content"];
	_content = _vehicle getVariable ["TC", 0];

	private["_position"];
	_position = (getPos _vehicle) findEmptyPosition [0, 40, pixTown_ConfigFoodClassname]; 
	if (count _position > 0) then
	{
		_vehicle setVariable["TC", _content - 1, true];

		private["_item"];
		_item = pixTown_ConfigFoodClassname createVehicle _position;
		_item setPos (_position);
		_item setVariable["TG", 10, true];	
	}
	else
	{
		player sidechat "Kein Platz für die Palette!";
	};
};
