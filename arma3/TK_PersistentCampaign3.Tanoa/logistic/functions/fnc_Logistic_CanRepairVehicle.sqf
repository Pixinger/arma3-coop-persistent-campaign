private _result = false;
private _cursorTarget = cursorTarget;
private _cursorTargetType = typeof _cursorTarget;

if (_cursorTargetType in logisticRepairables) then
{
	if (player getVariable ["ACE_IsEngineer", 0] > 0) then 
	{
		if (count nearestObjects [getPos player, [cfgLogisticRepairObjectClassname], 100] > 0) then
		{
			_result = true;
		};
	};	
};

_result;