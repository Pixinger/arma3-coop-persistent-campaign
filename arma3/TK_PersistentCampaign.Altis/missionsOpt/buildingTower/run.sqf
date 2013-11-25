private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1;

/*-------------------------------------*/
/* Weiterleitung mit bestimmter Klasse */
/*-------------------------------------*/
private["_tmp"];
_tmp = [_zoneIndex, _missionInfoIndex, "Land_TTowerBig_1_F"] execVM "missionsOpt\building\run.sqf";