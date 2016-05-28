private["_vehicle"];
_vehicle = _this select 0;

private["_weaponArray"];
_weaponArray = getWeaponCargo _vehicle;	

private["_magazineArray"];
_magazineArray = getMagazineCargo _vehicle;	

private["_itemArray"];
_itemArray = getItemCargo _vehicle;	

private["_backpackArray"];
_backpackArray = getBackpackCargo _vehicle;	

// ------------------------------------------------------------------------
private["_cargoArray"];
_cargoArray = [_weaponArray, _magazineArray, _itemArray, _backpackArray];
diag_log format["GetCehicleCargoArray: %1", _cargoArray];

_cargoArray;