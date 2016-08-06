if (isServer && !isDedicated) exitWith {true;};
if ((serverCommandAvailable "#logout") && {(getPlayerUID player in cfgPlayerAuthorizedPersonal)}) exitWith { true; };
false;