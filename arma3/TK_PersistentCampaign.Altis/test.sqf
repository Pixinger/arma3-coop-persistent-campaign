

private ["_cursorTarget"];
_cursorTarget = player;
if !(isNull _cursorTarget) then
{
	private["_classname"];
	_classname = typeof(_cursorTarget);	
	private["_goggles"];
	_goggles = goggles _cursorTarget;
	private["_vest"];
	_vest = vest _cursorTarget;
	private["_headgear"];
	_headgear = headgear _cursorTarget;
	private["_uniform"];
	_uniform = uniform _cursorTarget;
	private["_backpack"];
	_backpack = backpack _cursorTarget;
	private["_items"];
	_items = items _cursorTarget;
	private["_weapons"];
	_weapons = weapons _cursorTarget;
	private["_primaryWeaponItems"];
	_primaryWeaponItems = primaryWeaponItems _cursorTarget;	
	
	private["_parsedText"];
	_parsedText = parseText format["
		classname: %1<br/>
		googles: %2<br/>
		vest: %3<br/>
		headgear: %4<br/>
		uniform: %5<br/>
		backpack: %6<br/>
		items: %7<br/>
		weapons: %8<br/>
		pwi's: %9<br/>
		to: %10</br>
		var: %11
		", _classname, _goggles, _vest, _headgear, _uniform, _backpack, _items, _weapons, _primaryWeaponItems, typeof _cursorTarget, vehicleVarName _cursorTarget];
	hintSilent _parsedText; 
	diag_log _parsedText;
};