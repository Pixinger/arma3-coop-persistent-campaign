#include "StdAfx.h"
#include "Database.h"

void Database::ThreadProc_Load(void* pData)
{
	reinterpret_cast<Database*>(pData)->OnThreadProc_Load();
}
void Database::ThreadProc_Save(void* pData)
{
	reinterpret_cast<Database*>(pData)->OnThreadProc_Save();
}

Database::Database()
{
	_Mode = Modes::Nothing;
	_Status = Status::Ok;
}
Database::~Database()
{
	if (_Vector != NULL)
	{
		delete _Vector;
		_Vector = NULL;
	}
}

bool Database::FileExists(const std::string & filename)
{
    return( (GetFileAttributes(filename.c_str()) == INVALID_FILE_ATTRIBUTES)
            ? false  //lesen nicht möglich -> Datei existiert nicht!
            : true); //die Datei existiert
}

Database::Status Database::IsThreadFinished()
{
	return _Status;
}
int Database::BeginLoad(const char* filename)
{
	AutoLock lock(&_CriticalSection);
	
	if (_Mode != Modes::Nothing)
		return 1;
	if (_Status == Status::InProgress)
		return 2;

	_Filename = filename;
	_Mode = Modes::Loading;
	_Status = Status::InProgress;
	_ReadIndex = -1;
	_beginthread(Database::ThreadProc_Load, 0, this);
	
	return 0;
}
int Database::BeginSave(const char* filename)
{
	AutoLock lock(&_CriticalSection);

	if (_Mode != Modes::Nothing)
		return 1;
	if (_Status == Status::InProgress)
		return 2;

	_Filename = filename;
	_Mode = Modes::Saving;
	_Status = Status::Ok;
	_Vector = new std::vector<std::string>();

	return 0;
}
int Database::EndSave()
{
	AutoLock lock(&_CriticalSection);
	
	if (_Mode != Modes::Saving)
		return 1;
	if (_Status == Status::InProgress)
		return 2;
	
	_Status = Status::InProgress;
	_beginthread(Database::ThreadProc_Save, 0, this);

	return 0;
}
int Database::WriteNext(const char* text)
{
	AutoLock lock(&_CriticalSection);
	
	if (_Mode != Modes::Saving)
		return 1;
	if (_Status != Status::Ok)
		return 2;

	_Vector->push_back(text);

	return 0;
}
int Database::ReadNext(char* output, int outputSize)
{
	AutoLock lock(&_CriticalSection);
	
	if (_Mode != Modes::Loading)
	{
		strncpy_s(output, outputSize, "EOF", _TRUNCATE);
		return 1;
	}
	if (_Status != Status::Ok)
	{
		strncpy_s(output, outputSize, "EOF", _TRUNCATE);
		return 2;
	}

	if (_Iter != _Vector->end())
	{
		strncpy_s(output, outputSize, (*_Iter).c_str(), _TRUNCATE); 
		++_Iter;
	}
	else
	{
		strncpy_s(output, outputSize, "EOF", _TRUNCATE); 
		if (_Vector != NULL)
		{
			delete _Vector;
			_Vector = NULL;
		}
		_Mode = Modes::Nothing;
	}

	return 0;
}
void Database::Cleanup()
{
	// Diese Methode räumt brutal auf. Nur eine Notlösung!
	_Mode = Modes::Nothing;
	_Status = Status::Ok;
	if (_Vector != NULL)
	{
		delete _Vector;
		_Vector = NULL;
	}
}
void Database::OnThreadProc_Load()
{
	if (!FileExists(_Filename))
	{
		_Vector = new std::vector<std::string>();
		_Iter = _Vector->begin();
		_CriticalSection.Enter();
		_Status = Status::Ok;
		_CriticalSection.Leave();
	}
	else
	{
		 std::ifstream file (_Filename.c_str(), std::ifstream::in);
		_Filename = "";
		if (file.is_open())
		{
			std::string line;
			_Vector = new std::vector<std::string>();
			while ( std::getline (file, line) )
			{
				_Vector->push_back(line);
			}
			file.close();
			_Iter = _Vector->begin();
			_CriticalSection.Enter();
			_Status = Status::Ok;
			_CriticalSection.Leave();
		}
		else
		{
			_CriticalSection.Enter();
			_Status = Status::Error;
			_CriticalSection.Leave();
		}
	}
}
void Database::OnThreadProc_Save()
{
	// Daten auf die Festplatte schreiben
	char tmpFilename[1024];
	tmpnam_s(tmpFilename, 1024);
	std::ofstream file(tmpFilename, std::ios_base::trunc);
	if (!file.fail())
	{
		for (std::vector<std::string>::iterator iter = _Vector->begin(); iter != _Vector->end(); iter++)
			file << (*iter).c_str() << std::endl;
		file.close();

		if (FileExists(_Filename))
			remove(_Filename.c_str());
		rename(tmpFilename, _Filename.c_str());

		_Filename = "";
		if (_Vector != NULL)
		{
			delete _Vector;
			_Vector = NULL;
		}

		_CriticalSection.Enter();
		_Status = Status::Ok;
		_Mode = Modes::Nothing;
		_CriticalSection.Leave();
	}
	else
	{
		_Filename = "";
		if (_Vector != NULL)
		{
			delete _Vector;
			_Vector = NULL;
		}

		_CriticalSection.Enter();
		_Status = Status::Error;
		_Mode = Modes::Nothing;
		_CriticalSection.Leave();
	}
}