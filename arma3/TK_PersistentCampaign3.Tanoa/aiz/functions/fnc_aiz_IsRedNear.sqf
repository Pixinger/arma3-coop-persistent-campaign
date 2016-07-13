// _this select 0:	position array
// _this select 1:	distance
//diag_log format["fnc_aiz_IsBlueNear: _this=%1 _result=%2", _this, ((count ((_this select 0) nearEntities ["SoldierWB", _this select 1])) > 0)];
((count ((_this select 0) nearEntities ["SoldierGB", _this select 1])) > 0)