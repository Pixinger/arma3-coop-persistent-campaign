/* _this variable is: [target(action-object), caller, ID, arguments] */
private["_target"];
_target = (_this select 0); /* Das Objekt an welches das Action-Menü angehangen wurde. */

private["_expl1"];
_expl1 = "DemoCharge_Remote_Ammo_Scripted" createVehicle position player; /*SatchelCharge_Remote_Ammo_Scripted*/
_expl1 attachTo [_target, [0,0,0.75]]; 

player addAction ["Sprengladung zünden", 
{ 
	/* _this variable is: [target(player), caller, ID, arguments] */
	private["_argument"];
	_argument = (_this select 3); /* [charge, action-object]; */
	private["_charge"];
	_charge = _argument select 0;
	private["_actionObject"];
	_actionObject = _argument select 1;
	player removeAction (_this select 2); 
	detach _charge; 
	_charge setDamage 1;
	_actionObject allowDamage true;
	_actionObject setDamage 1;
	
	private["_radioTowers"];
	_radioTowers = nearestObjects [getPos _actionObject, ["Land_TTowerBig_1_F","Land_TTowerBig_2_F"], 50];
	{ 
		_x allowDamage true;
		_x setDamage 1;
	} foreach _radioTowers;	
}, [_expl1,_target]];