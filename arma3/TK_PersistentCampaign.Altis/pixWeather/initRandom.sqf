// pixWeather: Client side
if (!isServer || !isDedicated) then
{
	//------------------------------------------------------------------
	// Array Beschreibung: pvehPixWeatherData
	//------------------------------------------------------------------
	// pvehPixWeatherData select 0: setRain value
	// pvehPixWeatherData select 1: setOvercast value
	// pvehPixWeatherData select 2: setFog value
	// pvehPixWeatherData select 3: setWindForce value
	// pvehPixWeatherData select 4: setWindDir value
	//------------------------------------------------------------------
	"pvehPixWeatherData" addPublicVariableEventHandler {
		private ["_weather"];
		_weather = _this select 1; 
		60 setOvercast (_weather select 1);
		60 setRain (_weather select 0);
		60 setFog (_weather select 2);
		60 setWindForce (_weather select 3);
		60 setWindDir (_weather select 4);
		player groupChat format["Weather update: o%1 r%2 f%3 w%4,%5",(_weather select 1),(_weather select 0),(_weather select 2),(_weather select 3),(_weather select 4)];
	};
	
	//------------------------------------------------------------------
	// Bei JIP wird der EventHandler beim ersten mal nicht aufgerufen, 
	// da die Variable schon vor dem Ausführen der init.sqf initialisiert 
	// wurde. Deshalb erledigen wir das einmal manuell.
	//------------------------------------------------------------------
	player groupchat "waiting for weather data";
	waitUntil {!(isNil "pvehPixWeatherData")};
	private ["_weather"];
	_weather = pvehPixWeatherData; 
	0 setOvercast (_weather select 1);
	0 setRain (_weather select 0);
	0 setFog (_weather select 2);
	0 setWindForce (_weather select 3);
	0 setWindDir (_weather select 4);
	player groupChat format["weather data recevied: o%1 r%2 f%3 w%4,%5",(_weather select 1),(_weather select 0),(_weather select 2),(_weather select 3),(_weather select 4)];
};

// pixWeather: Server side
if (isServer) then
{
	[] spawn = {
		waituntil {!isnil "bis_fnc_init"};
		
		private ["_weather","_rain","_fog","_overcast","_windForce","_windDir","_time"];

		_time = 0;
		while {true} do
		{
			_rain = random 1;
			_fog = random 1;
			_overcast = random 1;
			_windForce = random 1;
			_windDir = random 360;
			
			//------------------------------------------------------------------
			// Wetterdaten auf dem Server setzen (für korrektes KI Verhalten)
			//------------------------------------------------------------------
			_time setOvercast _overcast;
			_time setRain _rain;
			_time setFog _fog;
			_time setWindForce _windForce;
			_time setWindDir _windDir;
				
			//------------------------------------------------------------------
			// Wetterdaten an alle Clienten weiterreichen
			// Array Beschreibung: pvehPixWeatherData
			//------------------------------------------------------------------
			// pvehPixWeatherData select 0: setRain value
			// pvehPixWeatherData select 1: setOvercast value
			// pvehPixWeatherData select 2: setFog value
			// pvehPixWeatherData select 3: setWindForce value
			// pvehPixWeatherData select 4: setWindDir value
			//------------------------------------------------------------------
			pvehPixWeatherData = [_rain, _overcast, _fog, _windForce, _windDir];
			publicVariable "pvehPixWeatherData";
			
			Sleep 60*30; // Alle halbe Stunde
			_time = 60;
		};
	};
};