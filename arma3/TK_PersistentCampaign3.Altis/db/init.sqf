if (isServer) then  
{
	call compile preprocessFileLineNumbers ("db\"+ dbType +"\init.sqf");
};