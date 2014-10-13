// pixBridge.cpp : Definiert die exportierten Funktionen für die DLL-Anwendung.
//

#include "stdafx.h"
#include "Database.h"

#define PIXLOGISTIC_VERSION "Version 1.1"
Database g_Database;

bool GetArgument(std::string& fnc)
{
	int index = fnc.find_first_of(",", 0);
	if (index != -1)
	{
		fnc = fnc.substr(index + 1, fnc.length() - index - 1);
		return true;
	}
	else 
		return false;
}

extern "C"
{ 
	__declspec (dllexport) void __stdcall RVExtension(char *output, int outputSize, const char *function); 
} 


void __stdcall RVExtension(char *output, int outputSize, const char *function) 
{ 
	std::string fnc(function);
	std::string fncBeginSave("BeginSave");
	std::string fncEndSave("EndSave");
	std::string fncWriteNext("WriteNext");
	std::string fncBeginLoad("BeginLoad");
	std::string fncReadNext("ReadNext");
	std::string fncIsThreadFinished("IsThreadFinished");
	std::string fncVersion("Version");
	std::string fncCleanup("Cleanup");

	// fncBeginSave
	if (fnc.compare(0, fncBeginSave.length(), fncBeginSave) == 0)
	{
		if (GetArgument(fnc))
		{
			int result = g_Database.BeginSave(fnc.c_str());
			if (result == 0)
				strncpy_s(output, outputSize, "OK", _TRUNCATE); 
			else
			{
				std::stringstream msg;
				msg << "ERROR: g_Database.BeginSave failed. code(" << result << ")";
				strncpy_s(output, outputSize, msg.str().c_str(), _TRUNCATE); 			
			}
		}
		else
			strncpy_s(output, outputSize, "ERROR: Unable to get arguments", _TRUNCATE); 
	}

	// fncEndSave
	else if (fnc.compare(0, fncEndSave.length(), fncEndSave) == 0)
	{
		int result = g_Database.EndSave();
		if (result == 0)
			strncpy_s(output, outputSize, "OK", _TRUNCATE); 
		else
		{
			std::stringstream msg;
			msg << "ERROR: g_Database.EndSave failed. code(" << result << ")";
			strncpy_s(output, outputSize, msg.str().c_str(), _TRUNCATE); 			
		}
	}

	// fncWriteNext
	else if (fnc.compare(0, fncWriteNext.length(), fncWriteNext) == 0)
	{
		if (GetArgument(fnc))
		{
			int result = g_Database.WriteNext(fnc.c_str());
			if (result == 0)
				strncpy_s(output, outputSize, "OK", _TRUNCATE); 
			else
			{
				std::stringstream msg;
				msg << "ERROR: g_Database.WriteNext failed. code(" << result << ")";
				strncpy_s(output, outputSize, msg.str().c_str(), _TRUNCATE); 			
			}
		}
		else
			strncpy_s(output, outputSize, "ERROR: Unable to get arguments", _TRUNCATE); 
	}

	// fncBeginLoad
	else if (fnc.compare(0, fncBeginLoad.length(), fncBeginLoad) == 0)
	{
		if (GetArgument(fnc))
		{
			int result = g_Database.BeginLoad(fnc.c_str());
			if (result == 0)
				strncpy_s(output, outputSize, "OK", _TRUNCATE); 
			else
			{
				std::stringstream msg;
				msg << "ERROR: g_Database.BeginLoad failed. code(" << result << ")";
				strncpy_s(output, outputSize, msg.str().c_str(), _TRUNCATE); 			
			}
		}
		else
			strncpy_s(output, outputSize, "ERROR: Unable to get arguments", _TRUNCATE); 
	}

	// fncReadNext
	else if (fnc.compare(0, fncReadNext.length(), fncReadNext) == 0)
	{
		g_Database.ReadNext(output, outputSize);
	}

	// fncIsThreadFinished
	else if (fnc.compare(0, fncIsThreadFinished.length(), fncIsThreadFinished) == 0)
	{
		if (g_Database.IsThreadFinished() == Database::Status::Ok)
			strncpy_s(output, outputSize, "OK", _TRUNCATE); 
		else if (g_Database.IsThreadFinished() == Database::Status::InProgress)
			strncpy_s(output, outputSize, "INPROGRESS", _TRUNCATE); 
		else 
		{
			strncpy_s(output, outputSize, "ERROR", _TRUNCATE); 
		}
	}

	// fncVersion
	else if (fnc.compare(0, fncVersion.length(), fncVersion) == 0)
		strncpy_s(output, outputSize, PIXLOGISTIC_VERSION, _TRUNCATE); 
	
	// fncCleanup
	else if (fnc.compare(0, fncCleanup.length(), fncCleanup) == 0)
	{
		g_Database.Cleanup();
		strncpy_s(output, outputSize, "OK", _TRUNCATE);
	}
	
	// Unknown command
	else
	{
		std::stringstream msg;
		msg << "ERROR: Unknown command:" << fnc.c_str() << ")";
		strncpy_s(output, outputSize, msg.str().c_str(), _TRUNCATE); 
	}
}


