// Executed locally when player respawns in a multiplayer mission. This will also fire at the beginning of a mission, you can use isNull on the oldUnit to check if it is the beginning of the mission. 
// [<newUnit>, <oldUnit>, <respawn>, <respawnDelay>]
/*
Sleep 0.5;

private["_position"];
_position = (getPos MobileSpawn) findEmptyPosition [5, 50, (typeof player)];
if (count _position > 0) then
{
	player setPos _position;
}
else
{
	player setPos (getPos MobileSpawn);
};*/