if (pixLogisticLift_DialogPiPEnabled) then 
{
	pixLogisticLift_DialogPiPEnabled = false;
	[] call BIS_fnc_liveFeedTerminate;
} 
else 
{
	hint "Activating camera...";
	pixLogisticLift_DialogPiPEnabled = true;
	
/*	BTC_l_feed_target = "Land_HelipadEmpty_F" createVehicle (position player);
	[] spawn {
		while {BTC_l_pip_cond} do 
		{
			BTC_l_feed_target setpos [getPos (vehicle player) select 0,(getPos (vehicle player) select 1) + 1,0];
			sleep 0.1;
		};
		deleteVehicle BTC_l_feed_target;
	};
	
	
	[player, player, player] call BIS_fnc_liveFeed;
	waitUntil {!(isNil "BIS_liveFeed")};
	hintSilent "";
	BIS_liveFeed attachTo [vehicle player,[0, - 1, -3]];
	BTC_l_feed_target call BIS_fnc_liveFeedSetTarget;
	WaitUntil {sleep 1; (!(vehicle player isKindOf "Helicopter") || !Alive player)};
	if (BTC_l_pip_cond) then {BTC_l_pip_cond = false;[] call BIS_fnc_liveFeedTerminate;};*/
};