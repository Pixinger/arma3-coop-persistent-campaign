private _result = false;
private _cursorTargetType = typeof cursorTarget;

if (_cursorTargetType in logisticSellables) then
{
	_result = true;
};

_result;