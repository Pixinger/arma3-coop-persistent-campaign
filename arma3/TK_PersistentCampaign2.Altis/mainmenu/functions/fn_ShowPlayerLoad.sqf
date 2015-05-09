//1 lb is equal to 0.45359237

[] spawn {
	for "_i" from 1 to 20 do
	{
		private ["_currentFat"];
		private ["_currentFatText"];
		_currentFat = getFatigue player;
		if (_currentFat < 0.11) then {_currentFatText = "Fit";};
		if (_currentFat > 0.10 and _currentFat < 0.51) then {_currentFatText = "Aufgewärmt";};
		if (_currentFat > 0.50 and _currentFat < 0.86) then {_currentFatText = "Müde";};
		if (_currentFat > 0.85) then {_currentFatText = "Ausgelaugt";};

		hintSilent parseText format["
		<t size='1.25' color='#ff0000' underline='true'>Gewicht</t><br/>
		BWLoadCalc: %2 kg<br/>
		BWLoadCalc: %3 lb<br/>
		Original: %1<br/>
		<br/>
		<t size='1.25' color='#ff0000' underline='true'>Ermüdung</t><br/>
		%5<br/>
		%4 Prozent",
		loadAbs player,
		round ((((loadAbs player)*0.1)/2.2) * (10 ^ 2)) / (10 ^ 2),
		round ((loadabs player)*0.1),
		round ((getFatigue player) * 100),
		_currentFatText];
		
		Sleep 1;
	};
};