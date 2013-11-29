/**
 * Inspect a vehicle and probably find some info
 */

private ["_vehicle", "_unit", "_id", "_found", "_what", "_ret", "_missionInfoIndex", "_params"];

// Init
_ret = false;

// Params
_vehicle= [_this, 0, ObjNull] call BIS_fnc_param;
_unit = [_this, 1, ObjNull] call BIS_fnc_param;
_id = [_this, 2, -1] call BIS_fnc_param;
_params = [_this, 3, []] call BIS_fnc_param;
_missionInfoIndex = [_params, 0, -1] call BIS_fnc_param;

if (_missionInfoIndex == -1) then {
  player sideChat "Mission Info Index not correct";
  player sideChat str(_params);
};

// only one inspection per vehicle
_vehicle removeAction _id;

hint format ["Untersuche Fahrzeug..."]; 
sleep 10;

// 2 in 3 chance ;)
_found = [true, true, false] call BIS_fnc_selectRandom;

if (_found) then {
  _what = ["ammo", "drug", "weapon"] call BIS_fnc_selectRandom;
  hint "Sie haben etwas gefunden, schauen Sie auf die Karte.";
  [_what, getPosATL _vehicle, _missionInfoIndex] execVM "missionsOpt\inspect\found.sqf";
  _ret = true;
} else {
  hint "Nichts gefunden!";
  // easiest way to complete the mission
  if (pixZones_ActiveIndex != -1) then {
    (pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 1];
  } else {
    (pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 2];
  };
  publicVariable "pvehPixZones_MissionStatus";
  if (isNil "pixZones_ActiveIndex") then {
    player sideChat "Should not happen?";
  };

  _ret = false;
};

_ret;
