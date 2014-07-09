closeDialog 0;

pvehPixZones_SaveDatabase = true;
publicVariable "pvehPixZones_SaveDatabase";
if (isServer && !isDedicated) then { private["_tmp"]; _tmp = [] execVM "pixZones\pvehPixZones_SaveDatabase.sqf"; };
