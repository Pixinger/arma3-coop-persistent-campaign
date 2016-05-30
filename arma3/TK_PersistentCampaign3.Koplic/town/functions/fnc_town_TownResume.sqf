waitUntil { townInitCompleted };
diag_log format["fnc_town_TownResume: _this = %1", _this];

params["_townIndex","_townActiveIndex"];

private _count = (townInfos select _townIndex) select 1;
if (pixDebug) then { _count = 1; };
for "_i" from 1 to _count do
{
	[_townIndex, _townActiveIndex] spawn fnc_town_SpawnCivilian;
};
