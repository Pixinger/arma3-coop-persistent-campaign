private["_button"];
_button = ["Nahrung entladen", false, true,"mainmenu\scripts\supplyUnloadFoodAction.sqf"];

private["_vehicle"];
_vehicle = cursorTarget;
private["_content"];
_content = _vehicle getVariable ["content", 0];
if ((_vehicle isKindOf pixTown_ConfigSaniClassname) && ((_vehicle distance player) < 10) && (_content > 0)) then 
{
	_button set [1, true];
};

_button;

