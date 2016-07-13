params ["_zoneIndex"];

if (isServer) then
{
	// -------------------------------------------------------------------------
	// aizZoneData%1 auslesen
	if (isNil format["aizZoneData%1", _zoneIndex]) exitWith	{ diag_log format["ERROR: fnc_aiz_IntelReveal: Unable to read aizZoneData%1", _zoneIndex]; false; };

	private "_zoneData";
	call compile format["_zoneData = aizZoneData%1;", _zoneIndex];

	private _intelCount = _zoneData select 4;
	_zoneData set [4, _intelCount + 1];
	diag_log format["INFO: Intel collected: zoneIndex=%1 _intelCount=%2", _zoneIndex, _intelCount];
}
else
{
	[_zoneIndex] remoteExec ["fnc_aiz_IntelIncrement", 2]; // 2= only server
};