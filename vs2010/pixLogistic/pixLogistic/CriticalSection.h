#pragma once

#include <windows.h>

class CriticalSection
{
private:
    CRITICAL_SECTION _CriticalSection;
public:
    explicit CriticalSection(void)
    {
        if (0 == InitializeCriticalSectionAndSpinCount(&_CriticalSection, 0))
            throw("CriticalSection");
    };
    ~CriticalSection(void)
    {
        Enter();
        DeleteCriticalSection(&_CriticalSection);
    };
public: 
    void Enter(void)
    {
        EnterCriticalSection(&_CriticalSection);
    }; 
    void Leave(void)
    {
        LeaveCriticalSection(&_CriticalSection);
    }; 
    bool TryEnter(void)
    {
        return(TRUE == TryEnterCriticalSection(&_CriticalSection));
    }; 
};

class AutoLock
{
private:
    CriticalSection* _pCriticalSection;
public:
	AutoLock(CriticalSection* pCriticalSection)
	{
		_pCriticalSection = pCriticalSection;
		_pCriticalSection->Enter();
	}
	~AutoLock()
	{
		_pCriticalSection->Leave();
	}
};
