player sidechat "join";

if ((cursorTarget isKindOf "SoldierWB") && (isPlayer cursorTarget)) then
{
	[player] join (group cursorTarget);	
	//player joinAs [(group cursorTarget), count (units (group cursorTarget))];
};