diag_log format["fnc_dacZones_MessageQueuePush: _this = %1", _this];

if (count _this == 2) then
{ 
	dacZonesMessageQueue pushBack _this;
}
else
{
	dacZonesMessageQueue pushBack [[_this select 0,_this select 1] call fnc_dacZones_GetZoneIdFromXy, _this select 2];
};
