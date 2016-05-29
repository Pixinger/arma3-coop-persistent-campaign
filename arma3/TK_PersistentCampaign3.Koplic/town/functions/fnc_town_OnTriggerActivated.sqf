if (isServer) then
{
	townActiveCounter = townActiveCounter + 1; 
	townActive set [(_this select 0), townActiveCounter];
	[(_this select 0), townActiveCounter] call fnc_town_TownResume;
	diag_log format["fnc_town_OnTriggerActivated: _this = %1", _this];
};