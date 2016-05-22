//[5] call fnc_aiz_ZoneInit;

if (isServer) then
{
	aizZoneInitCompleted = false;
	aizZoneActive = [];
	for "_i" from 0 to 63 do 
	{
		aizZoneActive pushBack false;
		[_i] call fnc_aiz_ZoneInit;
	};
	diag_log "init.sqf: isLoaded";

	aizZoneInitCompleted = true;
};
