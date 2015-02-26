// Dieses Skript verteilt eine zufällige Seitenmission an eine Zufällige Stadt

if (ExecuteHeadlessCode) then
{
	private["_towns"];
	_towns = entities pixTown_ConfigObjectClassname;
	if (count _towns > 0) then
	{
		private["_limit"];
		_limit = 20;
		
		while { _limit > 0 } do 
		{
			private["_town"];
			_town = (_towns select (floor ( random (count _towns))));

			private["_sideMission"];
			_sideMission = _town getVariable ["sideMission", 0];		
			if (_sideMission == 0) then
			{
				_town setVariable ["sideMission", 10, false]; // Warlord			
				_limit = 0;
			};
		};
	}
	else
	{
		player sidechat "WARN: Es konnten keine Städte gefunden werden.";
	};
};