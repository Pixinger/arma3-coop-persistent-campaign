if (call fnc_Town_SupportWaterCond) then
{
	private["_vehicle"];
	_vehicle = cursorTarget;

	private["_content"];
	_content = _vehicle getVariable ["TG", 0];

	private["_position"];
	_position = (getPos _vehicle) findEmptyPosition [0, 40, pixTown_ConfigWaterClassname]; 
	if (count _position > 0) then
	{
		_vehicle setVariable["TG", _content - 1, true];

		private["_item"];
		_item = pixTown_ConfigWaterClassname createVehicle _position;
		_item setPos (_position);
		_item setVariable["TG", 10, true];	
	}
	else
	{
		player sidechat "Kein Platz für das Wasserfass!";
	};
};
