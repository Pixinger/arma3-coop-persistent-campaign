if (call fnc_Logistic_CanBuryCorpse) then 
{
	private _corpses = (position player) nearEntities ["ACE_bodyBagObject", 3];
	if (count _corpses > 0) then
	{
		call fnc_Logistic_WorkAnimationStart;		
		private _actionMenu = player addAction [(localize "str_pc3_AbortBury"), { logisticBuild = false; }, nil, 5, true, true];

		private _loopcount = 10;
		private _sleepTime = 1;
		logisticBuild = true;
		while { (logisticBuild) && (alive player) && (_loopcount > 0) } do
		{
			if (pixDebug) then { Sleep 0.2; } else { Sleep _sleepTime; };
			_loopcount = _loopcount - 1;
		};
		call fnc_Logistic_WorkAnimationEnd;
	
		player removeAction _actionMenu;
		logisticBuild = nil;

		if (alive player) then 
		{	
			deleteVehicle (_corpses select 0); 
			if ([1, 15] call BIS_fnc_randomInt <= 1) then
			{	
				[[1, cfgAizZoneCount] call BIS_fnc_randomInt] call fnc_aiz_IntelIncrement;
			};
		};
	};
};