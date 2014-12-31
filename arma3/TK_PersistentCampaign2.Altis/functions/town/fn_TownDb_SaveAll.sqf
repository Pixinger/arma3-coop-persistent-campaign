/*
Diese Funktion speichert die Daten der Städte in der XML Datei.
 
Parameter:

Return: 
	true/false
*/

private["_result"];
_result = false;

if (isServer) then
{

	private["_dbResult"];	
	_dbResult = "Arma2NET" callExtension format["PC town,save,%1", _townName];
	if ("Arma2NET" callExtension format["PC isok,%1", _dbResult] != "OK") then
	{
		diag_log format["ERROR: Town.Save failed: %1", _dbResult];
	}
	else
	{
		diag_log "Town.Save successfull";
		_result = true;

		// Param
		// Code/Function
		// Target
		//    Object - function will be executed only where unit is local [default: everyone] 
		//    Array - array of objects 
		//    Boolean - true to execute on each machine (including the one where the function was called from), false to execute it on server only 
		//    Number - function will be executed only on client with the given owner ID 
		//    Side - function will be executed only on clients where the player is on the specified side 
		//    Group - function will be executed only on clients where the player is in the specified group 
		// IsPersistent
		// IsCall 
		[[], "hint 'Town-Datenbank gespeichert'", true] call BIS_fnc_MP;
	};
};

_result;