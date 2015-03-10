// Dieses Skript verteilt eine zufällige Seitenmission an eine Zufällige Stadt

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
				_missionID = ((floor random (3)) + 1) * 10;
				_town setVariable ["sideMission", _missionID, false]; // 10, 20, 30, ...
				_limit = 0;
			};
		};
	}
	else
	{
		player sidechat "WARN: Es konnten keine Städte gefunden werden.";
	};
};