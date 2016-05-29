diag_log format["fnc_town_TownPause: _this = %1", _this];
waitUntil { townInitCompleted };

params ["_townIndex"];
townActive set [_townIndex, 0];