/* 	pixParamDate = [month, day]
	pixParamTime = hour */

/* right now this skript is in no way magic. but for the start it should be fine */	
if (isServer && isDedicated) then
{
	/* debug */
	if (isServer && !isDedicated) then { pixParamDate = [2,1]; pixParamTime = 12; };
	
	/* Datum setzen */
	setDate [2013, pixParamDate select 0, pixParamDate select 1, pixParamTime, 0];
};