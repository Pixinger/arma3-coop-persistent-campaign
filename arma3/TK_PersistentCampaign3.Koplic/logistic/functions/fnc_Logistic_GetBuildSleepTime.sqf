private _massPlayer = [player] call fnc_logisticGear_GetCfgMassPlayer;
if (_massPlayer < 100) then {_massPlayer = 100;};
(1 + (0.0025 * (_massPlayer - 100)));

// 0.25er Schritte pro 100
// 100 = 1
// 200 = 1.25
//...
// 500 = 2
//...
// 900 = 3