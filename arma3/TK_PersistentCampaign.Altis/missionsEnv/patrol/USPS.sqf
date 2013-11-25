/*

Ultra Simple Patrol Script v1.6 by JW Custom



argument  0:  Unit/group leader - unit

argument  1:  Chance of unit/group existing in percentage. If set to 100 the unit/group will always exist  - number (0-100)

argument  2:  The radius where to randomly place the unit/group within                                     - number

argument  3:  The marker representing the radius center of where unit/group will be randomly placed within - string "markername"

argument  4:  The marker representing the center of the patrol area                                        - string "markername"

argument  5:  The radius where the unit/group will patrol within                                           - number

argument  6:  Randomly place place unit/group within the defined _spawnRadius                              - boolean (true/false)

argument  7:  The behaviour of the unit/group                                                              - string ("CARELESS"/"SAFE"/"AWARE"/"COMBAT"/"STEALTH")

argument  8:  Combat mode of unit/group.                                                                   - string ("BLUE"/"GREEN"/"WHITE"/"YELLOW"/"RED")

argument  9:  Movement speed of the unit/group.                                                            - string ("LIMITED"/"NORMAL"/"FULL") 

argument 10:  Group formation.                                                                             - string ("COLUMN"/"STAG COLUMN"/"WEDGE"/"ECH LEFT"/"ECH RIGHT"/"VEE"/"LINE"/"FILE"/"DIAMOND")

argument 11:  Wait time in seconds before moving on to next waypoint. Set to 0 and theres no wait time.    - number

argument 12:  Minimum distance between old and new waypoint.                                               - number

argument 13:  Altitude of unit/group. Unless unit/group are a air vehicle this should be set to 0.         - number

argument 14:  Search building arguments. If unit is a vehicle first argument in array should be false!     - Array containing 5 arguments, see below...



Search Building arguments:


argument 0:  Search buildings               - boolean (true/false)

argument 1:  Chance of seaching building    - number (0-100)

argument 2:  Building lookup radius         - number

argument 3:  Max building positions to walk - number

argument 4:  Wait time on each positions    - number



Usage example: null = [this, 100, 200, "patrol1", "patrol1", 200, true, "SAFE", "RED", "LIMITED", "FILE", 0, 30, 0, [true,35,25,3,1]] execVM "USPS.sqf";

*/




if (!isServer) exitWith {};

private ["_unit",
         "_existChance",
         "_spawnRadius",
         "_spawnMarker",
         "_patrolMarker",
         "_patrolRadius",
         "_useRanPlacement",
         "_unitBehaviour",
         "_unitCombatMode",
         "_unitSpeed",
         "_unitFormation",
         "_unitWaittime",
         "_minDistNextWP",
         "_flyInHeight",
         "_searchBuilding",
         "_curPos",
         "_ranPos",
         "_oldPos",
         "_grp",
         "_doHouseSearch",
         "_chanceHouseSearch",
         "_houseLookupRadius",
         "_doNumHousePos",
         "_waitHousePos",
         "_houseSelected",
         "_houseList",
         "_dice",
         "_numPos",
         "_oPos",
         "_pos",
         "_timeOut",
         "_kind"];

_unit            = _this select 0;
_existChance     = _this select 1;
_spawnRadius     = _this select 2;
_spawnMarker     = _this select 3;
_patrolMarker    = _this select 4;
_patrolRadius    = _this select 5;
_useRanPlacement = _this select 6;
_unitBehaviour   = _this select 7;
_unitCombatMode  = _this select 8;
_unitSpeed       = _this select 9;
_unitFormation   = _this select 10;
_unitWaittime    = _this select 11;
_minDistNextWP   = _this select 12;
_flyInHeight     = _this select 13;
_searchBuilding  = _this select 14;

_grp = group _unit;

_kind = vehicle _unit;

_chance = ceil(random 100);

if (_chance > _existChance) then
{
  {
    deleteVehicle vehicle _x;
    deleteVehicle _x;
  } forEach units _grp;
};

_oldPos = [0,0,0];
_curPos = getPos _unit;

_grp setBehaviour _unitBehaviour;
_grp setSpeedMode _unitSpeed;
_grp setFormation _unitFormation;
_grp setCombatMode _unitCombatMode;

if (_kind isKindOf "Man") then 
{

  if (_useRanPlacement) then
  {
    _dir = random 360;
    _dis = random _spawnRadius;
    _ranPos = [(markerPos _spawnMarker select 0) + _dis * sin _dir, (markerPos _spawnMarker select 1) + _dis * cos _dir, 0];

    _isWater = surfaceIsWater _ranPos;
    _isHouse = _ranPos nearObjects ["House_F",10];

    while {((_isWater) || (count _isHouse > 0))} do
    {
      _dir = random 360;
      _dis = random _spawnRadius;
      _ranPos = [(markerPos _spawnMarker select 0) + _dis * sin _dir, (markerPos _spawnMarker select 1) + _dis * cos _dir, 0];

      _isWater = surfaceIsWater _ranPos;
      _isHouse = _ranPos nearObjects ["House_F",10];
    };

    {
      _x setPos _ranPos;
    } forEach units _grp;

    _oldPos = _ranPos;
  }
  else
  {
    _ranPos = _curPos;
  };

  sleep 0.123;

  while {{alive _x} count units _grp > 0} do
  {
    _dir = random 360;
    _dis = random _patrolRadius;
    _ranPos = [(markerPos _patrolMarker select 0) + _dis * sin _dir, (markerPos _patrolMarker select 1) + _dis * cos _dir, 0];

    _isWater = surfaceIsWater _ranPos;
    _isHouse = _ranPos nearObjects ["House_F",10];

    while {((_isWater) || (count _isHouse > 0) || _ranPos distance _oldPos < _minDistNextWP)} do
    {
      _dir = random 360;
      _dis = random _patrolRadius;
      _ranPos = [(markerPos _patrolMarker select 0) + _dis * sin _dir, (markerPos _patrolMarker select 1) + _dis * cos _dir, 0];

      _isWater = surfaceIsWater _ranPos;
      _isHouse = _ranPos nearObjects ["House_F",10];
    };

    _oldPos = _ranPos;

    _grp move _ranPos;

    waitUntil{(((getPos leader _grp) distance _ranPos < 20) || (count units _grp < 1))};

    sleep _unitWaittime;

    _doHouseSearch = _searchBuilding select 0;
    if (_doHouseSearch) then
    {
      _chanceHouseSearch = _searchBuilding select 1;
      _dice = round(random 100);
      if (_dice < _chanceHouseSearch) then    
      {
        _houseLookupRadius = _searchBuilding select 2;
        _houseList = _ranPos nearObjects ["House_F",_houseLookupRadius];
        if (count _houseList > 0) then
        {
          _houseSelected = _houseList select floor(random(count _houseList));
          _numPos = 0;
          while { format ["%1", _houseSelected buildingPos _numPos] != "[0,0,0]" } do {_numPos = _numPos + 1};
          if (_numPos > 0) then
          {
            _doNumHousePos = _searchBuilding select 3;
            if (_doNumHousePos > _numPos) then {_doNumHousePos = _numPos};
            _oPos = 999;
            _pos = 999;
            for "_i" from 1 to _doNumHousePos do
            {
              while {_oPos == _pos} do {_pos = floor(random _numPos)};
              _oPos = _pos;
              _grp move (_houseSelected buildingPos _pos);
	      sleep 0.123;
	      _timeOut = time + 30;
              waitUntil {moveToCompleted leader _grp || moveToFailed leader _grp || count units _grp < 1 || _timeout < time};
              _waitHousePos = _searchBuilding select 4;
              sleep _waitHousePos;
            };
          };
        };
      };
    };
    sleep 1;
  };
};

if(_kind isKindOf "LandVehicle") then 
{
  if (_useRanPlacement) then
  {
    _dir = random 360;
    _dis = random _spawnRadius;
    _ranPos = [(markerPos _spawnMarker select 0) + _dis * sin _dir, (markerPos _spawnMarker select 1) + _dis * cos _dir, 0];

    _isWater = surfaceIsWater _ranPos;
    _isHouse = _ranPos nearObjects ["House_F",10];

    while {((_isWater) || (count _isHouse > 0))} do
    {
      _dir = random 360;
      _dis = random _spawnRadius;
      _ranPos = [(markerPos _spawnMarker select 0) + _dis * sin _dir, (markerPos _spawnMarker select 1) + _dis * cos _dir, 0];

      _isWater = surfaceIsWater _ranPos;
      _isHouse = _ranPos nearObjects ["House_F",10];
    };

    {
      vehicle _x setPos _ranPos;
    } forEach units _grp;

    _oldPos = _ranPos;
  }
  else
  {
    _ranPos = _curPos;
  };

  sleep 0.123;

  while {{alive _x} count units _grp > 0} do
  {
    _dir = random 360;
    _dis = random _patrolRadius;
    _ranPos = [(markerPos _patrolMarker select 0) + _dis * sin _dir, (markerPos _patrolMarker select 1) + _dis * cos _dir, 0];

    _isWater = surfaceIsWater _ranPos;
    _isHouse = _ranPos nearObjects ["House_F",10];

    while {((_isWater) || (count _isHouse > 0) || (_ranPos distance _oldPos < _minDistNextWP))} do
    {
      _dir = random 360;
      _dis = random _patrolRadius;
      _ranPos = [(markerPos _patrolMarker select 0) + _dis * sin _dir, (markerPos _patrolMarker select 1) + _dis * cos _dir, 0];

      _isWater = surfaceIsWater _ranPos;
      _isHouse = _ranPos nearObjects ["House_F",10];
    };

    _oldPos = _ranPos;
    (leader _grp) doMove _ranPos;
    _grp move _ranPos;

    waitUntil{((_unit distance _ranPos < 20) || (count units _grp < 1))};

    sleep _unitWaittime;
  };
};

if(_kind isKindOf "Air") then 
{
  _unit flyInHeight _flyInHeight;

  if (_useRanPlacement) then
  {
    _dir = random 360;
    _dis = random _spawnRadius;
    _ranPos = [(markerPos _spawnMarker select 0) + _dis * sin _dir, (markerPos _spawnMarker select 1) + _dis * cos _dir, _flyInHeight];

    {
      vehicle _x setPos _ranPos;
    } forEach units _grp;

    _oldPos = _ranPos;
  }
  else
  {
    _ranPos = _curPos;
  };

  sleep 0.123;

  _dir = getDir _unit;

  _unit setVelocity [sin(_dir)*50,cos(_dir)*50,0];


  while {{alive _x} count units _grp > 0} do
  {

    _dir = random 360;
    _dis = random _patrolRadius;
    _ranPos = [(markerPos _patrolMarker select 0) + _dis * sin _dir, (markerPos _patrolMarker select 1) + _dis * cos _dir, _flyInHeight];

    while {_ranPos distance _oldPos < _minDistNextWP} do
    {
      _dir = random 360;
      _dis = random _patrolRadius;
      _ranPos = [(markerPos _patrolMarker select 0) + _dis * sin _dir, (markerPos _patrolMarker select 1) + _dis * cos _dir, _flyInHeight];
    };

    _oldPos = _ranPos;
    (leader _grp) doMove _ranPos;
    _grp move _ranPos;

    waitUntil{((getPos leader _grp) distance _ranPos < 150) || count units _grp < 1};
    sleep _unitWaittime;
  };
};