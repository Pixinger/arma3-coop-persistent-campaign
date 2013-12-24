/* PixRevive is massively based on Farooq's Revive 1.4d */
/* It was rewritten by Pixinger due to incompatibility to the switchUnit command */
if (!isServer || !isDedicated) then
{
	call compile preprocessFileLineNumbers "pixRevive\config.sqf";
	
	fnEH_HandleDamage = compile preprocessFileLineNumbers "pixRevive\fnEH_HandleDamage.sqf";
	fnEH_Respawn = compile preprocessFileLineNumbers "pixRevive\fnEH_Respawn.sqf";
	fnCanDrag = compile preprocessFileLineNumbers "pixRevive\fnCanDrag.sqf";
	fnCanRevive = compile preprocessFileLineNumbers "pixRevive\fnCanRevive.sqf";
	fnCanSuicide = compile preprocessFileLineNumbers "pixRevive\fnCanSuicide.sqf";
	
	pixRevive_IsDragging = false;
	
	"pvehPixReviveDragging" addPublicVariableEventHandler 
	{
		pvehPixReviveDragging setDir 180;
		pvehPixReviveDragging = 0;
	};	
	
	private["_tmp"];
	_tmp = [] execVM "pixRevive\run.sqf";	
};