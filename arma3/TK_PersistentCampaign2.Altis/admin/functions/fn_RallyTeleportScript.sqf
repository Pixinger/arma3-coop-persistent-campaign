if (call fnc_Vehicles_RalleyTeleportCond) then
{
	private["_vehicle"];
	_vehicle = cursorTarget;

	private["_position"];
	_position = (getPos _vehicle) findEmptyPosition [0, 40, admin_ConfigHQClassname];
	if (count _position > 0) then
	{
		ralleypoint setPos (_position);
	}
	else
	{
		player sidechat "Kein Platz für die Flagge gefunden!";
	};
};
