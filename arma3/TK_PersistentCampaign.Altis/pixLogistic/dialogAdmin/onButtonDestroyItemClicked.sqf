closeDialog 0;

private ["_cursorTarget"];
_cursorTarget = cursorTarget;
if !(isNull _cursorTarget) then
{
	_cursorTarget setDamage 1;
};