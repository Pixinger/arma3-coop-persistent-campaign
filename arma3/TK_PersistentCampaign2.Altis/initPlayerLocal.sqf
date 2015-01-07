// Executed locally when player joins mission (includes both mission start and JIP). See initialization order for details about when the script is exactly executed. 
// [player:Object, didJIP:Boolean]
if (local player) then
{
	[player, "default.sqf"] call compile preprocessFileLineNumbers "barracks\applyLoadOut.sqf";
};