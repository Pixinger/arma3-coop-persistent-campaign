diag_log "LP";
// _this select 0: player object (can be non local)
params ["_player"];

private _totalMass = 0;

_totalMass = _totalMass  + ((primaryWeapon player) call fnc_logisticGear_GetCfgMass);
{ _totalMass = _totalMass + ((_x) call fnc_logisticGear_GetCfgMass); } foreach (primaryWeaponMagazine player);
{ _totalMass = _totalMass + ((_x) call fnc_logisticGear_GetCfgMass); } foreach (primaryWeaponItems player);

_totalMass = _totalMass  + ((secondaryWeapon player) call fnc_logisticGear_GetCfgMass);
{ _totalMass = _totalMass + ((_x) call fnc_logisticGear_GetCfgMass); } foreach (secondaryWeaponMagazine player);
{ _totalMass = _totalMass + ((_x) call fnc_logisticGear_GetCfgMass); } foreach (secondaryWeaponItems player);

_totalMass = _totalMass  + ((handgunWeapon player) call fnc_logisticGear_GetCfgMass);
{ _totalMass = _totalMass + ((_x) call fnc_logisticGear_GetCfgMass); } foreach (handgunMagazine player);
{ _totalMass = _totalMass + ((_x) call fnc_logisticGear_GetCfgMass); } foreach (handgunItems player);

_totalMass = _totalMass  + ((goggles player) call fnc_logisticGear_GetCfgMass);
//_totalMass = _totalMass  + ((binocular player) call fnc_logisticGear_GetCfgMass);
_totalMass = _totalMass  + ((headgear player) call fnc_logisticGear_GetCfgMass);
//_totalMass = _totalMass  + ((hmd player) call fnc_logisticGear_GetCfgMass);

{ _totalMass = _totalMass + ((_x) call fnc_logisticGear_GetCfgMass); } foreach (assignedItems player);

_totalMass = _totalMass  + ((uniform player) call fnc_logisticGear_GetCfgMass);
{ _totalMass = _totalMass + ((_x) call fnc_logisticGear_GetCfgMass); } foreach (uniformItems player);

_totalMass = _totalMass  + ((vest player) call fnc_logisticGear_GetCfgMass);
{ _totalMass = _totalMass + ((_x) call fnc_logisticGear_GetCfgMass); } foreach (vestItems player);

_totalMass = _totalMass  + ((backpack player) call fnc_logisticGear_GetCfgMass);
{ _totalMass = _totalMass + ((_x) call fnc_logisticGear_GetCfgMass); } foreach (backpackItems player);

if (pixDebug) then { diag_log format["fnc_logisticGear_CalculateLoadoutPlayer.sqf: TotalMass = %1", _totalMass];};
_totalMass;