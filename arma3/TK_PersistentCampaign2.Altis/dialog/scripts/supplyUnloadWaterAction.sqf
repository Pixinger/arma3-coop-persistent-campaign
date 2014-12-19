private["_vehicle"];
_vehicle = cursorTarget;
private["_content"];
_content = _vehicle getVariable ["content", 0];
if ((_vehicle isKindOf pixTown_ConfigSaniClassname) && ((_vehicle distance player) < 10) && (_content > 0)) then 
{
	private["_position"];
	_position = (getPos _vehicle) findEmptyPosition [0, 40, pixTown_ConfigWaterClassname]; 
	if (count _position > 0) then
	{
		_vehicle setVariable["content", _content - 1, true];

		private["_item"];
		_item = pixTown_ConfigWaterClassname createVehicle _position;
		_item setPos (_position);
		_item setVariable["content", 10, true];	
	}
	else
	{
		player sidechat "Kein Platz für das Wasserfass!";
	};
};