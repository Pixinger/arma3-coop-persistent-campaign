/* 	pixParamDate = [month, day]
	pixParamTime = hour */

/* right now this skript is in no way magic. but for the start it should be fine */	
if (isServer && isDedicated) then
{
	private["_paramValues"];
	_paramValues = [[(floor(random(12))) + 1, (floor(random(28))) + 1], [7,1],[3,1],[10,1],[1,1]]; /* {"Zufall", "Sommer", "Frühling", "Herbst", "Winter"}; */
	private["_date"];
	_date = _paramValues select pixParamDate;
	
	if (pixParamTime == 0) then 
	{ 
		_date = _date + [(floor(random(23))) + 1]; 
	} 
	else 
	{ 
		_date = _date + [pixParamTime - 1; 
	};

	/* debug */
	if (isServer && !isDedicated) then 
	{ 
		_date = [2,1,12]; /*01.02.2013/12Uhr*/
		diag_log format["INFO: Debug is overriding Parameter-Date to: %1", _date];
	};
	
	/* Datum setzen */
	diag_log format["Setting date to: %1", _date];
	setDate [2013, _date select 0, _date select 1, _date select 2, 0];
};