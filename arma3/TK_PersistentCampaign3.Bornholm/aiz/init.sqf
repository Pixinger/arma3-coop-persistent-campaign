//[5] call fnc_aiz_ZoneInit;

if (isServer) then
{
	aizLoaded = false;
	aizZoneActive = [];
	for "_i" from 0 to 63 do 
	{
		aizZoneActive pushBack false;
		[_i] call fnc_aiz_ZoneInit;
	};
	diag_log "init.sqf: isLoaded";

	aizLoaded = true;
};
