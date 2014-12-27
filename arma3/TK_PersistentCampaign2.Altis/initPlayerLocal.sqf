// Executed locally when player joins mission (includes both mission start and JIP). See initialization order for details about when the script is exactly executed. 
// [player:Object, didJIP:Boolean]
if (local player) then
{
	player addAction["beam","admin\beam.sqf"];
	player addAction["test - finger weg, sonst ab","test.sqf"];
	call compile preprocessFileLineNumbers "dialog\init.sqf";
	[] execVM "admin\gps.sqf";
};