/* Diese Function prüft, ob das Ziel (cursorTarget) revived werden kann */

private["_target"];
_target = cursorTarget;

if (!alive player) exitWith { false };
if ((player getVariable "pixRevive_UNC") == 1) exitWith { false };
if ((_target getVariable "pixRevive_UNC") == 0) exitWith { false };
if ((_target getVariable "pixRevive_DRG") == 1) exitWith { false };
if (pixRevive_IsDragging) exitWith { false };
if (isNil "_target") exitWith { false };
if (!alive _target) exitWith { false };
if ((_target distance player) > 2 ) exitWith { false };
if (isNil "_target") exitWith { false };
if (!(pixRevive_RequiredItem in (items player))) exitWith { false };
	
true