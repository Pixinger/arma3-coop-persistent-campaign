onKeyPressRespawn = 
{ 
	private ["_key", "_shift", "_ctrl", "_alt", "_handled"];

    _key     = _this select 1; 
    _shift   = _this select 2; 
    _ctrl    = _this select 3; 
    _alt	 = _this select 4; 
    _handled = false; 
	
	(time + 1) spawn 
    { 
        while {time < _this} do 
        { 
			if (!(isNull (findDisplay 49))) exitWith 
            { 
                ((findDisplay 49) displayCtrl 1010) ctrlEnable false; 
            }; 
        }; 
	};

	_handled; 	
};

waitUntil { sleep 1; !(isNull (findDisplay 46)) }; 
(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call onKeyPressRespawn"];