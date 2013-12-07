closeDialog 0;
private ["_cursorTarget"];
_cursorTarget = cursorTarget;
if !(isNull _cursorTarget) then
{
	hint format["%1", typeof(_cursorTarget)];
	
	if (isServer && !isDedicated) then
	{
		player globalChat "simulate server";
		[_cursorTarget] execVM "pixLogistic\serverDeleteItem.sqf";
	}
	else
	{
		pvehPixlogisticDeleteItem = _cursorTarget;
		publicVariable "pvehPixlogisticDeleteItem";
	};
};
