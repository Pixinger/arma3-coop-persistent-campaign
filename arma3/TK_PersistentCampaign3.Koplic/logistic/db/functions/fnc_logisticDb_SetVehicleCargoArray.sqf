private["_vehicle"];
_vehicle = _this select 0;
private["_cargoArray"];
_cargoArray = _this select 1;

clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

private["_array", "_classnames", "_quantities"];
_array = (_cargoArray select 0);
_classnames = _array select 0;
_quantities = _array select 1;
{
	_vehicle addWeaponCargoGlobal [_x, _quantities select _forEachIndex];
} foreach _classnames;

_array = (_cargoArray select 1);
_classnames = _array select 0;
_quantities = _array select 1;
{
	_vehicle addMagazineCargoGlobal [_x, _quantities select _forEachIndex];
} foreach _classnames;

_array = (_cargoArray select 2);
_classnames = _array select 0;
_quantities = _array select 1;
{
	_vehicle addItemCargoGlobal [_x, _quantities select _forEachIndex];
} foreach _classnames;

_array = (_cargoArray select 3);
_classnames = _array select 0;
_quantities = _array select 1;
{
	_vehicle addBackpackCargoGlobal [_x, _quantities select _forEachIndex];
} foreach _classnames;
