/*
	
[
	[[3000,18528,-12.5749],700fe400# 1690236: cargo_hq_v1_f.p3d,<No group>:0 (Logic),100,0,[10,0],[4000]],
	[[4000,20528,0],8e5d8800# 1690272: cargo_hq_v1_f.p3d,<No group>:0 (Logic),100,0,[10,0],[4000]],
	[[6000,16528,0],8e158100# 1690309: cargo_hq_v1_f.p3d,<No group>:0 (Logic),100,0,[10,0],[4000]],
	[[5000,18528,0],634c8800# 1690364: cargo_hq_v1_f.p3d,<No group>:0 (Logic),100,0,[10,0],[4000]]
]

*/



private["_triggerName"];

if (count _this == 2) then
{
	_triggerName = format["zx%1y%2", _this select 0, _this select 1];
}
else
{
	_triggerName = _this select 0;
};

private["_result"];
_result = [];

private["_trigger"];
_trigger = call compile _triggerName;

private["_position"];
private["_positionTrigger"];
_positionTrigger = getPos _trigger;

{
	_position = _x select 0;
	if ((_position select 0 == _positionTrigger select 0) && {(_position select 1 == _positionTrigger select 1)}) exitWith { _result = _x; };
} foreach DAC_Spawn_CampsE;

diag_log format["Camp Data: %1: %2", _triggername, _result];
_result;