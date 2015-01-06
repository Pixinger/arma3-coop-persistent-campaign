private["_result"];
_result = false;

private["_vehicle"];
_vehicle = cursorTarget;

private["_weapons"];
_weapons = nearestObjects [(position player), ["GroundWeaponHolder","WeaponHolder"], 2];
if (count _weapons > 0) then
{
	_result = true;
};

_result