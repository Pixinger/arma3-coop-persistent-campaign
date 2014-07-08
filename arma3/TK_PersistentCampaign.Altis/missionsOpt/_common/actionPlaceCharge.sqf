/* _this variable is: [target, caller, ID, arguments] */
private["_target"];
_target = (_this select 0);

private["_expl1"];
_expl1 = "DemoCharge_Remote_Ammo_Scripted" createVehicle position player; 
//_expl1 = "SatchelCharge_Remote_Ammo_Scripted" createVehicle position player; 
_expl1 attachTo [_target, [0,0,0.2]]; 
_expl1 setVectorDirAndUp [[0.5,0.5,0],[-0.5,0.5,0]];

player addAction ["Sprengladung zünden", 
{ 
	//fff allowDamage true;
	private["_target"];
	_target = (_this select 0);
	private["_argument"];
	_argument = (_this select 3);
	private["_charge"];
	_charge = _argument select 0;
	private["_target"];
	_target = _argument select 1;
	player removeAction (_this select 2); 
	detach _charge; 
	_charge setDamage 1;
	_target allowDamage true;
	_target setDamage 1;
}, [_expl1,_target]]; 

/*
player addMagazine "DemoCharge_Remote_Mag"; 
player addMagazine "SatchelCharge_Remote_Mag";

_c4 = "DemoCharge_Remote_Ammo_Scripted" createVehicle position player;

player playActionNow "PutDown"; 
player addMagazine "DemoCharge_Remote_Mag"; 
player selectWeapon "DemoChargeMuzzle"; 
player fire ["DemoChargeMuzzle", "DemoChargeMuzzle", "DemoCharge_Remote_Mag"]; 
player setWeaponReloadingTime [player, "DemoChargeMuzzle", 0];

c4 = []; 
player addAction ["Place Charge", { 
	player playActionNow "PutDown"; 
	_c4 = "DemoCharge_Remote_Ammo_Scripted" createVehicle position player;
	_n = count c4; c4 set [_n, _c4]; 
	player addAction [format ["Detonate Charge #%1", _n + 1], { 
		player removeAction (_this select 2); (c4 select (_this select 3)) setDamage 1; 
	}, _n]; 
}];*/