private ["_primaryWeapon"];
_primaryWeapon = primaryWeapon player;
private["_handGun"];
_handGun = handgunWeapon player;
private["_currentWeapon"];
_currentWeapon = currentWeapon player;
	
if ( (_currentWeapon == _handGun) && (_handGun != "") )  then 
{
	player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_2"; // Pistol
} 
else
{
	if (_primaryWeapon != "") then 
	{
		player playMoveNow "AinvPknlMstpSlayWrflDnon_medic"; // Rifle
	} 
	else
	{
		player playMoveNow "AmovPercMstpSnonWnonDnon_exercisekneeBendA"; // Nix
	};
 };