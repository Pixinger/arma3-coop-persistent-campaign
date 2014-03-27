/* _this variable is: [target, caller, ID, arguments] */
private["_unit"];
_unit = (_this select 0);
_unit setCaptive true;
[_unit] join (group player);

removeAllPrimaryWeaponItems _unit;
removeAllHandgunItems _unit;
removeAllWeapons _unit;