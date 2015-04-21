if (call fnc_Admin_RallyTeleportCond) then
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
		player globalchat "Kein Platz für die Flagge gefunden!";
	};
};
