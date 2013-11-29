if (isServer) then
{
	private["_config"];
	_config = [
		[0.30, 0.00, 0.00, 0.00, random 360], /*(1) sonnig */
		[0.50, 0.00, 0.00, 0.20, random 360],
		[0.70, 0.00, 0.00, 0.30, random 360], /*(3) bewölkt */
		[0.85, 0.10, 0.00, 0.40, random 360], /* niesel */
		[1.00, 0.30, 0.10, 0.60, random 360], /* (5) regnerisch */
		[1.00, 0.60, 0.30, 0.80, random 360],
		[1.00, 1.00, 0.50, 1.00, random 360] /* (7) stürmisch */
	]; 
	
	/* debug */
	if (isServer && !isDedicated) then { pixParamWeather = 0; };
	
	/* zufall */
	if (pixParamWeather == 7) then { pixParamWeather = floor(random(6)); };

	/* an clienten weiterreiechen */
	pvPixWeatherData = _config select pixParamWeather;
	publicVariable "pvPixWeatherData";

	if (pixDebug) then { player globalChat format["pixWeather(ov,rn,fg,wf,wd): %1 / %2", pvPixWeatherData, overcast];};
	skipTime -24; 
	86400 setOvercast (pvPixWeatherData select 0); 
	skipTime 24; 
	sleep 0.1;
	simulWeatherSync; 
	
	private["_tmp"];
	_tmp = [] spawn {
		Sleep 5;
		1 setRain (pvPixWeatherData select 1);
		Sleep 2;
		1 setFog (pvPixWeatherData select 2);
		/*Sleep 1;
		1 setWindForce (pvPixWeatherData select 3);
		Sleep 1;
		1 setWindDir (pvPixWeatherData select 4);*/
		player sidechat "weather done";
	};
};

if (!isServer) then
{
	waitUntil { !(isNil "pvPixWeatherData") };
	if (pixDebug) then { player globalChat format["pixWeather(ov,rn,fg,wf,wd): %1", pvPixWeatherData];};
	skipTime -24; 
	86400 setOvercast (pvPixWeatherData select 0); 
	skipTime 24; 
	/*sleep 0.1;*/
	simulWeatherSync; 
	
	private["_tmp"];
	_tmp = [] spawn {
		Sleep 5;
		1 setRain (pvPixWeatherData select 1);
		Sleep 2;
		1 setFog (pvPixWeatherData select 2);
		/*Sleep 1;
		1 setWindForce (pvPixWeatherData select 3);
		Sleep 1;
		1 setWindDir (pvPixWeatherData select 4);*/
		player sidechat "weather done";
	};
};
