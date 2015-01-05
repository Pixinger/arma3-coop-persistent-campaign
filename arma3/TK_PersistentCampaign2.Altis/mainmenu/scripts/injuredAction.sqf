 
if ((cursorTarget isKindOf "CAManBase") && (!(isPlayer cursorTarget)) && (cursorTarget getVariable ["injured", 0] != 0)) then
{
	cursorTarget setVariable ["injured", 0, true];
	player sidechat format["%1 wurde medizinisch versorgt.", cursorTarget];
};