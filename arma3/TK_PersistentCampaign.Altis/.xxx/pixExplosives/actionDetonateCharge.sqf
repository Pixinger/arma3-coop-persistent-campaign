/* _this variable is: [target, caller, ID, arguments]  */

private["_target"];
_target = (_this select 0);
private["_argument"];
_argument = (_this select 3);
private["_charge"];
_charge = _argument select 0;
private["_target"];
_target = _argument select 1;
player removeAction (_this select 2); 
//detach _charge; 
_charge setDamage 1;
_target allowDamage true;
_target setDamage 1;
