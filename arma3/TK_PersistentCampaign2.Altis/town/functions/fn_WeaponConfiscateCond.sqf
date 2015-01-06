private["_result"];
_result = false;

private["_vehicle"];
_vehicle = cursorTarget;

private["_weapons"];
_weapons = nearestObjects [player, ["GroundWeaponHolder","WeaponHolder"], 4];
if (count _weapons > 0) then
{
	_result = true;
};

_result;