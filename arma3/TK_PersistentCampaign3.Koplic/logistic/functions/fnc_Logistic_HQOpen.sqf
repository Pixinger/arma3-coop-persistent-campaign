private _cursorTarget = cursorTarget;
private _cursorTargetType = typeof _cursorTarget;

if (_cursorTargetType == logisticObjectHQClassname) then
{
	_cursorTarget animateSource ["Lock_source", 3];
	_cursorTarget animateSource ["Sesame_source", 3];
	_cursorTarget animateSource ["Antenna_source", 3];
};