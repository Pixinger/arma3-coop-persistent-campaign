private["_vehicle"];
_vehicle = cursorTarget;

private["_weapons"];
_weapons = nearestObjects [player, ["GroundWeaponHolder","WeaponHolder"], 4];
if (count _weapons > 0) then
{
	deleteVehicle cursorTarget;
	hint "Die Waffen wurden konfisziert.";
} 
else 
{ 
	hint "Es wurden keine Waffen gefunden.";
};