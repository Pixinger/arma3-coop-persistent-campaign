
private["_result"];
_result = _this call fnc_dacZones_GetCampData;

if (count _result >= 6) then 
{ 
	_result = ((_result select 5) select 0); 
}
else
{
	_result = -1; 
};

diag_log format["Camp Data Respawns: %1", _result];
_result;