/* 
Festnhemen Animiation

Parameter:
	_unit: Die festzunehmende Einheit

Return: 
	nix
*/

private["_unit"];
_unit = _this select 0;

//_unit playMoveNow "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"; //out
//"BoundCaptive_loop"
//"boundCaptive_unaErc"
//"amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon";	
//_unit playMove "amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon"; //in
_unit playMove "amovpercmstpssurwnondnon"; //in
_unit disableAI "AUTOTARGET";
_unit disableAI "TARGET";
_unit disableAI "MOVE";
_unit disableAI "ANIM";
_unit disableAI "FSM";

true;