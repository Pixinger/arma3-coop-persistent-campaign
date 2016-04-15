private["_vehicle"];
_vehicle = myCar;

private["_details"];
_details = [];

private["_i"];
_i = 0;
private["_damage"];
_damage = _vehicle getHitIndex _i;
while { !isNil "_damage" } do 
{
	_details pushBack _damage;
	_i = _i + 1;
	_damage = _vehicle getHitIndex _i;
};

for "_i" from 0 to ((count _details)-1) do
{
	myClone setHitIndex [_i, _details select _i];
};



/*

private["_dd"];
_dd = damage _vehicle;
private["_details"];
_details = [];
private["_cfg"];
_cfg = (configFile >> "cfgVehicles" >> typeof(_vehicle) >> "HitPoints");
_count = count(_cfg) - 1;
for "_i" from 0 to _count do
{
	private["_cfg2"];
	_cfg2 = (_cfg select _i);
	private["_name"];
	_name = getText(_cfg2 >> "Name");
	_name = configName _cfg2;
	_details pushBack [_name, (_vehicle getHitPointDamage _name)];
};
diag_log format["%1 / %2", _dd, _details];

myClone setDammage _dd;
_count = (count _details) - 1;
for "_i" from 0 to _count do
{
	private["_detail"];
	_detail = _details select _i;
	myClone setHitPointDamage [(_detail select 0), _detail select 1];
};


*/