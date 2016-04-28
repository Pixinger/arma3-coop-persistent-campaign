private["_cursorTarget"];
_cursorTarget = cursorTarget;
private["_cursorTargetType"];
_cursorTargetType = typeof _cursorTarget;

private["_configIndex"];
_configIndex = logisticBuildables find _cursorTargetType;
if (_configIndex != -1) then
{
	deleteVehicle _cursorTarget;
}
else
{
	hint "Dieses Objekt kann nicht gelöscht werden.";
};