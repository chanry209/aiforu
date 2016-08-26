
// The following ifdef block is the standard way of creating macros which make exporting 
// from a DLL simpler. All files within this DLL are compiled with the MAVISION_EXPORTS
// symbol defined on the command line. this symbol should not be defined on any project
// that uses this DLL. This way any other project whose source files include this file see 
// MAVISION_API functions as being imported from a DLL, wheras this DLL sees symbols
// defined with this macro as being exported.
#ifdef MAVISION_EXPORTS
#define MAVISIONAPI extern "C" __declspec(dllexport)
#else
#define MAVISIONAPI extern "C" __declspec(dllimport)
#endif

// ��ɫ��ʽ
#define CLFM_Y8		1
#define CLFM_RGB16	2
#define CLFM_RGB24	3
#define CLFM_RGB32	4

// ��Ƶ��ʽ
#define VIFM_NTSC	0
#define VIFM_PAL	1

// ͨ��ѡ��
#define CHANNEL_0	 1
#define CHANNEL_1	 2
#define CHANNEL_2	 4
#define CHANNEL_3	 8

typedef void (CALLBACK * GRABPROCESS )( DWORD, WORD );

/**************ϵͳ*****************/

// ��ʼ��ͼ��
MAVISIONAPI short MAInitial( WORD Port );
// �ر�ͼ��
MAVISIONAPI short MAClose( WORD Port );
// ����
MAVISIONAPI short MAReset( WORD Port );

/***************����****************/

// ������ɫ��ʽ
MAVISIONAPI short MASetColorFormat( WORD Port, BYTE ColorFormat );
// ��ȡ��ɫ��ʽ
MAVISIONAPI short MAGetColorFormat( WORD Port, BYTE *ColorFormat );
// ������Ƶ��ʽ
MAVISIONAPI short MASetVideoFormat( WORD Port, BYTE VideoFormat );
// ��ȡ��Ƶ��ʽ
MAVISIONAPI short MAGetVideoFormat( WORD Port, BYTE *VideoFormat );
// �������ȡ��Աȶȡ���
MAVISIONAPI short MASetImageConfig( WORD Port, BYTE Index, BYTE Value );
// ��ȡ���ȡ��Աȶȡ���
MAVISIONAPI short MAGetImageConfig( WORD Port, BYTE Index, BYTE* Value );
// ����ͼ�񡭡�
MAVISIONAPI short MASetImageGeometric( WORD Port, DWORD X_Offset, DWORD Y_Offset, DWORD X_Active, DWORD Y_Active, double X_Scale,double Y_Scale );

// ��ȡͼ����Ϣ����
MAVISIONAPI VOID MAGetImageInfo( WORD Port, DWORD* BitCount, DWORD* Width, DWORD* Height );

/***************����****************/

// ��ʼ�ɼ�
MAVISIONAPI short MAStart( WORD Port, DWORD Capture );
// ֹͣ�ɼ�
MAVISIONAPI short MAStop( WORD Port );
// ����ͨ��
MAVISIONAPI short MASelectChannel( WORD Port, WORD Channel );
// ���ò���
MAVISIONAPI short MACaptureConfig( WORD Port, WORD StartField );
// ͬ��
MAVISIONAPI short MASyncGrab( WORD Port, BYTE *pBuffer, DWORD* Width, DWORD* Height, DWORD* BufferSize );
// CALLBACK
MAVISIONAPI short MASetCallBack( WORD Port, GRABPROCESS GrabProc );

MAVISIONAPI short MASetIntEvent( WORD Port, HANDLE* hEvent );

MAVISIONAPI short MAGetIntStatus( WORD Port, DWORD* IntStatus );

/***************IO****************/

// ����IO
MAVISIONAPI short MASetGPIOStatus( WORD Port, BYTE Status );
// ��ȡIO
MAVISIONAPI short MAGetGPIOStatus( WORD Port, BYTE* Status );

MAVISIONAPI short MAWriteEEPROM( WORD Port, BYTE Address, BYTE Value );

MAVISIONAPI short MAReadEEPROM( WORD Port, BYTE Address, BYTE* Value );
//
MAVISIONAPI short MASetLEDSts( WORD Port, BYTE Status );
//
MAVISIONAPI short MASetWDT( WORD Port, WORD Enable, WORD Interval );
// Category: Software Trigger
MAVISIONAPI short MATriggerConfig( WORD Port, WORD Interval );
//
MAVISIONAPI short MATriggerStart( WORD Port, WORD Multiplex );

/***************??****************/

// ��ȡһ֡ͼ��
MAVISIONAPI short MAGetFrameData( WORD Port, BYTE *pBuffer, DWORD *Width, DWORD *Height, DWORD *BufferSize );
//
MAVISIONAPI short MACopyFrameData( WORD Port, BYTE *pBuffer, DWORD *BufferSize );
// 
MAVISIONAPI short MASaveToFile( WORD Port, char* FileName, BYTE FileFormat, int nQuality );