
/************************************************************
// ���ƻ����Ӿ� ��Ȩ����(2007) 
// ģ�����ƣ�ckvision.dll
// ����ʱ�䣺2005-??-??
// �޸�ʱ�䣺2007-??-??
*************************************************************/
#ifdef CKVISION_EXPORTS
#define CKVIS_API extern "C" __declspec(dllexport)
#else
#define CKVIS_API extern "C" __declspec(dllimport)
#endif

/* Image Handle*/
typedef unsigned char* HIMAGE;	// ͼ����
/* Roi Handle*/
typedef unsigned char* HROI;	// ROI���
/* Model Handle */
typedef unsigned char* HMODEL;	// ģ����

// �ṹ����

/* Float Point */
typedef struct tagFPOINT
{
	float	x;			// x����
	float	y;			// y����
} FPOINT, *PFPOINT;

/* Float Line */
typedef struct tagFLINE
{
	FPOINT	pt1;		// ���
	FPOINT	pt2;		// �յ�
} FLINE, *PFLINE;

/* Float Rect */
typedef struct tagFRECT
{
	float	left;		// ���
	float	top;		// �ϱ�
	float	right;		// �ұ�
	float	bottom;		// �ױ�
} FRECT, *PFRECT;

/* Float RRect */
typedef struct tagFROTRECT
{
	float	angle;		// ��ת�Ƕ�
	float	left;		// ���
	float	top;		// �ϱ�
	float	right;		// �ұ�
	float	bottom;		// �ױ�
} FROTRECT, *PFROTRECT;

/* Float Round */
typedef struct tagFROUND
{
	float	cx;			// ����x
	float	cy;			// ����y
	float	radii;		// �뾶
} FROUND, *PFROUND;

/* Ftriangle �ȱ�������*/
typedef struct tagFTRIANGLE
{
	float	angle;		// ��ת�Ƕ�
	FPOINT	center;		// �����ε�����
	float	sidelen;	// �����α߳�
} FTRIANGLE, *PFTRIANGLE;

#ifndef _WINDEF_

/* int Point */
typedef struct tagPOINT
{
	int		x;			// x����
	int		y;			// y����
} POINT, *PPOINT;

/* int Rect */
typedef struct tagRECT
{
	int		left;		// ���
	int		top;		// �ϱ�
	int		right;		// �ұ�
	int		bottom;		// �ױ�
} RECT, *PRECT;

#endif

/* int Line */
typedef struct tagLINE
{
	POINT	pt1;		// ���
	POINT	pt2;		// �յ�
} LINE, *PLINE;

/* int Round */
typedef struct tagROUND
{
	int		cx;			// ����x
	int		cy;			// ����y
	int		radii;		// �뾶
} ROUND, *PROUND;

/* int DRound */
typedef struct tagDROUND
{
	int		cx;			// ����x
	int		cy;			// ����y
	int		radii1;		// ��Բ�뾶
	int		radii2;		// ��Բ�뾶
} DROUND, *DPROUND;

/* int Annulus */
typedef struct tagANNULUS
{
	int		cx;			// ����x
	int		cy;			// ����y
	int		radii1;		// ��Բ�뾶
	int		radii2;		// ��Բ�뾶
	float	angle1;		// ��ʼ�Ƕ�
	float	angle2;		// �����Ƕ�
} ANNULUS, *PANNULUS;

/* int RotateRect */
typedef struct tagROTRECT
{
	float	angle;		// ��ת�Ƕ�
	int		left;		// ���
	int		top;		// �ϱ�
	int		right;		// �ұ�
	int		bottom;		// �ױ�
} ROTRECT, *PROTRECT;

/* double - rect */
typedef struct tagDROTRECT
{
	float	angle;		// ��ת�Ƕ�
	RECT	rect1;		// �����
	RECT	rect2;		// �ھ���
} DROTRECT, *PDROTRECT;

/* triangle �ȱ�������*/
typedef struct tagTRIANGLE
{
	float	angle;		// ��ת�Ƕ�
	POINT	center;		// �����ε�����
	int		sidelen;	// �����α߳�
} TRIANGLE, *PTRIANGLE;
 
/* ����ϵͳ */
typedef struct tagCOORDINATE 
{
	double	Angle;		// �Ƕ�
	FPOINT	Point;		// ԭ��
} COORDINATE, *PCOORDINATE;


// ��ȡ������״̬
// �ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGetDogState( void );

/***************************************************************************
*--------------------------------- ͼ����ʾ -------------------------------*
****************************************************************************
*
*	������ʾһЩͼ��
*
****************************************************************************/

/************* �������� **************/

// ��������CKSetPointStyle
// ��  �ܣ�������ʾ�����ķ��
// ��  ����dStyle ���(0��1��2)
// ��  �أ��ɵķ��
CKVIS_API DWORD CKSetPointStyle( DWORD dStyle );

// ��������CKDisplayPoint
// ��  �ܣ�����Ļ����ʾһ�������
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����point ����������
CKVIS_API void CKDisplayPoint( HDC hDC, POINT* point );

// ��������CKDisplayFPoint
// ��  �ܣ�����Ļ����ʾһ������������㣬ʵ����ʾΪ����
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����point ����������������
CKVIS_API void CKDisplayFPoint( HDC hDC, FPOINT* point );

// ��������CKDisplayLine
// ��  �ܣ�����Ļ����ʾһ����
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����pLine �ߵ�����
CKVIS_API void CKDisplayLine( HDC hDC, LINE* pLine );

// ��������CKDisplayFLine
// ��  �ܣ�����Ļ����ʾһ���������ߣ�ʵ����ʾΪ����
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����pLine �������ߵ�����
CKVIS_API void CKDisplayFLine( HDC hDC, FLINE* pLine );

// ��������CKDisplayRect
// ��  �ܣ�����Ļ����ʾһ������
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����pRect ���ε�����
CKVIS_API void CKDisplayRect( HDC hDC, RECT* pRect );

// ��������CKDisplayFRect
// ��  �ܣ�����Ļ����ʾһ�����������Σ�ʵ����ʾΪ����
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����pRect ���������ε�����
CKVIS_API void CKDisplayFRect( HDC hDC, FRECT* pRect );

// ��������CKDisplayRound
// ��  �ܣ�����Ļ����ʾһ��Բ��
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����pRound Բ�ε�����
CKVIS_API void CKDisplayRound( HDC hDC, ROUND* pRound );

// ��������CKDisplayFRound
// ��  �ܣ�����Ļ����ʾһ��������Բ�Σ�ʵ����ʾΪ����
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����pRound ������Բ�ε�����
CKVIS_API void CKDisplayFRound( HDC hDC, FROUND* pRound );

// ��������CKDisplayDRound
// ��  �ܣ�����Ļ����ʾһ��˫Բ��
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����pDRound ˫Բ�ε�����
CKVIS_API void CKDisplayDRound( HDC hDC, DROUND* pDRound );

// ��������CKDisplayAnnulus
// ��  �ܣ�����Ļ����ʾһ������
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����pAnnulus ���ε�����
CKVIS_API void CKDisplayAnnulus( HDC hDC, ANNULUS* pAnnulus );

// ��������CKDisplayRotRect
// ��  �ܣ�����Ļ����ʾһ�����нǶȵľ���
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����pRRect ���нǶȵľ��ε�����
CKVIS_API void CKDisplayRotRect( HDC hDC, ROTRECT* pRRect );

// ��������CKDisplayFRotRect
// ��  �ܣ�����Ļ����ʾһ�����������нǶȵľ���
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����pRRect ���������нǶȵľ��ε�����
CKVIS_API void CKDisplayFRotRect( HDC hDC, FROTRECT* pRRect );

// ��������CKDisplayTriangle
// ��  �ܣ�����Ļ����ʾһ��������
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����pTriangle ����������
CKVIS_API void CKDisplayTriangle( HDC hDC, TRIANGLE* pTriangle );

// ��������CKDisplayArrowhead
// ��  �ܣ�����Ļ����ʾһ����ϵ
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����point1 ԭ������
// ��  ����point2 �յ�����
CKVIS_API void CKDisplayArrowhead( HDC hDC, POINT* point1, POINT* point2 );

// ��������CKDisplayCoordinate
// ��  �ܣ�����Ļ����ʾһ����ϵ
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����pCoordinate ����ϵ����
CKVIS_API void CKDisplayCoordinate( HDC hDC, COORDINATE* pCoordinate );





/***************************************************************************
*---------------------------------- ROI���� -------------------------------*
****************************************************************************
*
*	ROI - ����Ȥ����
*
****************************************************************************/

/*************** �궨�� *****************/

// RoiType - ROI����
#define ROI_NULL			0	// NULL
#define ROI_LINE			1	// ����ROI
#define ROI_RECT			2	// ����ROI
#define ROI_ROTRECT			3	// ����ת����ROI
#define ROI_DROTRECT		4	// ����ת˫����ROI
#define ROI_ROUND			5	// Բ��ROI
#define ROI_DROUND			6	// ˫Բ��ROI
#define ROI_ANNULUS			7	// Բ����ROI

/************* �������� **************/

// ��������CKCreateRoi
// ��  �ܣ�����һ��ROI(����Ȥ������λ��)
// ��  ����Type ����ROI������
// ��  �أ��ɹ�����ROI���ݾ�������򷵻�NULL
CKVIS_API HROI CKCreateRoi( int Type );

// ��������CKSetRoi
// ��  �ܣ������������������ROI����ͬ��ROI����Ч����ͬ����Ҫ�����������ROI�����
// ��  ����hRoi ��Ҫ���е�����ROI���
// ��  ����x1 ��һ��������x��
// ��  ����y1 ��һ��������y��
// ��  ����x2 �ڶ���������x��
// ��  ����y2 �ڶ���������y��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKSetRoi( HROI hRoi, int x1, int y1, int x2, int y2 );

// ��������CKGetRoiNode
// ��  �ܣ���ȡROI�ĵ��ڵ�����ֵ����ͬ��ROI��������ֵ��ͬ����Ҫ�����������ROI�����
// ��  ����hRoi ��ȡ���ڵ��ROI���
// ��  ����x ��ǰ���������x��
// ��  ����y ��ǰ���������y��
// ��  �أ������ǰ����ROI��ĳ�����ڵ��ڣ��򷵻ظõ��ڵ������ֵ�����򷵻�NULL
CKVIS_API int CKGetRoiNode( HROI hRoi, int x, int y );
 
// ��������CKAdjustRoi
// ��  �ܣ����ݵ��ڵ������ֵ����ROI����Ӧλ�ý��е�������Ҫ�����������ROI�����
// ��  ����hRoi ��Ҫ���е�����ROI���
// ��  ����Node ���ڵ������ֵ
// ��  ����x ��ǰ���������x��
// ��  ����y ��ǰ���������y��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKAdjustRoi( HROI hRoi, int Node, int x, int y );

// ��������CKSetRoiCursor
// ��  �ܣ�����ROI�Ĺ�꣬�����λ�ڲ�ͬ�ĵ��ڵ�������ͬ�Ĺ����״
// ��  ����hRoi ROI���
// ��  ����Node ���ڵ������ֵ
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKSetRoiCursor( HROI hRoi, int Node );

// ��������CKCopyRoi
// ��  �ܣ�����һ��ROI
// ��  ����hRoi ԴROI���
// ��  �أ��ɹ�����һ����ROI�Ŀ��������򷵻�NULL
CKVIS_API HROI CKCopyRoi( HROI hRoi );

// ��������CKGetRoiType
// ��  �ܣ���ȡROI������
// ��  ����hRoi ROI���
// ��  �أ��ɹ����ظ�ROI�����ͣ����򷵻�NULL
CKVIS_API int CKGetRoiType( HROI hRoi );

// ��������CKFreeRoi
// ��  �ܣ��ͷ�һ��ROI���ڴ�
// ��  ����hRoi ROI���
CKVIS_API void CKFreeRoi( HROI hRoi );

// ��������CKMoveRoi
// ��  �ܣ��ƶ�ROI
// ��  ����hRoi ��Ҫ�ƶ���ROI���
// ��  ����x x������ƶ�ƫ����
// ��  ����y y������ƶ�ƫ����
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKMoveRoi( HROI hRoi, int x, int y );

// ��������CKScalingRoi
// ��  �ܣ���ROI��������
// ��  ����hRoi ��Ҫ�������ŵ�ROI���
// ��  ����Scale ���ű���
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKScalingRoi( HROI hRoi, double Scale );

// ��������CKTransformRoi
// ��  �ܣ�ת��ROI�Ŀռ�����ϵ����Ҫ���ڶ�λ���������ϵʵʱת��
// ��  ����hRoi ��Ҫ����ת����ROI���
// ��  ����pOldCoord �ɵġ���ǰ���ڵ�����ϵ
// ��  ����pNewCoord �µġ���Ҫת����������ϵ
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKTransformRoi( HROI hRoi, COORDINATE* pOldCoord, COORDINATE* pNewCoord );

// ��������CKTransformPoint
// ��  �ܣ�ת��һ�������Ŀռ�����ϵ
// ��  ����point ָ��FPOINT�͵�ָ��
// ��  ����pOldCoord �ɵġ���ǰ���ڵ�����ϵ
// ��  ����pNewCoord �µġ���Ҫת����������ϵ
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKTransformPoint( FPOINT* point, COORDINATE* pOldCoord, COORDINATE* pNewCoord );

// ��������CKDisplayRoi
// ��  �ܣ�����Ļ����ʾһ��ROI
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����hRoi ��Ҫ��ʾ��ROI���
// ��  ����Color ��ʾROI����ɫ
CKVIS_API void CKDisplayRoi( HDC hDC, HROI hRoi, int Color );

// ��������CKDisplayRoiNode
// ��  �ܣ�����Ļ����ʾһ��ROI�����е��ڵ�
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����hRoi ��Ҫ��ʾ��ROI���
// ��  ����Color ��ʾ���ڵ����ɫ
CKVIS_API void CKDisplayRoiNode( HDC hDC, HROI hRoi, int Color );

// ��������CKDisplayRoiSign
// ��  �ܣ���ROI������ʾһ���ַ���ǩ
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����hRoi ��Ҫ��ʾ��ROI���
// ��  ����lpszSign ��ǩ�ַ���
CKVIS_API void CKDisplayRoiSign( HDC hDC, HROI hRoi, LPCSTR lpszSign );

// ��������CKGetRoiFrame
// ��  �ܣ���ȡROI��RECT
// ��  ����hRoi ��Ҫ��ʾ��ROI���
// ��  ����rect ���ص�RECT����
// ��  �أ��ɹ�����һ��TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGetRoiFrame( HROI hRoi, RECT& rect );

// ��������CKLineToRoi
// ��  �ܣ���һ��LINE��ָ��ת��Ϊһ��ROI
// ��  ����pLine ָ��LINE��ָ��
// ��  �أ��ɹ�����һ������ROI��������򷵻�NULL
CKVIS_API HROI CKLineToRoi( LINE* pLine );

// ��������CKRectToRoi
// ��  �ܣ���һ��RECT��ָ��ת��Ϊһ��ROI
// ��  ����pRect ָ��RECT��ָ��
// ��  �أ��ɹ�����һ������ROI��������򷵻�NULL
CKVIS_API HROI CKRectToRoi( RECT* pRect );

// ��������CKRoundToRoi
// ��  �ܣ���һ��ROUND��ָ��ת��Ϊһ��ROI
// ��  ����pRound ָ��ROUND��ָ��
// ��  �أ��ɹ�����һ��Բ��ROI��������򷵻�NULL
CKVIS_API HROI CKRoundToRoi( ROUND* pRound );

// ��������CKDRoundToRoi
// ��  �ܣ���һ��DROUND��ָ��ת��Ϊһ��ROI
// ��  ����pDRound ָ��DROUND��ָ��
// ��  �أ��ɹ�����һ��˫Բ��ROI��������򷵻�NULL
CKVIS_API HROI CKDRoundToRoi( DROUND* pDRound );

// ��������CKAnnulusToRoi
// ��  �ܣ���һ��ANNULUS��ָ��ת��Ϊһ��ROI
// ��  ����pAnnulus ָ��ANNULUS��ָ��
// ��  �أ��ɹ�����һ��Բ����ROI��������򷵻�NULL
CKVIS_API HROI CKAnnulusToRoi( ANNULUS* pAnnulus );

// ��������CKRotRectToRoi
// ��  �ܣ���һ��ROTRECT��ָ��ת��Ϊһ��ROI
// ��  ����pRotRect ָ��ROTRECT��ָ��
// ��  �أ��ɹ�����һ������ת����ROI��������򷵻�NULL
CKVIS_API HROI CKRotRectToRoi( ROTRECT* pRotRect );

// ��������CKGetLine
// ��  �ܣ�����ROI���ڲ����ݣ�ROI���ͱ���Ϊ���Σ������ʧ��
// ��  ����hRoi ��Ҫ������ROI���
// ��  �أ��ɹ�����ָ���ROI�ڲ�����������ָ�룬���򷵻�NULL		
CKVIS_API LINE* CKGetLine( HROI hRoi );

// ��������CKGetRect
// ��  �ܣ�����ROI���ڲ����ݣ�ROI���ͱ���Ϊ���Σ������ʧ��
// ��  ����hRoi ��Ҫ������ROI���
// ��  �أ��ɹ�����ָ���ROI�ڲ��ľ�������ָ�룬���򷵻�NULL
CKVIS_API RECT* CKGetRect( HROI hRoi );

// ��������CKGetRound
// ��  �ܣ�����ROI���ڲ����ݣ�ROI���ͱ���ΪԲ�Σ������ʧ��
// ��  ����hRoi ��Ҫ������ROI���
// ��  �أ��ɹ�����ָ���ROI�ڲ���Բ������ָ�룬���򷵻�NULL		
CKVIS_API ROUND* CKGetRound( HROI hRoi );

// ��������CKGetDRound
// ��  �ܣ�����ROI���ڲ����ݣ�ROI���ͱ���Ϊ˫Բ�Σ������ʧ��
// ��  ����hRoi ��Ҫ������ROI���
// ��  �أ��ɹ�����ָ���ROI�ڲ���˫Բ������ָ�룬���򷵻�NULL		
CKVIS_API DROUND* CKGetDRound( HROI hRoi );

// ��������CKGetAnnulus
// ��  �ܣ�����ROI���ڲ����ݣ�ROI���ͱ���Ϊ���Σ������ʧ��
// ��  ����hRoi ��Ҫ������ROI���
// ��  �أ��ɹ�����ָ���ROI�ڲ���Բ������ָ�룬���򷵻�NULL		
CKVIS_API ANNULUS* CKGetAnnulus( HROI hRoi );

// ��������CKGetRotRect
// ��  �ܣ�����ROI���ڲ����ݣ�ROI���ͱ���Ϊ�нǶȾ��Σ������ʧ��
// ��  ����hRoi ��Ҫ������ROI���
// ��  �أ��ɹ�����ָ���ROI�ڲ����нǶȾ�������ָ�룬���򷵻�NULL
CKVIS_API ROTRECT* CKGetRotRect( HROI hRoi );





/***************************************************************************
*--------------------------------- ͼ������ -------------------------------*
****************************************************************************
*
*	ͼ�����ݴ������ʾ
*
****************************************************************************/

/*************** �궨�� ***************/

// BitCount - ͼ������
#define IMAGE_GRAY			8		// 8λ�Ҷ�ͼ��
#define IMAGE_COLOR			24		// 24Ϊ��ɫͼ��

// CKThresholdRgbQuad - Modality
#define THOLD_R_HIGH		0x01
#define THOLD_G_HIGH		0x02
#define THOLD_B_HIGH		0x04
#define THOLD_R_LOW			0x08
#define THOLD_G_LOW			0x10
#define THOLD_B_LOW			0x20

/************* �������� **************/

// ��������CKCreateImage
// ��  �ܣ�����һ��ͼ����
// ��  ����pData ָ��ͼ�����ݻ��������׵�ַָ�룬����ΪNULL(ȫ������Ϊ��ɫ)
// ��  ����BitCount ͼ���λ����һ����8��16��24��32����������ݻ�������λ����Ӧ��
// ��  ����Width ͼ��Ŀ�ȣ���������ݻ�������λ����Ӧ��
// ��  ����Height ͼ��ĸ߶ȣ���������ݻ�������λ����Ӧ��
// ��  �أ��ɹ�����һ����Ч��ͼ���������򷵻�NULL		
CKVIS_API HIMAGE CKCreateImage( BYTE* pData, int BitCount, int Width, int Height );

// ��������CKGetImageInfo
// ��  �ܣ���ȡͼ��������Ϣ��λ������ȡ��߶�
// ��  ����hImage ��Ҫ��ȡ��Ϣ��ͼ����
// ��  ����BitCount ����ͼ���λ��������Ҫ����ΪNULL
// ��  ����Width ����ͼ��Ŀ�ȣ�����Ҫ����ΪNULL
// ��  ����Height ����ͼ��ĸ߶ȣ�����Ҫ����ΪNULL
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE		
CKVIS_API BOOL CKGetImageInfo( HIMAGE hImage, int* BitCount, int* Width, int* Height );

// ��������CKCopyImage
// ��  �ܣ�����ͼ����
// ��  ����hImage ��Ҫ���Ƶ�Դͼ����
// ��  �أ��ɹ����ظ�ͼ������һ�����������򷵻�NULL		
CKVIS_API HIMAGE CKCopyImage( HIMAGE hImage );

// ��������CKReplaceImage
// ��  �ܣ����µ�ͼ�������滻Ŀ��ͼ�����ݣ�����ͼ���λ������Ⱥ͸߶ȱ���һ��
// ��  ����hSource ��Դͼ����������ͼ��
// ��  ����hDest Ŀ��ͼ���������ͼ��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKReplaceImage( HIMAGE hSource, HIMAGE hDest );

// ��������CKReplaceImageFromMask
// ��  �ܣ����µ�ͼ�������滻Ŀ��ͼ�����ݣ�����ͼ���λ������Ⱥ͸߶ȱ���һ��
// ��  ����hSource ��Դͼ����������ͼ��
// ��  ����hDest Ŀ��ͼ���������ͼ��
// ��  ����hMask ����ͼ��ֻ�滻��ͼ��ĵ�ǰֵ�����������
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKReplaceImageFromMask( HIMAGE hSource, HIMAGE hDest, HIMAGE hMask );

// ��������CKSetImageBuffer
// ��  �ܣ�����ͼ�����ݣ���pData�����ݸ��Ƶ�hImage��ȥ
// ��  ����hImage ��Ҫ�������ݵ�ͼ����
// ��  ����pData ָ��ͼ�����ݻ��������׵�ַָ��
CKVIS_API void CKSetImageBuffer( HIMAGE hImage, BYTE* pData );

// ��������CKSetImageBuffer2
// ��  �ܣ�����ͼ�����ݣ���pData�����ݸ��Ƶ�hImage��ȥ
// ��  ����hImage ��Ҫ�������ݵ�ͼ����
// ��  ����pData ָ��ͼ�����ݻ��������׵�ַָ��
CKVIS_API void CKSetImageBuffer2( HIMAGE hImage, BYTE* pData );

// ��������CKGetImageBuffer
// ��  �ܣ���ȡͼ������ݣ���hImage�����ݸ��Ƶ�pData��ȥ
// ��  ����hImage ��Ҫ��ȡ���ݵ�ͼ����
// ��  ����pData �������Ѿ�����õ�һ���ڴ����򣬴�С��hImageһ��
CKVIS_API void CKGetImageBuffer( HIMAGE hImage, BYTE* pData );

// ��������CKFreeImage
// ��  �ܣ��ͷ�ͼ����ڴ�
// ��  ����hImage ��Ҫ�ͷŵ�ͼ����
CKVIS_API void CKFreeImage( HIMAGE hImage );

// ��������CKFreeImage
// ��  �ܣ��ͷ��ڴ�
// ��  ����pMemory ָ����Ҫ�ͷŵ��ڴ���׵�ַ
CKVIS_API void CKFreeMemory( void* pMemory );

// ��������CKReadBMPFile
// ��  �ܣ����ļ���ȡһ��BMPͼƬ
// ��  ����pszFileName �ļ�ȫ·����
// ��  �أ��ɹ�����һ��ͼ���������򷵻�NULL
CKVIS_API HIMAGE CKReadBMPFile( LPCSTR pszFileName );		

// ��������CKWriteBMPFile
// ��  �ܣ���BMP��ʽ����һ��ͼƬ
// ��  ����pszFileName �ļ�ȫ·����
// ��  ����hImage ͼ����
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKWriteBMPFile( LPCSTR pszFileName, HIMAGE hImage );

// ��������CKSetRgbQuad
// ��  �ܣ��ı�ͼ�����ɫ�����Խ���α��ɫ��ʾ��ֻ������8λͼ
// ��  ����pRgbQuad 8λͼ�����ɫ����СΪ256��NULLΪĬ��ʹ��256���Ҷȵ���ɫ��
CKVIS_API void CKSetRgbQuad( RGBQUAD* pRgbQuad );

// ��������CKGetRgbQuad
// ��  �ܣ���ȡͼ�����ɫ��ֻ������8λͼ
// ��  ����pRgbQuad 8λͼ�����ɫ����СΪ256
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGetRgbQuad( RGBQUAD* pRgbQuad );

// ��������CKDisplayImage
// ��  �ܣ�������ʾһ��ͼ��
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����hImage ͼ����
// ��  ����x ��ʾͼ������Ͻ�x����
// ��  ����y ��ʾͼ������Ͻ�y����
CKVIS_API void CKDisplayImage( HDC hDC, HIMAGE hImage, int x, int y );

// ��������CKDisplayImageEx
// ��  �ܣ��Ŵ����С��ʾһ��ͼ��
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����hImage ͼ����
// ��  ����x ��ʾͼ������Ͻ�x����
// ��  ����y ��ʾͼ������Ͻ�y����
// ��  ����scaleX x�������
// ��  ����scaleY y�������
CKVIS_API void CKDisplayImageEx( HDC hDC, HIMAGE hImage, int x, int y, float scaleX, float scaleY );

// ��������CKDisplayThresholdImage
// ��  �ܣ��Զ�ֵ����ʽ��ʾһ��ͼ��
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����hImage ͼ����
// ��  ����Threshold ��ֵ����ֵ
// ��  ����lColor �Ҷ�ֵС�ڵ���Threshold����ɫ
// ��  ����hColor �Ҷ�ֵ����Threshold����ɫ
// ��  ����x ��ʾͼ������Ͻ�x����
// ��  ����y ��ʾͼ������Ͻ�y����
CKVIS_API void CKDisplayThresholdImage( HDC hDC, HIMAGE hImage, int Threshold, int lColor, int hColor, int x, int y );

// ��������CKDisplayImageEx
// ��  �ܣ��Զ�ֵ����ʽ�Ŵ����С��ʾһ��ͼ��
// ��  ����hDC �豸�Ļ�ͼDC���
// ��  ����hImage ͼ����
// ��  ����Threshold ��ֵ����ֵ
// ��  ����lColor �Ҷ�ֵС�ڵ���Threshold����ɫ
// ��  ����hColor �Ҷ�ֵ����Threshold����ɫ
// ��  ����x ��ʾͼ������Ͻ�x����
// ��  ����y ��ʾͼ������Ͻ�y����
// ��  ����scaleX x�������
// ��  ����scaleY y�������
CKVIS_API void CKDisplayThresholdImageEx( HDC hDC, HIMAGE hImage, int Threshold, int lColor, int hColor, int x, int y, float scaleX, float scaleY );





/***************************************************************************
*--------------------------------- ͼ������ -------------------------------*
****************************************************************************
*
*	ͼ��
*
****************************************************************************/

/*************** �궨�� ***************/


// AlgorithmImage - Modality
#define	ALGOR_REP			0
#define	ALGOR_ADD			1
#define	ALGOR_SUB			2
#define	ALGOR_AND			3
#define	ALGOR_OR			4
#define	ALGOR_XOR			5
#define	ALGOR_AVE			6

/************* �������� **************/

// ��������CKGetPixelValue
// ��  �ܣ���ȡ�������ص�ֵ
// ��  ����hImage ͼ����
// ��  ����x �����ͼ���x������
// ��  ����y �����ͼ���y������
// ��  �أ����ص�ǰ������ֵ
CKVIS_API int CKGetPixelValue( HIMAGE hImage, int x, int y );

// ��������CKSetPixelValue
// ��  �ܣ���ȡ�������ص�ֵ
// ��  ����hImage ͼ����
// ��  ����x �����ͼ���x������
// ��  ����y �����ͼ���y������
CKVIS_API void CKSetPixelValue( HIMAGE hImage, int x, int y, int Value );

// ��������CKGetRectPixels
// ��  �ܣ���ȡһ����������Χ�ڵ��������ص�ƽ��ֵ
// ��  ����hImage ͼ����
// ��  ����pRect һ����������
// ��  �أ����ظ��������������صĻҶ�ƽ��ֵ
CKVIS_API float CKGetRectPixels( HIMAGE hImage, RECT *pRect );

// ��������CKSetRectPixels
// ��  �ܣ�����һ����������Χ�ڵ��������ص�ֵ
// ��  ����hImage ͼ����
// ��  ����pRect һ����������
// ��  ����Value ��Ҫ���õĻҶ�ֵ
CKVIS_API void CKSetRectPixels( HIMAGE hImage, RECT *pRect, BYTE Value );

// ��������CKGetRoundPixels
// ��  �ܣ���ȡһ��Բ������Χ�ڵ��������ص�ƽ��ֵ
// ��  ����hImage ͼ����
// ��  ����pRound һ��Բ������
// ��  �أ����ظ��������������صĻҶ�ƽ��ֵ
CKVIS_API float CKGetRoundPixels( HIMAGE hImage, ROUND *pRound );

// ��������CKSetRoundPixels
// ��  �ܣ�����һ��Բ������Χ�ڵ��������ص�ֵ
// ��  ����hImage ͼ����
// ��  ����pRound һ��Բ������
// ��  ����Value ��Ҫ���õĻҶ�ֵ
CKVIS_API void CKSetRoundPixels( HIMAGE hImage, ROUND *pRound, BYTE Value );

// ��������CKGetRotRectPixels
// ��  �ܣ���ȡһ��Բ������Χ�ڵ��������ص�ƽ��ֵ
// ��  ����hImage ͼ����
// ��  ����pRound һ��Բ������
// ��  �أ����ظ��������������صĻҶ�ƽ��ֵ
CKVIS_API float CKGetRotRectPixels( HIMAGE hImage, ROTRECT *pRRect );

// ��������CKSetRotRectPixels
// ��  �ܣ�����һ��Բ������Χ�ڵ��������ص�ֵ
// ��  ����hImage ͼ����
// ��  ����pRound һ��Բ������
// ��  ����Value ��Ҫ���õĻҶ�ֵ
CKVIS_API void CKSetRotRectPixels( HIMAGE hImage, ROTRECT *pRRect, BYTE Value );

// ��������CKPointInRect
// ��  �ܣ��ж�һ�����Ƿ���һ������֮��
// ��  ����Rect һ����������
// ��  ����point �õ������
// ��  �أ�����õ��������ڷ���TRUE�����򷵻�FALSE
CKVIS_API BOOL CKPointInRect( RECT Rect, POINT point );

// ��������CKPointInRound
// ��  �ܣ��ж�һ�����Ƿ���һ��Բ��֮��
// ��  ����Round һ��Բ������
// ��  ����point �õ������
// ��  �أ�����õ��������ڷ���TRUE�����򷵻�FALSE
CKVIS_API BOOL CKPointInRound( ROUND Round, POINT point );

// ��������CKPointInRotRect
// ��  �ܣ��ж�һ�����Ƿ���һ���нǶ��ξ���֮��
// ��  ����RRect һ���нǶ��ξ�������
// ��  ����point �õ������
// ��  �أ�����õ��������ڷ���TRUE�����򷵻�FALSE
CKVIS_API BOOL CKPointInRotRect( ROTRECT RRect, POINT point );

// ��������CKCopyImageRect
// ��  �ܣ�����ͼ���һ����������
// ��  ����hImage ͼ����
// ��  ����pRect ��������
// ��  �أ��ɹ�����һ���µ�ͼ���������򷵻�NULL
CKVIS_API HIMAGE CKCopyImageRect( HIMAGE hImage, RECT* pRect );

// ��������CKPasteImage
// ��  �ܣ���ͼ����һ��ͼ��������һ��ͼ���ϵ�ָ��λ��
// ��  ����hImage Դͼ����
// ��  ����hPaste ��ͼͼ����
// ��  ����hPaste ��ͼͼ����
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKPasteImage( HIMAGE hImage, HIMAGE hPaste, int x, int y );

// ��������CKAlgorithmImage
// ��  �ܣ�������ͼ������ӡ��������ƽ�����롢������Ȳ������������hDest
// ��  ����hSource ��Դͼ����
// ��  ����hDest Ŀ��ͼ����
// ��  ����pRect ��������
// ��  ����Modality ���㷽ʽ
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKAlgorithmImage( HIMAGE hSource, HIMAGE hDest, RECT* pRect, int Modality );

// ��������CKUniteImage
// ��  �ܣ�������Сͼ��ϲ���һ�Ŵ�ͼ����ͼ����ΪWidth*Row���߶�ΪHeight*Col
// ��  ����hImageArray ��Դͼ������
// ��  ����ImageCount ��Դͼ������
// ��  ����Width ����ͼ��Ŀ�ȣ�Ϊ���С����ʱĬ��Ϊ��һ��ͼ��Ŀ��
// ��  ����Width ����ͼ��ĸ߶ȣ�Ϊ���С����ʱĬ��Ϊ��һ��ͼ��ĸ߶�
// ��  ����Row ������
// ��  ����Col ������
// ��  �أ��ɹ����غϲ����ͼ�񣬷��򷵻�NULL
CKVIS_API HIMAGE CKUniteImage( HIMAGE* hImageArray, int ImageCount, int Width, int Height, int Row, int Col );





/***************************************************************************
*------------------------------ ͼ��ͳ������� ----------------------------*
****************************************************************************
*
*	��Ҫ����ͼ��ı������һЩ�򵥵Ķ�λ
*
****************************************************************************/

/**************** �궨�� ****************/

// Connexity - ��ͨ�� 
#define CONNEXITY_4			0	// ����ͨ
#define CONNEXITY_8			1	// ����ͨ

// PixelMode - ����ģʽ
#define PIXEL_DARK			0	// ��ɫ����
#define PIXEL_LIGHT			1	// ��ɫ����

/************ �ṹ���Ͷ��� **************/

// CKGrayProjection - ͶӰ��������
typedef struct tagPROJECTION {
	int		hLenght;		// ˮƽ���򳤶�
	int*	hProfile;		// ˮƽ������������
	int		vLenght;		// ��ֱ���򳤶�
	int*	vProfile;		// ��ֱ������������
} PROJECTION, *PPROJECTION;

// CKGetObjects - �����������ѡ��
typedef struct tagOBJECTOPTION {
	int		MinArea;		// ��С���(��������)
	int		MaxArea;		// ������(��������)
	int		MinWidth;		// ��С���
	int		MaxWidth;		// �����
	int		MinHeight;		// ��С�߶�
	int		MaxHeight;		// ���߶�
	int		Threshold;		// ��ֵ����ֵ(0~255)
	int		Connexity;		// ��ͨ�ԣ�CONNEXITY_4��CONNEXITY_8
	int		PixelMode;		// ����ģʽ��PIXEL_DARK��PIXEL_LIGHT
	int		FilBorder;		// ��ȥ���߽����TRUEΪ�ǣ�FALSEΪ��
} OBJECTOPTION, *POBJECTOPTION;

// CKGetObjects - ���������������
typedef struct tagOBJECT {
	int		Area;			// �������������
	int		Hole;			// ���������ڶ����д��ڵ��෴ֵ�����������
	float	AveGray;		// ƽ���Ҷȣ��������صĻҶ�ƽ��ֵ
	FPOINT	Center;			// ���ģ��������ص�����ƽ��
	RECT	NaturBox;		// ��Ӿ���
} OBJECT, *POBJECT;

// CKPixelAnalyse - �Ҷȷ�����������
typedef struct tagPIXANALYSE {
	int		Area;			// ����������������������
	int		MinGray;		// ��С�ĻҶ�ֵ
	int		MaxGray;		// ���ĻҶ�ֵ
	float	AverGray;		// ƽ���Ҷ�ֵ
} PIXANALYSE, *PPIXANALYSE;

// CKPixelCount - ����ͳ�Ʒ�������
typedef struct tagPIXELCOUNT {
	int		AnyCount;		// ȫ����������
	int		HoldCount;		// ��ǰ��������
	float	Percent;		// ��ǰ����������ȫ�����������ı�
} PIXELCOUNT, *PPIXELCOUNT;

// CKBlobAnalyse - Blob��������ѡ��1
typedef struct tagBLOBOPTION {
	int		MinArea;		// ��С���(��������)
	int		MaxArea;		// ������(��������)
	int		MinHole;		// ���ٿ���
	int		MaxHole;		// ������
	int		Threshold;		// ��ֵ����ֵ(0~255)
	int		Connexity;		// ��ͨ�ԣ�CONNEXITY_4��CONNEXITY_8
	int		PixelMode;		// ����ģʽ��PIXEL_DARK��PIXEL_LIGHT
	int		FilBorder;		// ��ȥ���߽����TRUEΪ�ǣ�FALSEΪ��
} BLOBOPTION, *PBLOBOPTION;

// CKBlobAnalyse - Blob��������ѡ��2
typedef struct tagMOREBLOBOPTION {
	float	MinAveGray;		// ��С�ĻҶ�ƽ��ֵ(0.0~255.0)
	float	MaxAveGray;		// ���ĻҶ�ƽ��ֵ(0.0~255.0)
	float	MinRectSur;		// ��С�ľ��ζ�(0.0~1.2)
	float	MaxRectSur;		// ���ľ��ζ�(0.0~1.2)
	float	MinLathySur;	// ��С��ϸ����(0.0~1.0)
	float	MaxLathySur;	// ����ϸ����(0.0~1.0)
	float	MinLeastWidth;	// ��С�Ŀ�ȣ���С�����Ӿ���
	float	MaxLeastWidth;	// ���Ŀ�ȣ���С�����Ӿ���
	float	MinLeastHeight;	// ��С�ĸ߶ȣ���С�����Ӿ���
	float	MaxLeastHeight;	// ���ĸ߶ȣ���С�����Ӿ���
} MOREBLOBOPTION, *PMOREBLOBOPTION;

// CKBlobAnalyse - Blob������������
typedef struct tagBLOBOBJECT {
	int			Area;		// ��������(��������)
	int			Hole;		// �����п׵�����
	float		AveGray;	// ���ȣ�������������صĻҶ�ƽ��ֵ
	float		RectSur;	// ���ζȣ������������С��Ӿ��ε������
	float		LathySur;	// ϸ���ȣ���С�����
	FPOINT		Center;		// ��������ģ��������ص�����ƽ��ֵ
	RECT		NaturBox;	// ˮƽ�������Ӿ��Σ������Ƕ�
	FROTRECT	LeastBox;	// ��С�������Ӿ��Σ����нǶ�
	int			CHPCount;	// ͹����Ե������
	POINT*		CHPoints;	// ͹����Ե�������
} BLOBOBJECT, *PBLOBOBJECT;

// CKGetEdgeContours - ��Ե������ѡ��
typedef struct tagEDGEOPTION {
	int		MinLenght;		// ��̱�Ե
	int		MaxLenght;		// ���Ե
	int		Threshold;		// ��Ե�ݶ���ֵ(0~128)
} EDGEOPTION, *PEDGEOPTION;

// CKGetEdgeContours - ��Ե��ⷵ������
typedef struct tagCONEDGE {
	int		Lenght;			// ��Ե�ĳ���
	POINT*	Points;			// ��Ե�����������
} CONEDGE, *PCONEDGE;

// CKFindRoundFromEdge - ��Բ����ѡ��
typedef struct tagFREDOPTION {
	float	MinRadii;		// ��С�뾶�������20����
	float	MaxRadii;		// ���뾶�������20����
	float	MinSample;		// ��С������(0.0~1.0)
	float	MinLacuna;		// ��Сȱ�ݶ�(0.0~1.0)
	float	Tolerance;		// ���̵����ֵ��һ��Ϊ1.0~4.0
} FREOPTION, *PFREDOPTION;

// CKFindRoundFromEdge - ��Բ��������
typedef struct tagFREROUND {
	float	Sample;			// ������
	float	Lacuna;			// ȱ�ݶ�
	FROUND	Round;			// Բ���ݣ��μ�FROUND
} FREROUND, *PFREROUND;

/************* �������� **************/

// ��������CKGrayHistogram
// ��  �ܣ���ȡͼ��ĻҶ�ֵ��ͼ
// ��  ����hImage ͼ����
// ��  ����pRect �������NULLΪ����ͼ��
// ��  ����retSize ����ֵ��ͼ����Ĵ�С
// ��  �أ��ɹ�����ֵ��ͼ���ݣ����򷵻�NULL
CKVIS_API int* CKGrayHistogram( HIMAGE hImage, RECT *pRect, int *retSize );

// ��������CKGrayProjection
// ��  �ܣ���ȡͼ��ĻҶ�ͶӰͼ
// ��  ����hImage ͼ����
// ��  ����pRect �������NULLΪ����ͼ��
// ��  �أ��ɹ�����ͶӰ���ݣ����򷵻�NULL
CKVIS_API PROJECTION* CKGrayProjection( HIMAGE hImage, RECT* pRect );

// ��������CKBinaryProjection
// ��  �ܣ���ȡ��ֵͼ���ͶӰͼ
// ��  ����hImage ͼ����
// ��  ����pRect �������NULLΪ����ͼ��
// ��  �أ��ɹ�����ͶӰ���ݣ����򷵻�NULL
CKVIS_API PROJECTION* CKBinaryProjection( HIMAGE hImage, RECT* pRect );

// ��������CKPixelAnalyse
// ��  �ܣ�����ͼ��ĻҶ�ƽ��ֵ�����ֵ����Сֵ
// ��  ����hImage ͼ����
// ��  ����pRect �������NULLΪ����ͼ��
// ��  �أ��ɹ�������ص����ݣ����򷵻�NULL
CKVIS_API PIXANALYSE* CKPixelAnalyse( HIMAGE hImage, RECT *pRect );

// ��������CKPixelCount
// ��  �ܣ�ͳ��ͼ���кڰ��������������
// ��  ����hImage ͼ����
// ��  ����pRect �������NULLΪ����ͼ��
// ��  ����PixelMode ���ģʽ��0Ϊ��ɫ���أ�1Ϊ��ɫ����
// ��  ����Threshold �ָ���ֵ���Ҷ�ֵ���ڸ�ֵΪ��ɫ������Ϊ��ɫ
// ��  �أ��ɹ�������ص����ݣ����򷵻�NULL
CKVIS_API PIXELCOUNT* CKPixelCount( HIMAGE hImage, RECT *pRect, int PixelMode, int Threshold );

// ��������CKGetObjects
// ��  �ܣ���������������ͼ������ͨ�����������������һЩ�򵥵�����
// ��  ����hImage ͼ����
// ��  ����pRect �������NULLΪ����ͼ��
// ��  ����Option ��صĲ������μ�OBJECTOPTION
// ��  ����retCount ���ض��������
// ��  �أ��ɹ��������ж�������ݣ����򷵻�NULL
CKVIS_API OBJECT* CKGetObjects( HIMAGE hImage, RECT* pRect, OBJECTOPTION* Option, int* retCount );

// ��������CKBlobAnalyse
// ��  �ܣ�����ں���CKGetObjects�Ļ����ϸ�������������Ͳ���
// ��  ����hImage ͼ����
// ��  ����pRect �������NULLΪ����ͼ��
// ��  ����Option1 ��صĲ������μ�BOLBOPTION
// ��  ����Option2 �������صĲ�����NULLΪ��ʹ�ò������μ�MOREBOLBOPTION
// ��  ����retCount ���ض��������
// ��  �أ��ɹ���������Bolb��������ݣ����򷵻�NULL
CKVIS_API BLOBOBJECT* CKBlobAnalyse( HIMAGE hImage, RECT* pRect, BLOBOPTION* Option1, MOREBLOBOPTION* Option2, int* retCount );

// ��������CKBlobAnalyse2
// ��  �ܣ�����ں���CKGetObjects�Ļ����ϸ�������������Ͳ���
// ��  ����hImage ͼ����
// ��  ����hRoi �������NULLΪ����ͼ��
// ��  ����Option1 ��صĲ������μ�BOLBOPTION
// ��  ����Option2 �������صĲ�����NULLΪ��ʹ�ò������μ�MOREBOLBOPTION
// ��  ����retCount ���ض��������
// ��  �أ��ɹ���������Bolb��������ݣ����򷵻�NULL
CKVIS_API BLOBOBJECT* CKBlobAnalyse2( HIMAGE hImage, ROTRECT* pRotRect, BLOBOPTION* Option1, MOREBLOBOPTION* Option2, int* retCount );

// ��������CKBlobAnalyse
// ��  �ܣ�����ں���CKGetObjects�Ļ����ϸ�������������Ͳ���
// ��  ����hImage ͼ������֧��8λ
// ��  ����hMask 8λ�Ķ�ֵͼ��0ֵΪ��������򣬷�0ֵΪ�������
// ��  ����Option1 ��صĲ������μ�BOLBOPTION
// ��  ����Option2 �������صĲ�����NULLΪ��ʹ�ò������μ�MOREBOLBOPTION
// ��  ����retCount ���ض��������
// ��  �أ��ɹ���������Bolb��������ݣ����򷵻�NULL
CKVIS_API BLOBOBJECT* CKBlobAnalyseFromMask( HIMAGE hImage, HIMAGE hMask, BLOBOPTION* Option1, MOREBLOBOPTION* Option2, int* retCount );

// ��������CKGetEdgeContours
// ��  �ܣ���ȡͼ��ı�Ե����
// ��  ����hImage ͼ����
// ��  ����pRect �������NULLΪ����ͼ��
// ��  ����Option ��صĲ������μ�EDGEOPTION
// ��  ����retCount ���ر�Ե����������
// ��  �أ��ɹ���������������������ݣ����򷵻�NULL
CKVIS_API CONEDGE* CKGetEdgeContours( HIMAGE hImage, RECT* pRect, EDGEOPTION* Option, int* retCount );

// ��������CKFindRoundFromContour
// ��  �ܣ����ݱ�Ե�������Բ��
// ��  ����ContourArray ������������
// ��  ����ContourCount �����С
// ��  ����Option ��صĲ������μ�FIROUOPTION
// ��  ����retCount ����Բ�ε�����
// ��  �أ��ɹ��������з��ϵ�Բ�����ݣ����򷵻�NULL
CKVIS_API FREROUND* CKFindRoundFromEdge( CONEDGE *pEdgeArray, int EdgeCount, FREOPTION *Option, int* retCount );

// ��������CKConvexHull
// ��  �ܣ���һ������㼯��͹��(��С��ӵ�͹�����)
// ��  ����PointArray �㼯��������
// ��  ����PointCount �㼯���ݵĴ�С���������
// ��  ����retCount ����͹�����������
// ��  �أ��ɹ�����͹�������ж������ݣ����򷵻�NULL
CKVIS_API POINT* CKConvexHull( POINT* PointArray, int PointCount, int *retCount );

// ��������CKLeastRectangle
// ��  �ܣ�����͹����εĶ������һ����С�������Ӿ���
// ��  ����ConvexHullPoints ͹������㼯����
// ��  ����PointCount �㼯���ݵĴ�С���������
// ��  �أ�����һ������ת���ε����ݽṹ
CKVIS_API FROTRECT CKLeastRectangle( POINT* ConvexHullPoints, int PointCount );

// ��������CKGrayLine1
// ��  �ܣ����һ���������е�ĻҶ�ֵ
// ��  ����hImage ͼ����
// ��  ����pLine ָ���������ݽṹ��ָ��
// ��  ����retSize �������лҶȵ������
// ��  �أ��ɹ������������е�ĻҶ�ֵ�����򷵻�NULL
CKVIS_API int* CKGrayLine1( HIMAGE hImage, LINE* pLine, int* retSize );

// ��������CKGrayLine2
// ��  �ܣ����һ��Բ�α������е�ĻҶ�ֵ
// ��  ����hImage ͼ����
// ��  ����pRound ָ��Բ�����ݽṹ��ָ��
// ��  ����retSize �������лҶȵ������
// ��  �أ��ɹ������������е�ĻҶ�ֵ�����򷵻�NULL
CKVIS_API int* CKGrayLine2( HIMAGE hImage, ROUND* pRound, int* retSize );

// ��������CKGrayCompare
// ��  �ܣ�ͼ��ȽϹ���
// ��  ����hImage ���Ƚϵ�ͼ�������ȽϽ�����ڸõ�ͼ����
// ��  ����hPattern ģ��ͼ����
// ��  ����hMask ����ͼ����
// ��  ����x hPattern��hImage��Ӧλ�ã������hImage������ϵ�����Ͻ�λ��x��
// ��  ����y hPattern��hImage��Ӧλ�ã������hImage������ϵ�����Ͻ�λ��y��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGrayCompare( HIMAGE hImage, HIMAGE hPattern, HIMAGE hMask, int x, int y );

// ��������CKMakeMask
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKMakeMask( HIMAGE hImage, HIMAGE hMask );





/***************************************************************************
*------------------------------- ��ֵ������ -------------------------------*
****************************************************************************
*
*	��ֵ��
*
****************************************************************************/

/**************** �궨�� ****************/

/*
// Connexity - ��ͨ�� 
#define CONNEXITY_4			0	// ����ͨ
#define CONNEXITY_8			1	// ����ͨ

// PixelMode - ����ģʽ
#define PIXEL_DARK			0	// ��ɫ����
#define PIXEL_LIGHT			1	// ��ɫ����
*/

/************* �������� **************/

// ��������CKAutomThreshold
// ��  �ܣ���ȡͼ��Ķ�ֵ���Զ��ָ���ֵ
// ��  ����hImage ͼ����
// ��  ����pRect ���������NULLΪ����ͼ��
// ��  �أ����ض�ֵ���ָ���ֵ
CKVIS_API int CKAutomThreshold( HIMAGE hImage, RECT *pRect );

// ��������CKGrayThreshold1
// ��  �ܣ���ͼ����е���ֵ��ֵ��
// ��  ����hImage ͼ����
// ��  ����Threshold ��ֵ���ָ���ֵ
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGrayThreshold1( HIMAGE hImage, int Threshold );

// ��������CKGrayThreshold1
// ��  �ܣ���ͼ�����˫��ֵ��ֵ��
// ��  ����hImage ͼ����
// ��  ����Threshold1 ��ֵ���ָ���ֵ1
// ��  ����Threshold2 ��ֵ���ָ���ֵ2
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGrayThreshold2( HIMAGE hImage, int Threshold1, int Threshold2 );

// ��������CKDistanceTransform
// ��  �ܣ��Զ�ֵͼ����о���任
// ��  ����hImage ͼ����
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKDistanceTransform( HIMAGE hImage );

// ��������CKDistanceTransformEx
// ��  �ܣ��Զ�ֵͼ����о���任
// ��  ����hImage ͼ����
// ��  ����Value1 ϵ��1
// ��  ����Value2 ϵ��2
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKDistanceTransformEx( HIMAGE hImage, int Value1, int Value2 );

// ��������CKBinaryContour
// ��  �ܣ��Զ�ֵͼ�����������ȡ
// ��  ����hImage ͼ����
// ��  ����Connexity ��ͨ�ԣ�0Ϊ4��ͨ��1Ϊ8��ͨ
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKBinaryContour( HIMAGE hImage, int Connexity );

// ��������CKBinaryThin
// ��  �ܣ��Զ�ֵͼ�����ϸ������
// ��  ����hImage ͼ����
// ��  ����PixelMode 0Ϊ��ɫ���أ�1Ϊ��ɫ����
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKBinaryThin( HIMAGE hImage, int PixelMode );

// ��������CKShearNoises
// ��  �ܣ�ȥ��ͼ��ͻ��������
// ��  ����hImage ͼ����
// ��  ����PixelMode 0Ϊ��ɫ����1Ϊ��ɫ����
// ��  ����sizeX x�����...
// ��  ����sizeY y�����...
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKShearNoises( HIMAGE hImage, int PixelMode, int sizeX, int sizeY );

// ��������CKBinaryContour
// ��  �ܣ��Զ�ֵͼ����и�ʴ����
// ��  ����sourceImage ��Դ��ͼ��������Ҫ�����ͼ��
// ��  ����destImage Ŀ��ͼ������������ͼ����ڸþ��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKBinaryErosion( HIMAGE sourceImage, HIMAGE destImage );

// ��������CKBinaryDilation
// ��  �ܣ��Զ�ֵͼ��������ʹ���
// ��  ����sourceImage ��Դ��ͼ��������Ҫ�����ͼ��
// ��  ����destImage Ŀ��ͼ������������ͼ����ڸþ��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKBinaryDilation( HIMAGE sourceImage, HIMAGE destImage );

// ��������CKFillHoles
// ��  �ܣ��Զ�ֵͼ��������
// ��  ����hImage ͼ����
// ��  ����PixelMode 0Ϊ��ɫ���أ�1Ϊ��ɫ����
// ��  ����Connexity ��ͨ�ԣ�0Ϊ4��ͨ��1Ϊ8��ͨ
// ��  ����ThresholdArea �����ֵ��С�ڸ���������������
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKFillHoles( HIMAGE hImage, int PixelMode, int Connexity, int MinArea );





/***************************************************************************
*------------------------------- ͼ��Ԥ���� -------------------------------*
****************************************************************************
*
*	��Ҫ����ͼ��Ԥ����
*
****************************************************************************/

/************* �������� **************/

// ��������CKGraySmooth
// ��  �ܣ���ͼ�����ƽ������
// ��  ����hSource ��Դ��ͼ��������Ҫ�����ͼ��
// ��  ����hDest Ŀ��ͼ������������ͼ����ڸþ��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGraySmooth( HIMAGE hSource, HIMAGE hDest );

// ��������CKGraySharp
// ��  �ܣ���ͼ������񻯴���
// ��  ����hSource ��Դ��ͼ��������Ҫ�����ͼ��
// ��  ����hDest Ŀ��ͼ������������ͼ����ڸþ��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGraySharp( HIMAGE hSource, HIMAGE hDest );

// ��������CKGrayMedian
// ��  �ܣ���ͼ�������ֵ�˲�����
// ��  ����hSource ��Դ��ͼ��������Ҫ�����ͼ��
// ��  ����hDest Ŀ��ͼ������������ͼ����ڸþ��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGrayMedian( HIMAGE hSource, HIMAGE hDest );

// ��������CKGrayErosion
// ��  �ܣ���ͼ������и�ʴ����
// ��  ����hSource ��Դ��ͼ��������Ҫ�����ͼ��
// ��  ����hDest Ŀ��ͼ������������ͼ����ڸþ��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGrayErosion( HIMAGE hSource, HIMAGE hDest );

// ��������CKGrayDilation
// ��  �ܣ���ͼ��������ʹ���
// ��  ����hSource ��Դ��ͼ��������Ҫ�����ͼ��
// ��  ����hDest Ŀ��ͼ������������ͼ����ڸþ��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGrayDilation( HIMAGE hSource, HIMAGE hDest );

// ��������CKGrayEdge
// ��  �ܣ���ͼ����б�Ե��⴦��
// ��  ����hSource ��Դ��ͼ��������Ҫ�����ͼ��
// ��  ����hDest Ŀ��ͼ������������ͼ����ڸþ��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGrayEdge( HIMAGE hSource, HIMAGE hDest );

// ��������CKGrayReverse
// ��  �ܣ���ͼ����з�ɫ����
// ��  ����hSource ��Դ��ͼ��������Ҫ�����ͼ��
// ��  ����hDest Ŀ��ͼ������������ͼ����ڸþ��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGrayReverse( HIMAGE hSource, HIMAGE hDest );

// ��������CKGrayAdding
// ��  �ܣ�������ͼ��������
// ��  ����sourceImage ����ͼ��
// ��  ����destImage ���ͼ�񣬼��������ڸþ��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGrayAdding( HIMAGE sourceImage, HIMAGE destImage );

// ��������CKGraySubtract
// ��  �ܣ�������ͼ��������
// ��  ����sourceImage ����ͼ��
// ��  ����destImage ���ͼ�񣬼��������ڸþ��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGraySubtract( HIMAGE sourceImage, HIMAGE destImage );

// ��������CKGrayAdjust
// ��  �ܣ���ͼ������ȺͶԱȶȽ��е���
// ��  ����sourceImage ����ͼ��
// ��  ����destImage ���ͼ�񣬼��������ڸþ��
// ��  ����Brightness ���Ȳ���ֵ��һ��Ϊ(-128~128)
// ��  ����Contrast �ԱȶȲ���ֵ��һ��Ϊ(-128~128)
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGrayAdjust( HIMAGE sourceImage, HIMAGE destImage, int Brightness, int Contrast );



/***************************************************************************
*-------------------------------- ���߷��� --------------------------------*
****************************************************************************
*
*	����
*
****************************************************************************/

/**************** �궨�� ****************/

// ����Ե�㷽ʽ - GetEdgeMode
#define GEM_RISE			0	// �ڵ���
#define GEM_DROP			1	// �׵���
#define GEM_RISE_DROP		2	// �ڵ��׻�׵���

// CKProfileThreshold - Mode
#define AUTOM_HIGH			-1
#define AUTOM_NATURAL		-2
#define AUTOM_LOW			-3

/************ �ṹ���Ͷ��� **************/

// CKGetProfileEdge(1,2) - ��ȡ���ߵı�Ե�㷵������
typedef struct tagPROEDGE {
	int		State;			// ״̬��0Ϊ�ڵ��ף�1Ϊ�׵���
	float	Distance;		// ���룬�ӿ�ʼλ�õ���ǰλ�õľ���(pixel)
	float	Intensity;		// ǿ�ȣ���λ�õĻҶȱ仯ǿ��
} PROEDGE, *PPROEDGE;

// CKGetProfileObject - ͶӰ��������
typedef struct tagPROBJOPTION {
	int		Threshold;		// ��Եǿ����ֵ(0~255)
	int		EdgeMode;		// ��Եģʽ��0Ϊ�ڵ��ף�1Ϊ�׵���
	int		Direction;		// ��ⷽ��0Ϊ�ڵ��⣬1Ϊ�⵽��
	int		Smoothness;		// ƽ����Χ��һ����Ϊ1~3
} PROBJOPTION, *PPROBJOPTION;

// CKGetProfileObject - ͶӰ��������
typedef struct tagPROBJECT {
	float	Intensity;		// ǿ��
	FRECT	BorderBox;		// �߽��
} PROBJECT, *PPROBJECT;

/************* �������� **************/

// ��������CKProfileSmooth
// ��  �ܣ������߽���ƽ������
// ��  ����profileData ��������
// ��  ����profileSize �������ݴ�С
// ��  ����Range ƽ����Χ
// ��  ����Mode ƽ��ģʽ��1Ϊ����ƽ����0��ʹ��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKProfileSmooth( int* profileData, int profileSize, int Range, int Mode );

// ��������CKProfileThreshold
// ��  �ܣ��������ߵķָ���ֵ
// ��  ����profileData ��������
// ��  ����profileSize �������ݴ�С
// ��  ����Mode ģʽ
// ��  �أ����طָ���ֵ
CKVIS_API int CKProfileThreshold( int* profileData, int profileSize, int Mode );

// ��������CKGetProfileGrads
// ��  �ܣ���ȡ���ߵ��ݶ�
// ��  ����profileData ��������
// ��  ����profileSize �������ݴ�С
// ��  ����IsAbs �Ƿ�ȡ����ֵ
// ��  �أ��ɹ������ݶ��������ݣ���С��ԭ����һ�������򷵻�NULL
CKVIS_API int* CKGetProfileGrads( int* profileData, int profileSize, int IsAbs );

// ��������CKGetProfileEdge1
// ��  �ܣ���ȡ���ߵĶ��㣬�ֲ����ֵ����Сֵ
// ��  ����profileData ��������
// ��  ����profileSize �������ݴ�С
// ��  ����Threshold �ָ���ֵ�����ߵĵ�ǰ���ֵ�ľ���ֵ���ڸ���ֵ�ű�������
// ��  ����GetEdgeMode ��ȡ����ģʽ
// ��  ����retCount ��ȡ����ģʽ
// ��  �أ��ɹ��������м�⵽�Ķ��㣬���򷵻�NULL
CKVIS_API PROEDGE* CKGetProfileEdge1( int* profileData, int profileSize, int Threshold, int GetEdgeMode, int* retCount );

// ��������CKGetProfileEdge2
// ��  �ܣ���ȡ���߱�Ե�㣬�����ݶȵĹ����
// ��  ����profileData ԭ���ߵ�һ���ݶ�
// ��  ����profileSize �������ݴ�С
// ��  ����Threshold �ָ���ֵ�����ߵĵ�ǰ���ֵ�ľ���ֵ���ڸ���ֵ�ű�������
// ��  ����GetEdgeMode ��ȡ����ģʽ
// ��  ����retCount ��ȡ����ģʽ
// ��  �أ��ɹ��������м�⵽�Ķ��㣬���򷵻�NULL
CKVIS_API PROEDGE* CKGetProfileEdge2( int* profileData, int profileSize, int Threshold, int GetEdgeMode, int* retCount );

// ��������CKGetProfileObject
// ��  �ܣ���������ͼ�ҳ�����
// ��  ����profileX x�᷽������
// ��  ����sizeX profileX���ߵĳ���
// ��  ����profileY y�᷽������
// ��  ����sizeY profileY���ߵĳ���
// ��  ����Option ��ز������μ�PROBJOPTION
// ��  �أ��ɹ����ض������ݣ����򷵻�NULL
CKVIS_API PROBJECT* CKGetProfileObject( int* profileX, int sizeX, int* profileY, int sizeY, PROBJOPTION* Option );

// ��������CKDisplayProfile
// ��  �ܣ�����Ļ��ָ����Χ����ʾһ������
// ��  ����hDC ��ʾ�豸��DC���
// ��  ����pRect ��ʾ���ߵķ�Χ
// ��  ����profileData ��������
// ��  ����profileSize �������ݴ�С
// ��  ����MaxValue ���ߴ�ֱ��������ֵ
// ��  ����bColor ������ɫ��0xFFFFFFFFΪ��ʹ�ñ�����ɫ
// ��  ����lColor ������ɫ
CKVIS_API void CKDisplayProfile( HDC hDC, RECT* pRect, int* profileData, int profileSize, int MaxValue, int bColor, int lColor );

// ��������CKDisplayFProfile
// ��  �ܣ�����Ļ��ָ����Χ����ʾһ������
// ��  ����hDC ��ʾ�豸��DC���
// ��  ����pRect ��ʾ���ߵķ�Χ
// ��  ����profileData ��������
// ��  ����profileSize �������ݴ�С
// ��  ����MaxValue ���ߴ�ֱ��������ֵ
// ��  ����bColor ������ɫ��0xFFFFFFFFΪ��ʹ�ñ�����ɫ
// ��  ����lColor ������ɫ
CKVIS_API void CKDisplayFProfile( HDC hDC, RECT* pRect, float* profileData, int profileSize, float MaxValue, int bColor, int lColor );





/***************************************************************************
*-------------------------------- �������� --------------------------------*
****************************************************************************
*
*	��Ҫ���ڲ�����һЩ�򵥵Ķ�λ
*
****************************************************************************/

/**************** �궨�� ****************/

/* ����Ե�㷽ʽ - GetEdgeMode
#define GEM_RISE			0	// �ڵ���
#define GEM_DROP			1	// �׵���
#define GEM_RISE_DROP		2	// �ڵ��׻�׵���
*/

// ��ⷽ��	- 
#define DIR_IN_TO_OUT		0
#define DIR_OUT_TO_IN		1
#define DIR_LEFT_TO_RIGHT	0
#define DIR_TOP_TO_BOTTOM	1
#define DIR_FIRST			0
#define DIR_END				1
#define DIR_FIRST_END		2
#define DIR_ALL				3

/************ �ṹ���Ͷ��� **************/

// ���в������ܵĲ���ѡ��
typedef struct tagMEASOPTION {
	int		Threshold;		// ����ı�Եλ�õĻҶȱ仯ǿ����ֵ(0~255)
	int		LineSpace;		// �������ܶȣ�ÿ�����ٸ�������һ�μ�⣬ֻ���ڷ�����ROI��������(pixel)
	int		Smoothness;		// ƽ����Χ��һ����Ϊ1~3
	int		GetEdgeMode;	// ��ȡ��Եλ�õ�ģʽ��0Ϊ�ڵ��ף�1Ϊ�׵��ڣ�2Ϊ�ڵ��׻�׵���
	int		Directional;	// ����������ǿ�ʼ�ͽ���λ�õ�ѡ�񣬸�駲������ܵĲ�ͬ����
} MEASOPTION, *PMEASOPTION;

// CKMeasurePoint(1,2) - ��Ե�������������
typedef struct tagMEASPOINT {
	int		State;			// ״̬��0Ϊ�ڵ��ף�1Ϊ�׵���
	float	Distance;
	float	Intensity;		// ǿ�ȣ���λ�õĻҶȱ仯ǿ��
	FPOINT	LocatePoint;	// ��λ�ö�Ӧ��һ���㣬������Ļ����ʾ
} MEASPOINT, *PMEASPOINT;

// CKMeasureDistance - ���������������
typedef struct tagMEASDISTANCE {
	int		State;			// ״̬��0Ϊ�ڵ��ף�1Ϊ�׵���
	float	Distance;		// ���룬��ROI�Ŀ�ʼλ�õ���ǰλ�õľ���(pixel)
	float	Intensity;		// ǿ�ȣ���λ�õĻҶȱ仯ǿ��
	FLINE	LocateLine;		// ��λ�ö�Ӧ��һ���ߣ�������Ļ����ʾ
} MEASDISTANCE, *PMEASDISTANCE;

// CKGetBestSpace - ��������������
typedef struct tagMEASSPACE {
	float	Distance;		// ��࣬������Եλ�ü�ľ��룬������һ���׵��ں�һ���ڵ���(pixel)
	float	Intensity;		// ǿ�ȣ���λ�õĻҶȱ仯ǿ��
	FLINE	LocateLine;		// ��λ�ö�Ӧ��һ���ߣ�������Ļ����ʾ
} MEASSPACE, *PMEASSPACE;

// CKGetBestLine - �߲�����������
typedef struct tagMEASLINE {
	float	Sample;			// �����ʣ���ǰ�ҵ��������õ��ı�Ե����ȫ����ı�
	float	Distance;		// �����ĳ���(pixel)
	float	LineAngle;		// ���������ˮƽ����ĽǶ�
	float	Intensity;		// ǿ�ȣ�����λ�õ�ǿ��ƽ��
	FLINE	LocateLine;		// ��λ�ö�Ӧ��һ���ߣ�������Ļ����ʾ
} MEASLINE, *PMEASLINE;

// CKGetBestRound - Բ�β�����������
typedef struct tagMEASROUND {
	float	Sample;			// �����ʣ���ǰ�ҵ��������õ��ı�Ե����ȫ����ı�
	float	Intensity;		// ǿ�ȣ�����λ�õ�ǿ��ƽ��
	FROUND	LocateRound;	// ��������Բ�����ݣ���λ�ö�Ӧ��һ��Բ��������Ļ����ʾ
} MEASROUND, *PMEASROUND;

// CKMeasCallipers - ���߲�����������
typedef struct tagCALLIPERS
{
	float	Distance;		// ���߹��߲⵽������λ�ü�ľ���(pixel)
	float	Intensity1;		// ��һ��λ��ǿ��
	float	Intensity2;		// �ڶ���λ��ǿ��
	FLINE	LocateLine1;	// ��һ��λ�ö�Ӧ��һ���ߣ�������Ļ����ʾ
	FLINE	LocateLine2;	// �ڶ���λ�ö�Ӧ��һ���ߣ�������Ļ����ʾ
	FPOINT	LocatePoint1;	// ��һ��λ�ö�Ӧ��һ���㣬������Ļ����ʾ
	FPOINT	LocatePoint2;	// �ڶ���λ�ö�Ӧ��һ���㣬������Ļ����ʾ
} CALLIPERS, *PCALLIPERS;

/************* �������� **************/

// ��������CKMeasurePoint
// ��  �ܣ���һ�����ϼ���Ե��
// ��  ����hImage ͼ������֧�ֵ�ͼ������Ϊ8Bit
// ��  ����pLine һ��ָ���������ݽṹ��ָ��
// ��  ����Option �������ߵ���ز������μ�MEASOPTION
// ��  ����retCount ���ؼ�⵽�ı�Ե����Ŀ
// ��  �أ��ɹ����ؼ�⵽�����б�Ե�����ݣ�����NULL
CKVIS_API MEASPOINT* CKMeasurePoint( HIMAGE hImage, LINE* pLine, MEASOPTION* Option, int* retCount );

// ��������CKMeasurePoint2
// ��  �ܣ���һԲ�α��ϼ���Ե��
// ��  ����hImage ͼ������֧�ֵ�ͼ������Ϊ8Bit
// ��  ����pRound һ��ָ��Բ�����ݽṹ��ָ��
// ��  ����Option �������ߵ���ز������μ�MEASOPTION
// ��  ����retCount ���ؼ�⵽�ı�Ե����Ŀ
// ��  �أ��ɹ����ؼ�⵽�����б�Ե�����ݣ�����NULL
CKVIS_API MEASPOINT* CKMeasurePoint2( HIMAGE hImage, ROUND* pRound, MEASOPTION* Option, int* retCount );

// ��������CKMeasureDistance
// ��  �ܣ���Եλ�ü�⹦�ܣ����ڼ������������Եλ��֮��ļ��
// ��  ����hImage ͼ����
// ��  ����pRotRect һ��ָ�����ת�������ݽṹ��ָ��
// ��  ����Option �������ߵ���ز������μ�MEASOPTION
// ��  ����retCount ���ؼ�⵽�ı�Եλ����Ŀ
// ��  �أ��ɹ����ؼ�⵽�����б�Ե�����ݣ�����NULL
CKVIS_API MEASDISTANCE* CKMeasureDistance( HIMAGE hImage, ROTRECT* pRotRect, MEASOPTION* Option, int* retCount );

// ��������CKGetBestSpace
// ��  �ܣ���Եλ�ü�⹦�ܣ����ڼ������������Եλ��֮��ļ��
// ��  ����distanceList CKMeasureDistance�������ص�����
// ��  ����distanceCount ��Եλ����Ŀ
// ��  ����distanceMode 0Ϊ��ɫ���֣�1Ϊ��ɫ����
// ��  ����retCount ���ؼ�⵽���������
// ��  �أ��ɹ����ؼ�⵽�����м�����ݣ�����NULL
CKVIS_API MEASSPACE* CKGetBestSpace( MEASDISTANCE* distanceList, int distanceCount, int distanceMode, int* retCount );

// ��������CKMeasureLinePoints
// ��  �ܣ���ָ���ķ�Χ�ڼ���Ե��
// ��  ����hImage ͼ����
// ��  ����pRotRect һ��ָ�����ת�������ݽṹ��ָ��
// ��  ����Option �������ߵ���ز������μ�MEASOPTION
// ��  ����retCount ���ؼ�⵽�ı�Եλ����Ŀ
// ��  �أ��ɹ����ؼ�⵽�����б�Ե�����ݣ�����NULL
CKVIS_API FPOINT* CKMeasureLinePoints( HIMAGE hImage, ROTRECT* pRotRect, MEASOPTION* Option, int* retCount );

// ��������CKGetBestLine
// ��  �ܣ�����CKMeasureLinePoints�������ĵ����һ����
// ��  ����Points ���е������
// ��  ����Count �������
// ��  ����Tolerance ���̵ı䶯��Χ
// ��  �أ��ɹ�����һ���ߵ����ݣ�����NULL
CKVIS_API MEASLINE* CKGetBestLine( FPOINT* Points, int Count, float Tolerance );

// ��������CKMeasureRoundPoints
// ��  �ܣ���ָ���ķ�Χ�ڼ���Ե��
// ��  ����hImage ͼ����
// ��  ����pAnnulus һ��ָ�������ݽṹ��ָ��
// ��  ����Option �������ߵ���ز������μ�MEASOPTION
// ��  ����retCount ���ؼ�⵽�ı�Եλ����Ŀ
// ��  �أ��ɹ����ؼ�⵽�����б�Ե�����ݣ�����NULL
CKVIS_API FPOINT* CKMeasureRoundPoints( HIMAGE hImage, ANNULUS* pAnnulus, MEASOPTION* Option, int* retCount );

// ��������CKGetBestRound
// ��  �ܣ�����CKMeasureRoundPoints�������ĵ����һ��Բ
// ��  ����Points ���е������
// ��  ����Count �������
// ��  ����Tolerance ���̵ı䶯��Χ
// ��  �أ��ɹ�����һ��Բ�����ݣ�����NULL
CKVIS_API MEASROUND* CKGetBestRound( FPOINT* Points, int Count, float Tolerance );

// ��������CKMeasCallipers
// ��  �ܣ����߹��ߣ���������ĳ��ȳߴ�
// ��  ����hImage ͼ����
// ��  ����pRotRect һ��ָ�����ת�������ݽṹ��ָ��
// ��  ����Option �������ߵ���ز������μ�MEASOPTION
// ��  �أ��ɹ����ز�������������ݣ�����NULL
CKVIS_API CALLIPERS* CKMeasCallipers( HIMAGE hImage, ROTRECT* pRotRect, MEASOPTION* Option );

// ��������CKDisplayAnnulusLine
// ��  �ܣ���һ����������ʾ����·����λ��
// ��  ����hDC ��ʾ�豸DC���
// ��  ����pAnnulus һ��ָ�������ݽṹ��ָ��
// ��  ����Space ÿ�����ٶȻ�һ����
CKVIS_API void CKDisplayLineToAnnulus( HDC hDC, ANNULUS* pAnnulus, int Space );

// ��������CKDisplayRotRectLine
// ��  �ܣ���һ����������ʾ����·����λ��
// ��  ����hDC ��ʾ�豸DC���
// ��  ����pAnnulus һ��ָ�������ݽṹ��ָ��
// ��  ����Space ÿ���������ػ�һ����
CKVIS_API void CKDisplayLineToRotRect( HDC hDC, ROTRECT* pRotRect, int Directional, int Space );





/***************************************************************************
*-------------------------------- �򵥼���ѧ -------------------------------*
****************************************************************************
*
*	��Ҫ����һЩ���õļ򵥼��μ���
*
****************************************************************************/

/**************** �궨�� ****************/

// Directional - ����
#define LFP_LEVEL		0	// ˮƽ����
#define LFP_VERTICAL	1	// ��ֱ����

/************ �ṹ���Ͷ��� **************/

// CKGetLinesFromMatrixPoints - ����ѡ��
typedef struct tagLFPOPTION {
	int		LineMode;		// �ߵ�ģʽ
	int		Directional;	// �������ã�ˮƽ����LFP_LEVEL�ʹ�ֱ����LFP_VERTICAL
	int		MinCount;		// �����ж��ٸ����������һ����
	float	MinSpace;		// ������֮�����С����
	float	MaxSpace;		// ������֮���������
	float	ToleAngle;		// һ�����ϵ����е�֮��ĽǶȱ仯��Χ
} LFPOPTION, *PLFPOPTION;

/************* �������� **************/

// ��������CKRotationImage
// ��  �ܣ���ͼ�������ת
// ��  ����hDest Ŀ��ͼ�����������ת���ͼ��
// ��  ����hSource ԭͼ��������תǰ��ͼ��
// ��  ����Angle ��Ҫ��ת�ĽǶ�
// ��  �أ��ɹ�����TRUE������FALSE
CKVIS_API BOOL CKRotationImage( HIMAGE hDest, HIMAGE hSource, float Angle );

// ��������CKScalingImage
// ��  �ܣ���ͼ����б�������
// ��  ����hDest Ŀ��ͼ������������ź��ͼ��
// ��  ����hSource ԭͼ����������ǰ��ͼ��
// ��  ����Scale ���ű���
// ��  �أ��ɹ�����TRUE������FALSE
CKVIS_API BOOL CKScalingImage( HIMAGE hDest, HIMAGE hSource, float Scale );

// ��������CKMirrorImage
// ��  �ܣ���ͼ���������ת��
// ��  ����hImage ��Ҫת�õ�ͼ����
// ��  �أ��ɹ�����TRUE������FALSE
CKVIS_API BOOL CKMirrorImage( HIMAGE hImage, int MirrorMode );

// ��������CK2PointDistance
// ��  �ܣ���������ľ���
// ��  ����point1 ��һ���������
// ��  ����point2 �ڶ����������
// ��  �أ�����������ľ���
CKVIS_API double CK2PointDistance( FPOINT* point1, FPOINT* point2 );

// ��������CK2PointAngle
// ��  �ܣ���������ĽǶ�
// ��  ����point1 ��һ���������
// ��  ����point2 �ڶ����������
// ��  �أ�����������ľ���
CKVIS_API double CK2PointAngle( FPOINT* point1, FPOINT* point2 );

// ��������CK2PointCenter
// ��  �ܣ�������������ĵ�
// ��  ����point1 ��һ���������
// ��  ����point2 �ڶ����������
// ��  �أ���������������ĵ�
CKVIS_API FPOINT CK2PointCenter( FPOINT* point1, FPOINT* point2 );

// ��������CK3PointAngle
// ��  �ܣ����3����ļн�
// ��  ����point1 ԭ������
// ��  ����point2 ��һ���������
// ��  ����point3 �ڶ����������
// ��  �أ����ؼнǵĽǶ�
CKVIS_API double CK3PointAngle( FPOINT *point1, FPOINT *point2, FPOINT *point3 );

// ��������CK3PointRound
// ��  �ܣ�3������һ��Բ
// ��  ����point1 ��һ���������
// ��  ����point2 �ڶ����������
// ��  ����point3 �������������
// ��  �أ�����һ��Բ������
CKVIS_API FROUND CK3PointRound( FPOINT* point1, FPOINT* point2, FPOINT* point3 );

// ��������CK2LineJunction
// ��  �ܣ��������ֱ�ߵ��ཻ��
// ��  ����pLine1 ��һ���ߵ�����
// ��  ����pLine2 �ڶ����ߵ�����
// ��  �أ��ɹ���������ֱ�ߵ��ཻ��
CKVIS_API FPOINT CK2LineJunction( FLINE* pLine1, FLINE* pLine2 );

// ��������CKPointsAverage
// ��  �ܣ��������ƽ��ֵ
// ��  ����points ���е������
// ��  ����pointCount �������
// ��  �أ��������е��ƽ��ֵ
CKVIS_API FPOINT CKPointsAverage( FPOINT* points, int pointCount );

// ��������CKGetLinesFromMatrixPoints
// ��  �ܣ���һ�����������м���ˮƽ��ֱ��
// ��  ����points �������������������
// ��  ����pointCount ����������
// ��  ����Option ��صĲ������μ�LFPOPTION
// ��  ����retCount ���ص��ߵ�����
// ��  �أ��ɹ������������������ݣ����򷵻�NULL
CKVIS_API FLINE* CKGetLinesFromMatrixPoints( FPOINT* points, int pointCount, LFPOPTION* Option, int* retCount );





/***************************************************************************
*-------------------------------- ��λʶ�� --------------------------------*
****************************************************************************
*
*	��Ҫ�������嶨λ
*
****************************************************************************/

/**************** �궨�� ****************/

// BarcodeType - �������� 
#define BARCODE_UPC_A		0
#define BARCODE_UPC_E		1
#define BARCODE_EAN_8		2
#define BARCODE_EAN_13		3
#define BARCODE_CODE_39		4

/************ �ṹ���Ͷ��� **************/

// CKGetModelInfo - ģ����Ϣͷ����
typedef struct tagMODELINFO {
	int		 MinAngle;		// ģ�����С�Ƕȣ�-180~180����
	int		 MaxAngle;		// ģ������Ƕȣ�-180~180����
	int		 MinScale;		// ģ�����С���������հٷֱȣ�100Ϊ1������
	int		 MaxScale;		// ģ��������������հٷֱȣ�100Ϊ1������
	int		 ModWidth;		// ģ��Ŀ�ȣ�
	int		 ModHeight;		// ģ��ĸ߶ȣ�
} MODELINFO;

// CKRoiToModel��CKLearnModel��CKUpdateModel - ѧϰ�����ģ�����ѡ��
typedef struct tagLEARNOPTION {
	int		MinAngle;		// ��Ҫ����ģ�����С�Ƕȣ�-180~180����
	int		MaxAngle;		// ��Ҫ����ģ������Ƕȣ�-180~180����
	int		MinScale;		// ��Ҫ����ģ�����С���������հٷֱȣ�100Ϊ1������
	int		MaxScale;		// ��Ҫ����ģ��������������հٷֱȣ�100Ϊ1������
	int		Distance;		// ���룬Ĭ��Ϊ1������ڴ���ģ����������ֵ��ѹ��ģ�壬�Ա������ռ�ÿռ�Ĵ�С�������ٶȣ�ֻ��CKLearnModelʱ���ã�
	int		Threshold;		// ��Ե�ݶ���ֵ��ֻ����Щ�ݶȴ��ڸ���ֵ�ı�Ե��ű���������ֻ��CKLearnModelʱ���ã�
	int		NeedEdge;		// ��̵ı�Ե������������Щ����С�ڸ�ֵ�ı�Ե���Ա����������ֻ��CKLearnModelʱ���ã�
} LEARNOPTION, *PLEARNOPTION;

// CKFindModel - ����ģ�����ѡ��
typedef struct tagFINDOPTION {
	int		MinScore;		// ����ƥ��������С������
	int		NeedEdge;		// ��̵ı�Ե������������Щ����С�ڸ�ֵ�ı�Ե���Ա����������
	int		Threshold;		// ��Ե�ݶ���ֵ��ֻ����Щ�ݶȴ��ڸ���ֵ�ı�Ե��ű���������
	int		FindCount;		// ��Ҫ�����ĸ�����
	int		FindLevel;		// ����ˮƽ(1~10)������ˮƽԽ�ߣ�����������ƥ�����Խ�࣬���ٶȻ������
	int		Superpose;
} FINDOPTION, *PFINDOPTION;

// CKFindModel - ����ģ�巵������
typedef struct tagMATCH {
	float	Angle;			// ��ƥ�����ĽǶȣ�
	float	Scale;			// ��ƥ�����ı�����
	float	Score;			// ��ƥ�����ķ���(���ƶ�)��
	float	CenterX;		// ��ƥ����������x�����ꣻ
	float	CenterY;		// ��ƥ����������y�����ꣻ
	float	Width;			// ��ƥ�����Ŀ�ȣ�
	float	Height;			// ��ƥ�����ĸ߶ȣ�
} MATCH, *PMATCH;

// CKReadBarCode - ������ѡ��ṹ
typedef struct tagRBCOPTION {
	int		BarcodeType;
	int		Threshold;
	int		LineSpace;
	int		Smoothness;
} RBCOPTION, *PRBCOPTION;

// CKReadBarCode - �����ⷵ������
typedef struct tagBARCODE {
	char	CodeText[256];
	int		CodeLenght;
	int		BarcodeType;
} BARCODE, *PBARCODE;

/************* �������� **************/

// ��������CKRoiToModel
// ��  �ܣ���ROI�ı�Ե����ת��Ϊģ�����ݣ�ֻ֧�־��κ�Բ�ε�ROI
// ��  ����hRoi ROI���ݾ��
// ��  ����Option ��صĲ������μ�LEARNOPTION
// ��  �أ��ɹ�����һ��ģ���������򷵻�NULL
CKVIS_API HMODEL CKRoiToModel( HROI hRoi, LEARNOPTION* Option );

// ��������CKLearnModel
// ��  �ܣ�ѧϰģ�壬��ͼ������ȡ��Ե������Ϊģ������
// ��  ����hImage ͼ����
// ��  ����pRect ѧϰ�ķ�Χ��NULLΪ����ͼ��
// ��  ����Option ��صĲ������μ�LEARNOPTION
// ��  �أ��ɹ�����һ��ģ���������򷵻�NULL
CKVIS_API HMODEL CKLearnModel( HIMAGE hImage, RECT* pRect, LEARNOPTION* Option );

// ��������CKLoadModel
// ��  �ܣ����ļ���װ��һ���Դ��ڵ�ģ��
// ��  ����pszFileName ģ���ļ���ȫ·����
// ��  �أ��ɹ�����һ��ģ���������򷵻�NULL
CKVIS_API HMODEL CKLoadModel( const char* pszFileName );

// ��������CKSaveModel
// ��  �ܣ���ģ�屣�浽�ļ���ȥ
// ��  ����pszFileName ����ģ���ļ���ȫ·����
// ��  ����hModel ģ����
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKSaveModel( const char* pszFileName, HMODEL hModel );

// ��������CKSetModelPointState
// ��  �ܣ�����ģ��ı�Ե���״̬
// ��  ����hModel ģ����
// ��  ����pRect ���õķ�Χ��ֻ���ڸ÷�Χ�ڵı�Ե���״̬�Ż�ı�
// ��  ����State ״̬��0Ϊ��ʹ�øõ���Ϊģ��������1Ϊʹ��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKSetModelPointState( HMODEL hModel, RECT *pRect, int State );

// ��������CKUpdateModel
// ��  �ܣ��ڸı��Ե��״̬�͸ı�ǶȺͱ����任ʱ���øú�������ģ��
// ��  ����hModel ģ����
// ��  ����Option ��صĲ������μ�LEARNOPTION
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKUpdateModel( HMODEL hModel, LEARNOPTION* Option );

// ��������CKGetModelInfo
// ��  �ܣ���ȡģ��������Ϣ
// ��  ����hModel ģ����
// ��  ����pModelInfo ����ģ��������Ϣ���μ�MODELINFO
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKGetModelInfo( HMODEL hModel, MODELINFO* pModelInfo );

// ��������CKCopyModel
// ��  �ܣ�����ģ��
// ��  ����hModel ģ����
// ��  �أ��ɹ�����һ���µ�ģ�壬���򷵻�NULL
CKVIS_API HMODEL CKCopyModel( HMODEL hModel );

// ��������CKDestroyModel
// ��  �ܣ�ģ���ڲ��ú��øú�������
// ��  ����hModel ģ����
CKVIS_API void CKDestroyModel( HMODEL hModel );

// ��������CKDisplayModel
// ��  �ܣ�����Ļ����ʾģ��ı�Ե��
// ��  ����hDC ��ʾ�豸��DC���
// ��  ����hModel ģ����
// ��  ����CX ��ʾģ�������x
// ��  ����CY ��ʾģ�������y
// ��  ����Angle ��ʾģ��ĽǶ�
// ��  ����Scale ��ʾģ��ı���
// ��  ����Color1 ״̬Ϊ1�ı�Ե����ɫ
// ��  ����Color2 ״̬Ϊ0�ı�Ե����ɫ
CKVIS_API void CKDisplayModel( HDC hDC, HMODEL hModel, float cx, float cy, float Angle, float Scale, int Color1, int Color2 );

// ��������CKFindModel
// ��  �ܣ���һ��ͼ����������ģ�����Ƶ�����
// ��  ����hImage ͼ����
// ��  ����pRect ������Χ��NULLΪ����ͼ��
// ��  ����hModel ģ����
// ��  ����Option ��������ز������μ�FINDOPTION
// ��  ����retCount ������������ƥ�����ĸ���
// ��  �أ��ɹ�����ƥ������������ݣ����򷵻�NULL
CKVIS_API MATCH* CKFindModel( HIMAGE hImage, RECT* pRect, HMODEL hModel, FINDOPTION* Option, int* retCount );

// ��������CKDisplayMatch
// ��  �ܣ�����Ļ����ʾһ��ƥ�����
// ��  ����hDC ��ʾ�豸��DC���
// ��  ����pMatch ƥ���������
// ��  ����Color ��ʾ����ɫ
CKVIS_API void CKDisplayMatch( HDC hDC, MATCH* pMatch, int Color );

// ��������CKLearnPattern
// ��  �ܣ��Ҷ�ģ��ѧϰ
// ��  ����hImage ͼ����
// ��  ����pRect ѧϰ�ķ�Χ��NULLΪ����ͼ��
// ��  �أ��ɹ����ػҶ�ģ�����ݣ����򷵻�NULL
CKVIS_API BYTE* CKLearnPattern( HIMAGE hImage, RECT* pRect );

// ��������CKMatchPattern
// ��  �ܣ��Ҷ�ģ��ƥ��
// ��  ����hImage ͼ����
// ��  ����pRect ������Χ��NULLΪ����ͼ��
// ��  �أ��ɹ�����ƥ������������ݣ����򷵻�NULL
CKVIS_API MATCH* CKMatchPattern( HIMAGE hImage, RECT* pRect, BYTE* Pattern, int MinScore, int* retCount );

// ��������CKReadBarCode
// ��  �ܣ���һЩ���õ�������м��
// ��  ����hImage ͼ����
// ��  ����pRRect �������ڵ�λ��
// ��  ����Option ���������ز������μ�RBCOPTION
// ��  �أ��ɹ�����ƥ������������ݣ����򷵻�NULL
CKVIS_API BARCODE* CKReadBarCode( HIMAGE hImage, ROTRECT* pRRect, RBCOPTION* Option );





/***************************************************************************
*-------------------------------- ��ɫ���� --------------------------------*
****************************************************************************
*
*	��Ҫ���ڲ�ɫ���
*
****************************************************************************/

/************ �ṹ���Ͷ��� **************/

// CKColorHistogram - ��ɫֱ��ͼ��������
typedef struct tagCOLORHISTOGRAM {
	int		histogSize;
	int*	Channels1;
	int*	Channels2;
	int*	Channels3;
} COLORHISTOGRAM, *PCOLORHISTOGRAM;

// CKGetColorInfo - ��ɫ��Ϣ��������
typedef struct tagCOLORINFO {
	float	rValue;
	float	gValue;
	float	bValue;
} COLORINFO, *PCOLORINFO;

/************* �������� **************/

// ��������CKColorHistogram
// ��  �ܣ���ȡͼ��Ĳ�ɫֱ��ͼ
// ��  ����hImage ͼ����
// ��  ����pRect �������NULLΪ����ͼ��
// ��  ����ColorMode ��ɫ�ռ�ģʽ
// ��  �أ��ɹ�����ֵ��ͼ���ݣ����򷵻�NULL
CKVIS_API COLORHISTOGRAM* CKColorHistogram( HIMAGE hImage, RECT *pRect, int ColorMode );

// ��������CKGetColorInfo
// ��  �ܣ���ȡͼ��ָ�������ڵĲ�ɫ��Ϣ
// ��  ����hImage ͼ����
// ��  ����hRoi ��ȡ���򣬿�֧��RECT��ROUND��ROTRECT���͵�ROI��NULLΪ����ͼ��
// ��  �أ��ɹ����ز�ɫ������Ϣ�����򷵻�NULL
CKVIS_API COLORINFO* CKGetColorInfo( HIMAGE hImage, HROI hRoi );

// ��������CKMatchColorInfo
// ��  �ܣ��Ƚ�������ɫ��Ϣ�Ƿ�����
// ��  ����pColorInfo1 ��ɫ��Ϣ1
// ��  ����pColorInfo2 ��ɫ��Ϣ2
// ��  �أ�����������ɫ��Ϣ��ƥ��̶�
CKVIS_API float CKMatchColorInfo( COLORINFO* pColorInfo1, COLORINFO* pColorInfo2 );

// ��������CKColorToGray
// ��  �ܣ���ɫת��Ϊ�Ҷ�ͼ
// ��  ����colorImage ����Ĳ�ɫͼ��
// ��  ����grayImage ����Ĳ�ɫͼ��
// ��  �أ��ɹ�����TRUE�����򷵻�FALSE
CKVIS_API BOOL CKColorToGray( const HIMAGE colorImage, HIMAGE grayImage, int Chunnel );
