diag_log format["fnc_town_TownResume: _this = %1", _this];
waitUntil { townInitCompleted };

params["_townIndex","_townActiveCounter"];

for "_i" from 1 to 5 do
{
	[_townIndex, _townActiveCounter] spawn fnc_town_SpawnCivilian;
};