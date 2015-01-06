private["_vehicle"];
_vehicle = cursorTarget;

private["_weapons"];
_weapons = (position player) nearObjects [["GroundWeaponHolder","WeaponHolder"], 2];
if (count _weapons > 0) then
{
	deleteVehicle cursorTarget;
	hint "Die Waffen wurden konfisziert.";
} 
else 
{ 
	hint "Es wurden keine Waffen gefunden.";
};