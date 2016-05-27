diag_log format["fnc_town_TownResume: _this = %1", _this];
waitUntil { townInitCompleted };

params["_townIndex"];

//for "_i" from 1 to 5 do
//{
	[_townIndex] call fnc_town_SpawnCivilian;
//};