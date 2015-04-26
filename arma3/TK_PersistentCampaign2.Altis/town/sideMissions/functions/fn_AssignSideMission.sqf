// Dieses Skript verteilt eine zufällige Seitenmission an eine Zufällige Stadt
#define SIDE_MISSION_COUNT		4
if (ExecuteHeadlessCode) then
{
	private["_towns"];
	_towns = entities pixTown_ConfigObjectClassname;
	if (count _towns > 0) then
	{
		private["_limit"];
		_limit = 100;
		
		while { _limit > 0 } do 
		{
			private["_town"];
			_town = (_towns select (floor ( random (count _towns))));

			private["_sideMission"];
			_sideMission = _town getVariable ["sideMission", 0];		
			if (_sideMission == 0) then
			{
				private["_missionID"];
				_missionID = ((floor(random (SIDE_MISSION_COUNT))) + 1) * 10;
				_town setVariable ["sideMission", _missionID, false]; // 10, 20, 30, ...
				diag_log format["OK: fn_AssignSideMission assigned mission %1 to town at %2", _missionID, getpos _town];
				_limit = 0;
			};
		};
	}
	else
	{
		diag_log "WARN: fn_AssignSideMission failed. Es konnten keine Städte gefunden werden.";
	};
};