private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1;

/*---------------------*/
/* Classname bestimmen */
/*---------------------*/
private["_names"];
_names = ["O_APC_Wheeled_02_rcws_F", "O_MRAP_02_hmg_F", "O_MRAP_02_gmg_F"];
private["_name"];
_name = _names select (floor (random (count _names)));

/*-------------------------------------*/
/* Weiterleitung mit bestimmter Klasse */
/*-------------------------------------*/
private["_tmp"];
_tmp = [_zoneIndex, _missionInfoIndex, _name] execVM "missionsOpt\vehicle\run.sqf";