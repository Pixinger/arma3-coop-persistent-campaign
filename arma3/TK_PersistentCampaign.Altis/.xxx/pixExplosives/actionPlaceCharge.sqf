/* _this variable is: [target, caller, ID, arguments]  */

private["_cursorTarget"];
_cursorTarget = cursorTarget;
if (typeof _cursorTarget == "Land_TTowerBig_2_F") then
{
	if (player distance _cursorTarget < 24) then
	{
		private["_expl1"];
		_expl1 = "DemoCharge_Remote_Ammo_Scripted" createVehicle position player; 
		//_expl1 attachTo [_cursorTarget, [2.4,2.7,-23.2]]; 
		_expl1 setPos [getPos _cursorTarget select 0, getPos _cursorTarget select 1, 0]; 
		player addAction ["Sprengladung zünden", "pixExplosives\actionDetonateCharge.sqf", [_expl1,_cursorTarget]]; 	
	};
};
