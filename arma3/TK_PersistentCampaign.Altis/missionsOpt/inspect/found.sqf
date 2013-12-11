/**
 * Found something, either ammo, drug or weapon
 */

#define CIRCLEPOS2(p,d,r) CIRCLEPOS((p select 0), (p select 1), d, r)
#define CIRCLEPOS(x,y,d,r) [x+r*sin(d),y+r*cos(d)]

private ["_what", "_misPos", "_where", "_loot", "_missionInfoIndex", "_type", "_markerName"];

_what = [_this, 0, "drug"] call BIS_fnc_param;
/* this is the mission position */
_misPos = [_this, 1, [0,0,0]] call BIS_fnc_param;
_missionInfoIndex = [_this, 2, -1] call BIS_fnc_param;

if (_missionInfoIndex == -1) then {
  player globalChat "Mission Info index not correct";
};

/* change mission position to somewhere in 500 meter distance */
_where = CIRCLEPOS2(_misPos, random 360, 500);
while { surfaceIsWater _where } do {
  _where = CIRCLEPOS2(_misPos, random 360, 500);
};

switch (_what) do {
  case ("ammo"): {
    _loot = createVehicle ["Box_East_Ammo_F", _where, [], 0, "CAN_COLLIDE"];
    _markerName = "Munition";
  };
  case ("drug"): {
    _loot = createVehicle ["B_OutdoorPack_blk", _where, [], 0, "CAN_COLLIDE"];
    {
      createVehicle [_x, _where, [], 1, "NONE"];
    } forEach ["Land_VitaminBottle_F", "Land_VitamBottle_F", "Land_PainKillers_F"];
    _markerName = "Drogen";
    // FIXME does not work, seems Items cannot be added to backpacks?
    // _loot addItemCargo ["Land_Money_F", 1];
    // _loot addItemCargo ["Land_VitaminBottle_F", 1];
    // _loot addItemCargo ["Land_PainKillers_F", 1];
    _loot addWeaponCargoGlobal ["U_C_Poloshirt_blue", 1];
    _loot addWeaponCargoGlobal ["V_RebreatherB", 1];
    _loot addWeaponCargoGlobal ["U_B_Wetsuit", 1];
    _loot addWeaponCargoGlobal ["hgun_Rook40_F", 1];
    _loot addMagazineCargoGlobal ["16Rnd_9x21_Mag", 4];
    [_where] spawn {
      private ["_money", "_count", "_where"];
      _where = _this select 0;
      _money = createVehicle ["Land_Money_F", _where, [], 2, "NONE"];
      _count = count ((position _money) nearEntities ["B_Soldier_base_F", 4]);
      while {_count == 0} do {
        player globalChat "Debug: too far from money";
        sleep 5;
        _count = count ((position _money) nearEntities ["B_Soldier_base_F", 4]);
      };
      hint "Sie finden Geld! Kontostand pruefen";
      pvTeTeT_lootMoney = 500;
      publicVariableServer "pvTeTeT_lootMoney";
      deleteVehicle _money;
      // pvPixLogisticMoney = pvPixLogisticMoney + 500;
      // player globalChat format ["Money: %1", pvPixLogisiticMoney];
    };
  };
  case ("weapon"): {
    _loot = createVehicle ["Box_East_WpsSpecial_F", _where, [], 0, "CAN_COLLIDE"];
    _markerName = "Waffen";
  };
};

// create loot marker
createMarker ["loot", _where];
"loot" setMarkerShape "ICON";
"loot" setMarkerType "mil_dot";
"loot" setMarkerText _markerName;

// not needed right now
_what;
