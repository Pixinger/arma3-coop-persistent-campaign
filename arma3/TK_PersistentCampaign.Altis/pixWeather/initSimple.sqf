/*[overcast,rain,fog,windforce,winddir]*/
[] spawn {
	Sleep 1;
	player sidechat format["p %1", pixParamWeather];
	private["_time"];
	_time = 5;
	_time setOvercast (pixParamWeather select 0);
	_time setRain (pixParamWeather select 1);
	_time setFog (pixParamWeather select 2);
	_time setWindForce (pixParamWeather select 3);
	_time setWindDir (pixParamWeather select 4);
	if (pixDebug) then { player globalChat "pixWeather: OK";};
};