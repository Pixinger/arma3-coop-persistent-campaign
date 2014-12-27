private["_unit"];
_unit = cursorTarget;
if ((_unit isKindOf "SoldierGB") && (_unit distance player < 5) && (alive _unit)) then
{
	removeAllWeapons _unit;
	//player action ["Surrender", _unit];
	doStop _unit;
	_unit setBehaviour "CARELESS";
	_unit setCaptive 1;
	//_unit playMove "amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon"; //in
	_unit setVariable["AA", 2, true]; // 0==Aktiv 1==FSM-Finished 2==Arrested
	Sleep 2;
	_unit playMove "amovpercmstpssurwnondnon"; //in
	_unit disableAI "AUTOTARGET";
	_unit disableAI "TARGET";
	_unit disableAI "MOVE";
	_unit disableAI "ANIM";
	_unit disableAI "FSM";
	
	
	//_unit playMoveNow "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"; //out
	//"BoundCaptive_loop"
	//"boundCaptive_unaErc"
	//"amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon";	

};

