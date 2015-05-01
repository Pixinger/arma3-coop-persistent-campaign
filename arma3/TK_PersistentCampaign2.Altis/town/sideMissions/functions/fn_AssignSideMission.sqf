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
		
		private["_missionID"];
		_missionID = ((floor(random (SIDE_MISSION_COUNT))) + 1) * 10;  // 10, 20, 30, ...
		while { _limit > 0 } do 
		{
			_limit = _limit - 1;
			
			private["_town"];
			_town = (_towns select (floor ( random (count _towns))));

			private["_sideMission"];
			_sideMission = _town getVariable ["sideMission", 0];		
			if (_sideMission == 0) then
			{
				_town setVariable ["sideMission", _missionID, true]; // true ist glaube ich nicht wirklich notwendig.
				diag_log format["OK: fn_AssignSideMission assigned mission %1 to town at %2", _missionID, getpos _town];
				_limit = -10;
			};
		};
		
		if (_limit != -10) then
		{
			diag_log format["WARN: fn_AssignSideMission failed. Es konnte keine Stadt mit freier SideMission gefunden werden.", _missionID];
		};
	}
	else
	{
		diag_log "WARN: fn_AssignSideMission failed. Es konnten keine Städte gefunden werden.";
	};
};