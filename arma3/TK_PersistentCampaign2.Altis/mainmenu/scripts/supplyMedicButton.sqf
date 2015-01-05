private["_button"];
_button = ["Mobiles Lazaret", false, true,"mainmenu\scripts\supplyMedicAction.sqf"];

private["_vehicle"];
_vehicle = cursorTarget;
private["_active"];
_active = _vehicle getVariable ["active", false];
if ((_vehicle isKindOf pixTown_ConfigSaniClassname) && ((_vehicle distance player) < 10)) then
{
	if (_active) then
	{
		_button set [0, "Hilfe einstellen"];
		_button set [1, true];
	}
	else	
	{
		_button set [0, "Hilfe anbieten"];
		_button set [1, true];
	};
};

_button;

