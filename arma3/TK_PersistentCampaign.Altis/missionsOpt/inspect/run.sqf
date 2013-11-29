/* ***************************************************************************************************** 
Written by TeTeT
********************************************************************************************************/
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

/*---------------------------------------*/
/* Wenn notwendig die Clientside starten */
/*---------------------------------------*/
if (!isServer || !isDedicated) then
{
	private["_tmp"];
	_tmp = [_missionInfoIndex, _missionPosition, _missionDirection] execVM "missionsOpt\inspect\runClient.sqf";	
};

if (isServer) then
{
  private["_vehicle", "_types", "_type", "_wheels", "_wheel"];
  _types = [ "C_Hatchback_01_F", "C_Hatchback_01_sport_F", "O_MRAP_02_F", 
             "C_Offroad_01_F", "C_Quadbike_01_F", "C_SUV_01_F", 
             "C_Van_01_transport_F", "C_Van_01_box_F", "O_Truck_02_transport_F",
             "O_Truck_02_covered_F"];
  _type = _types call BIS_fnc_selectRandom;
  _vehicle = _type createVehicle _missionPosition;
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
  [[_vehicle, "Untersuche Fahrzeug", "missionsOpt\inspect\inspect.sqf", [_missionInfoIndex]], "Fock_addActionMP", nil, false] spawn BIS_fnc_MP;
  
  // safety if addAction doesn't work
  waitUntil {player distance _vehicle < 10};
  sleep 5;
  if (player distance _vehicle < 10) then {
    hint "Untersuche Fahrzeug ...";
    sleep 10;
    hint "Nichts gefunden.";
  };
};
