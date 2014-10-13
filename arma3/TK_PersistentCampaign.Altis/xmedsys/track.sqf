while { true } do
{
	Sleep 2;	
	private["_parsedText"];
	_parsedText = parseText format["
		dmg: %1<br/>
		pdmg: %2<br/>
		hearing: %3<br/>
		bleading: %4<br/>
		", [player, false] call X39_MedSys_fnc_getUnitDamage, [player, true] call X39_MedSys_fnc_getUnitDamage, [player] call X39_MedSys_fnc_getUnitHearing];
	hintSilent _parsedText; 
};