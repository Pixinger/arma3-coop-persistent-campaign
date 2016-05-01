_result = ((_this select 1) * 100) + (_this select 0); //_result = (_zeile * 100) + _spalte;
diag_log format["fnc_dacZones_GetZoneIdFromXy: _result = %2 => %1", _result, _this];
_result;