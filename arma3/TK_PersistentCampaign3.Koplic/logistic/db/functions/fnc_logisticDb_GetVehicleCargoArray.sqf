private["_vehicle"];
_vehicle = _this select 0;

private["_weaponArray"];
_weaponArray = getWeaponCargo _vehicle;	
//["arifle_mx_f","optic_aco","acc_pointer_ir"] = "arifle_mx_aco_pointer_f" call BIS_fnc_weaponComponents;
//newGun ["arifle_Mk20_MRCO_pointer_F"] call BIS_fnc_baseWeapon; // Returns "arifle_Mk20_F"
//BIS_fnc_liveFeed

private["_magazineArray"];
_magazineArray = getMagazineCargo _vehicle;	

private["_itemArray"];
_itemArray = getItemCargo _vehicle;	

private["_backpackArray"];
_backpackArray = getBackpackCargo _vehicle;	

// ------------------------------------------------------------------------
private["_cargoArray"];
_cargoArray = [_weaponArray, _magazineArray, _itemArray, _backpackArray];

_cargoArray;