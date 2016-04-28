if (!hasInterface && !isServer) then 
{
	// Wird nur aufgerufen, wenn es KEIN Interfacae hat UND KEIN Server ist (also nur auf dem HeadlessClient).
	HeadlessClientAvailable = true;
	publicVariable "HeadlessClientAvailable";
};