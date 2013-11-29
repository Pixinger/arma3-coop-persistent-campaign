/**
 * Found something, either ammo, drug or weapon
 */

#define CIRCLEPOS2(p,d,r) CIRCLEPOS((p select 0), (p select 1), d, r)
#define CIRCLEPOS(x,y,d,r) [x+r*sin(d),y+r*cos(d)]

private ["_what", "_where", "_loot", "_missionInfoIndex", "_type"];

_what = [_this, 0, "drug"] call BIS_fnc_param;
// this is the mission position
_where = [_this, 1, [0,0,0]] call BIS_fnc_param;
_missionInfoIndex = [_this, 2, -1] call BIS_fnc_param;

if (_missionInfoIndex == -1) then {
  player sideChat "Mission Info index not correct";
};

// change mission position to somewhere in 500 meter distance
_where = CIRCLEPOS2(_where, random 360, 500);

switch (_what) do {
  case ("ammo"): {
    _loot = createVehicle ["Box_East_Ammo_F", _where, [], 0, "CAN_COLLIDE"];
  };
  case ("drug"): {
    _loot = createVehicle ["B_OutdoorPack_blk", _where, [], 0, "CAN_COLLIDE"];
    // FIXME does not work
    // _loot addItemCargo ["Land_Money_F", 1];
    // _loot addItemCargo ["Land_VitaminBottle_F", 1];
    // _loot addItemCargo ["Land_PainKillers_F", 1];
  };
  case ("weapon"): {
    _loot = createVehicle ["Box_East_WpsSpecial_F", _where, [], 0, "CAN_COLLIDE"];
  };
};

// create loot marker
createMarker ["loot", _where];
"loot" setMarkerShape "ICON";
"loot" setMarkerType "mil_dot";
"loot" setMarkerText _what;
// _loot setPosATL _where;

// for testing, mark mission complete
if (pixZones_ActiveIndex != -1) then {
  (pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 1];
} else {
  (pvehPixZones_MissionStatus select 1) set [_missionInfoIndex, 2];
};
publicVariable "pvehPixZones_MissionStatus";

if (isNil "pixZones_ActiveIndex") then {
  player sideChat "Should not happen?";
};

// not needed right now
_what;
