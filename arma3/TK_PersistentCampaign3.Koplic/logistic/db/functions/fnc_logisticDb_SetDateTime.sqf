private ["_dateArray"];
call compile format["_dateArray = %1;", _this];
setDate _dateArray;
diag_log format["fnc_logisticDb_SetDateTime.sqf: _this = %1, _dateArray = %2, date = %3", _this, _dateArray, date];