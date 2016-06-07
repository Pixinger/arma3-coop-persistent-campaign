//diag_log format["fnc_aiz_GroupReduce: _this=%1", _this];
private _group = _this select 0;

private _unitInfos = [];
{ 
	_unitInfos pushBack [skill _x];
	_x setSpeedMode "LIMITED";
	_x setBehaviour "CARELESS";
	_x setSkill 0;
} foreach (units _group);

//diag_log format["fnc_aiz_GroupReduce: _unitInfos=%1", _unitInfos];
_unitInfos;