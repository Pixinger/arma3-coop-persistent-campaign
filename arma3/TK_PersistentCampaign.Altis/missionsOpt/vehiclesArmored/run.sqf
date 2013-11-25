private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1;

/*-------------------------------------*/
/* Weiterleitung mit bestimmter Klasse */
/*-------------------------------------*/
private["_tmp"];
_tmp = [_zoneIndex, _missionInfoIndex, "O_MBT_02_cannon_F"] execVM "missionsOpt\vehicles\run.sqf";