if (isServer) then
{
	diag_log format["fnc_dacZones_OnTriggerActivated: _this = %1 (zoneNameInices)", _this];

	private["_ix"];
	_ix = (_this select 0);
	private["_iy"];
	_iy = (_this select 1);
	
	format["markerAizX%1Y%2", _ix, _iy] setMarkerColor "ColorRed";
};