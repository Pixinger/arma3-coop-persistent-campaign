#pragma once

#include <string>
#include <vector>
#include <process.h>
#include "CriticalSection.h"

class Database
{
public:
	enum Modes
	{
		Nothing,
		Loading,
		Saving
	};
	enum Status
	{
		Ok,
		Error,
		InProgress
	};
private:
	Modes _Mode; // 0=nix 1=loading 2=saving
	std::string _Filename;
	std::vector<std::string>* _Vector;
	std::vector<std::string>::iterator _Iter;
	CriticalSection _CriticalSection;
	Status _Status;
	int _StatusEx;
	int _ReadIndex;
public:
	Database();
	~Database();
public:
	Database::Status IsThreadFinished();
	int BeginLoad(const char* filename);
	int BeginSave(const char* filename);
	int EndSave();
	int WriteNext(const char* text);
	int ReadNext(char* output, int outputSize);
	void Cleanup();
	int StatusEx() {return  _StatusEx;}
private:
	static void ThreadProc_Load(void* pData);
	static void ThreadProc_Save(void* pData);
	void OnThreadProc_Load();
	void OnThreadProc_Save();
	bool FileExists(const std::string & filename);
};

