/* ***************************************************************************************************** 
Written by TeTeT
********************************************************************************************************/

/**
  * globals for debugging
  */
TTT_DEBUG = true;
publicVariable "TTT_DEBUG";
ttt_fnc_debug = {
  if (TTT_DEBUG) then {
    player sideChat str(_this select 0);
    (_this select 0) call BIS_fnc_log;
  };
};

private["_zoneIndex"];
_zoneIndex = _this select 0;
private["_missionInfoIndex"];
_missionInfoIndex = _this select 1;

/*----------------------------------*/
/* Die Missionsdaten herausarbeiten */
/*----------------------------------*/
private["_missionOpt"]; /* [missionIndex, missionPosition, missionStatus] */
_missionOpt = ((pvehPixZones_MissionInfos select 2) select _missionInfoIndex);
private["_missionPosition"];
_missionPosition = _missionOpt select 1;
private["_missionDirection"];
_missionDirection = _missionOpt select 2;
private["_missionMarkerPosition"];
_missionMarkerPosition = _missionOpt select 3;
private["_missionMarkerRadius"];
_missionMarkerRadius = _missionOpt select 4;

/*---------------------------------------*/
/* Wenn notwendig die Clientside starten */
/*---------------------------------------*/
if (!isServer || !isDedicated) then
{
	// private["_tmp"];
	// _tmp = [_missionInfoIndex, _missionPosition, _missionDirection] execVM "missionsOpt\inspect\runClient.sqf";	
	private ["_taskTitle", "_taskDescription", "_tmp"];
        _taskTitle = "Fahrzeug inspizieren";
        _taskDescription = "Ein verdaechtiges Fahrzeug wurde entdeckt. Inspizieren Sie das Fahrzeug!";
        _tmp = [_missionInfoIndex, _missionMarkerPosition, _missionMarkerRadius, _taskTitle, _taskDescription] execVM "missionsOpt\_common\runClient.sqf";  
};

if (isServer) then
{
  ["server side run.sqf of inspect"] call TTT_fnc_debug;
  private["_vehicle", "_types", "_type", "_wheels", "_wheel", "_action", "_count"];
  _types = [ "C_Hatchback_01_F", "C_Hatchback_01_sport_F", "O_MRAP_02_F", 
             "C_Offroad_01_F", "C_Quadbike_01_F", "C_SUV_01_F", 
             "C_Van_01_transport_F", "C_Van_01_box_F", "O_Truck_02_transport_F",
             "O_Truck_02_covered_F"];
  _type = _types call BIS_fnc_selectRandom;
  _vehicle = _type createVehicle _missionPosition;
  ["Debug: Created vehicle"] call TTT_fnc_debug;
  _wheels = ["wheel_1_1_steering", "wheel_1_2_steering", "wheel_2_1_steering", "wheel_2_2_steering"];
  _wheel = _wheels call BIS_fnc_selectRandom;
  _vehicle setHit [_wheel, 1];
  _vehicle setHit ["motor", 1];
  Fock_addActionMP = {
    private ["_object", "_msg", "_script", "_args"];
    _object = _this select 0;
    _msg = _this select 1;
    _script = _this select 2;
    _args = _this select 3;
    if (isNull _object) exitWith {};
    _object addAction [_msg, _script, _args];
  };
  [[_vehicle, "Untersuche Fahrzeug", "missionsOpt\inspect\inspect.sqf", [_missionInfoIndex]], "Fock_addActionMP", nil, true] spawn BIS_fnc_MP;

  // loot money variable
  TeTeT_lootMoney = false;
  "pvTeTeT_lootMoney" addPublicVariableEventhandler {
    "in event handler pvTeTeT_lootMoney" call BIS_fnc_log;
    if (!TeTeT_lootMoney) then {
      TeTeT_lootMoney = true;
      ["Debug: Received Money (inspect)"] call TTT_fnc_debug;
      pvPixLogisticMoney = pvPixLogisticMoney + pvTeTeT_lootMoney;
      [format ["Money %1", pvPixLogisticMoney]] call TTT_fnc_debug;
    };
  };
  
  // safety if addAction doesn't work
  // waitUntil {player distance _vehicle < 10};
  ["Debug: checking distance"] call TTT_fnc_debug;
  _count = count ( (position _vehicle) nearEntities ["B_Soldier_base_F", 10]);
  while {_count == 0} do {
    ["Debug: distance to far"] call TTT_fnc_debug;
    sleep 5;
    _count = count ((position _vehicle) nearEntities ["B_Soldier_base_F", 10]);
  };
  ["Debug: close to car"] call TTT_fnc_debug;
  // FIXME: increase timeout
  sleep 15;
  _action = _vehicle getVariable "TeTeT_inspected";
  if (player distance _vehicle < 10 and isNil "_action") then {
    // TODO check if this works on dedicated server
    hint "Untersuche Fahrzeug ...";
    sleep 10;
    hint "Nichts gefunden.";
  } else {
    ["Debug: vehicle got inspected"] call TTT_fnc_debug;
  };
  ["Debug: completing mission"] call TTT_fnc_debug;
  if (pixZones_ActiveIndex != -1) then {
    (pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 1];
  } else {
    (pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 2];
  };
  publicVariable "pvehPixZones_MissionStatus";
};
