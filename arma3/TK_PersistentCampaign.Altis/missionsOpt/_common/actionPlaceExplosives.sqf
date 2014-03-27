/* _this variable is: [target, caller, ID, arguments] */

private["_expl1"];
/*_expl1 = "DemoCharge_Remote_Ammo_Scripted" createVehicle position player;*/
_expl1 = "DemoCharge_Remote_Ammo" createVehicle position player;
Sleep .3;
_expl1 attachTo [(_this select 0), [-0.1,0.1,0.15]];
_expl1 setVectorDirAndUp [[0.5,0.5,0],[-0.5,0.5,0]];

(_this select 0) allowDamage true;

_n = count pixExplosivesArray; 
pixExplosivesArray set [_n, _expl1];
player addAction [format ["Detonate Charge #%1", _n + 1], { player removeAction (_this select 2); (pixExplosivesArray select (_this select 3)) setDamage 1; }, _n]; 

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
}];