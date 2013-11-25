// pixLogisticTest.cpp : Definiert den Einstiegspunkt für die Konsolenanwendung.
//

#include "stdafx.h"
#include <string>
#include <iostream>
#include <Windows.h>

typedef  void (__stdcall *RVExtensionProc)(char *output, int outputSize, const char *function);

int _tmain(int argc, _TCHAR* argv[])
{
	HMODULE handle = LoadLibrary("pixLogistic.dll");  

    if (handle)
    {
        std::cout<< "DLL loaded!" << std::endl;
        RVExtensionProc proc = (RVExtensionProc)GetProcAddress(handle, "_RVExtension@12");
		if (proc)
		{
			DWORD tick = GetTickCount();
			char output[4096];
			proc(output, 4096, "BeginSave,d:\\test.txt");
			for (int i = 0; i < 100000; i++)
				proc(output, 4096, "WriteNext,[1,2,3dlaskjdlkajsldjalskjdlajksdljklasjdljasdhweifhiuhkfjasdkfka]");
			proc(output, 4096, "WriteNext,[Ende]");
			proc(output, 4096, "EndSave");
			proc(output, 4096, "IsThreadFinished");
			while (strcmp(output, "OK") != 0)
			{
				std::cout << "IsThreadFinished: " << output << std::endl;
				proc(output, 4096, "IsThreadFinished") ;
			}
			tick = GetTickCount() - tick;
			std::cout << "IsThreadFinished: " << output << " time: " << tick << "ms" <<std::endl;			
		}
		else    
		{  
			std::cout<< "Proc failed to load!" << std::endl;  
		}  
	}
	else    
	{  
		std::cout<< "DLL failed to load!" << std::endl;  
	}  
		
	FreeLibrary (handle);  
	return 0;
}

