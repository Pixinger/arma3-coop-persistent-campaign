private _directory = "loadoutsNATO";
private _loadouts = [] call compile preprocessFileLineNumbers format["logistic\gear\%1\_getArray.sqf", _directory];
if (count _loadouts > 0) then { [(_this select 0), (_loadouts select 0)select 1, _directory] call fnc_logisticGear_ApplyLoadOut; };