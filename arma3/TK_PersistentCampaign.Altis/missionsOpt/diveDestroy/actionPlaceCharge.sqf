/* _this variable is: [target(ammobox), caller, ID, arguments] */
private["_container"];
_container = (_this select 0); /* Die Ammobox */

private["_expl1"];
_expl1 = "DemoCharge_Remote_Ammo_Scripted" createVehicle position player; /*SatchelCharge_Remote_Ammo_Scripted*/
_expl1 attachTo [_container, [0,0,0.2]]; 
_expl1 setVectorDirAndUp [[0.5,0.5,0],[-0.5,0.5,0]];

player addAction ["Sprengladung zünden", 
{ 
	/* _this variable is: [target(player), caller, ID, arguments] */
	private["_argument"];
	_argument = (_this select 3); /* [charge, action-object]; */
	private["_charge"];
	_charge = _argument select 0;
	private["_container"];
	_container = _argument select 1;
	player removeAction (_this select 2); 
	detach _charge; 
	_charge setDamage 1;
	_container allowDamage true;
	_container setDamage 1;
}, [_expl1, _container]];