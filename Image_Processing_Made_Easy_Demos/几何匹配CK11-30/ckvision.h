
/************************************************************
// 创科机器视觉 版权所有(2007) 
// 模块名称：ckvision.dll
// 创建时间：2005-??-??
// 修改时间：2007-??-??
*************************************************************/
#ifdef CKVISION_EXPORTS
#define CKVIS_API extern "C" __declspec(dllexport)
#else
#define CKVIS_API extern "C" __declspec(dllimport)
#endif

/* Image Handle*/
typedef unsigned char* HIMAGE;	// 图像句柄
/* Roi Handle*/
typedef unsigned char* HROI;	// ROI句柄
/* Model Handle */
typedef unsigned char* HMODEL;	// 模板句柄

// 结构定义

/* Float Point */
typedef struct tagFPOINT
{
	float	x;			// x方向
	float	y;			// y方向
} FPOINT, *PFPOINT;

/* Float Line */
typedef struct tagFLINE
{
	FPOINT	pt1;		// 起点
	FPOINT	pt2;		// 终点
} FLINE, *PFLINE;

/* Float Rect */
typedef struct tagFRECT
{
	float	left;		// 左边
	float	top;		// 上边
	float	right;		// 右边
	float	bottom;		// 底边
} FRECT, *PFRECT;

/* Float RRect */
typedef struct tagFROTRECT
{
	float	angle;		// 旋转角度
	float	left;		// 左边
	float	top;		// 上边
	float	right;		// 右边
	float	bottom;		// 底边
} FROTRECT, *PFROTRECT;

/* Float Round */
typedef struct tagFROUND
{
	float	cx;			// 中心x
	float	cy;			// 中心y
	float	radii;		// 半径
} FROUND, *PFROUND;

/* Ftriangle 等边三角形*/
typedef struct tagFTRIANGLE
{
	float	angle;		// 旋转角度
	FPOINT	center;		// 三角形的中心
	float	sidelen;	// 三角形边长
} FTRIANGLE, *PFTRIANGLE;

#ifndef _WINDEF_

/* int Point */
typedef struct tagPOINT
{
	int		x;			// x方向
	int		y;			// y方向
} POINT, *PPOINT;

/* int Rect */
typedef struct tagRECT
{
	int		left;		// 左边
	int		top;		// 上边
	int		right;		// 右边
	int		bottom;		// 底边
} RECT, *PRECT;

#endif

/* int Line */
typedef struct tagLINE
{
	POINT	pt1;		// 起点
	POINT	pt2;		// 终点
} LINE, *PLINE;

/* int Round */
typedef struct tagROUND
{
	int		cx;			// 中心x
	int		cy;			// 中心y
	int		radii;		// 半径
} ROUND, *PROUND;

/* int DRound */
typedef struct tagDROUND
{
	int		cx;			// 中心x
	int		cy;			// 中心y
	int		radii1;		// 外圆半径
	int		radii2;		// 内圆半径
} DROUND, *DPROUND;

/* int Annulus */
typedef struct tagANNULUS
{
	int		cx;			// 中心x
	int		cy;			// 中心y
	int		radii1;		// 外圆半径
	int		radii2;		// 内圆半径
	float	angle1;		// 起始角度
	float	angle2;		// 结束角度
} ANNULUS, *PANNULUS;

/* int RotateRect */
typedef struct tagROTRECT
{
	float	angle;		// 旋转角度
	int		left;		// 左边
	int		top;		// 上边
	int		right;		// 右边
	int		bottom;		// 底边
} ROTRECT, *PROTRECT;

/* double - rect */
typedef struct tagDROTRECT
{
	float	angle;		// 旋转角度
	RECT	rect1;		// 外矩形
	RECT	rect2;		// 内矩形
} DROTRECT, *PDROTRECT;

/* triangle 等边三角形*/
typedef struct tagTRIANGLE
{
	float	angle;		// 旋转角度
	POINT	center;		// 三角形的中心
	int		sidelen;	// 三角形边长
} TRIANGLE, *PTRIANGLE;
 
/* 坐标系统 */
typedef struct tagCOORDINATE 
{
	double	Angle;		// 角度
	FPOINT	Point;		// 原点
} COORDINATE, *PCOORDINATE;


// 获取加密锁状态
// 成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGetDogState( void );

/***************************************************************************
*--------------------------------- 图形显示 -------------------------------*
****************************************************************************
*
*	用于显示一些图形
*
****************************************************************************/

/************* 函数部分 **************/

// 函数名：CKSetPointStyle
// 功  能：设置显示坐标点的风格
// 参  数：dStyle 风格(0、1、2)
// 返  回：旧的风格
CKVIS_API DWORD CKSetPointStyle( DWORD dStyle );

// 函数名：CKDisplayPoint
// 功  能：在屏幕上显示一个坐标点
// 参  数：hDC 设备的绘图DC句柄
// 参  数：point 坐标点的数据
CKVIS_API void CKDisplayPoint( HDC hDC, POINT* point );

// 函数名：CKDisplayFPoint
// 功  能：在屏幕上显示一个浮点数坐标点，实际显示为整数
// 参  数：hDC 设备的绘图DC句柄
// 参  数：point 浮点数坐标点的数据
CKVIS_API void CKDisplayFPoint( HDC hDC, FPOINT* point );

// 函数名：CKDisplayLine
// 功  能：在屏幕上显示一条线
// 参  数：hDC 设备的绘图DC句柄
// 参  数：pLine 线的数据
CKVIS_API void CKDisplayLine( HDC hDC, LINE* pLine );

// 函数名：CKDisplayFLine
// 功  能：在屏幕上显示一条浮点数线，实际显示为整数
// 参  数：hDC 设备的绘图DC句柄
// 参  数：pLine 浮点数线的数据
CKVIS_API void CKDisplayFLine( HDC hDC, FLINE* pLine );

// 函数名：CKDisplayRect
// 功  能：在屏幕上显示一个矩形
// 参  数：hDC 设备的绘图DC句柄
// 参  数：pRect 矩形的数据
CKVIS_API void CKDisplayRect( HDC hDC, RECT* pRect );

// 函数名：CKDisplayFRect
// 功  能：在屏幕上显示一个浮点数矩形，实际显示为整数
// 参  数：hDC 设备的绘图DC句柄
// 参  数：pRect 浮点数矩形的数据
CKVIS_API void CKDisplayFRect( HDC hDC, FRECT* pRect );

// 函数名：CKDisplayRound
// 功  能：在屏幕上显示一个圆形
// 参  数：hDC 设备的绘图DC句柄
// 参  数：pRound 圆形的数据
CKVIS_API void CKDisplayRound( HDC hDC, ROUND* pRound );

// 函数名：CKDisplayFRound
// 功  能：在屏幕上显示一个浮点数圆形，实际显示为整数
// 参  数：hDC 设备的绘图DC句柄
// 参  数：pRound 浮点数圆形的数据
CKVIS_API void CKDisplayFRound( HDC hDC, FROUND* pRound );

// 函数名：CKDisplayDRound
// 功  能：在屏幕上显示一个双圆形
// 参  数：hDC 设备的绘图DC句柄
// 参  数：pDRound 双圆形的数据
CKVIS_API void CKDisplayDRound( HDC hDC, DROUND* pDRound );

// 函数名：CKDisplayAnnulus
// 功  能：在屏幕上显示一个环形
// 参  数：hDC 设备的绘图DC句柄
// 参  数：pAnnulus 环形的数据
CKVIS_API void CKDisplayAnnulus( HDC hDC, ANNULUS* pAnnulus );

// 函数名：CKDisplayRotRect
// 功  能：在屏幕上显示一个带有角度的矩形
// 参  数：hDC 设备的绘图DC句柄
// 参  数：pRRect 带有角度的矩形的数据
CKVIS_API void CKDisplayRotRect( HDC hDC, ROTRECT* pRRect );

// 函数名：CKDisplayFRotRect
// 功  能：在屏幕上显示一个浮点数带有角度的矩形
// 参  数：hDC 设备的绘图DC句柄
// 参  数：pRRect 浮点数带有角度的矩形的数据
CKVIS_API void CKDisplayFRotRect( HDC hDC, FROTRECT* pRRect );

// 函数名：CKDisplayTriangle
// 功  能：在屏幕上显示一个三角形
// 参  数：hDC 设备的绘图DC句柄
// 参  数：pTriangle 三角形数据
CKVIS_API void CKDisplayTriangle( HDC hDC, TRIANGLE* pTriangle );

// 函数名：CKDisplayArrowhead
// 功  能：在屏幕上显示一坐标系
// 参  数：hDC 设备的绘图DC句柄
// 参  数：point1 原点坐标
// 参  数：point2 终点坐标
CKVIS_API void CKDisplayArrowhead( HDC hDC, POINT* point1, POINT* point2 );

// 函数名：CKDisplayCoordinate
// 功  能：在屏幕上显示一坐标系
// 参  数：hDC 设备的绘图DC句柄
// 参  数：pCoordinate 坐标系数据
CKVIS_API void CKDisplayCoordinate( HDC hDC, COORDINATE* pCoordinate );





/***************************************************************************
*---------------------------------- ROI操作 -------------------------------*
****************************************************************************
*
*	ROI - 感性趣区域
*
****************************************************************************/

/*************** 宏定义 *****************/

// RoiType - ROI类型
#define ROI_NULL			0	// NULL
#define ROI_LINE			1	// 线形ROI
#define ROI_RECT			2	// 矩形ROI
#define ROI_ROTRECT			3	// 可旋转矩形ROI
#define ROI_DROTRECT		4	// 可旋转双矩形ROI
#define ROI_ROUND			5	// 圆形ROI
#define ROI_DROUND			6	// 双圆形ROI
#define ROI_ANNULUS			7	// 圆环形ROI

/************* 函数部分 **************/

// 函数名：CKCreateRoi
// 功  能：创建一个ROI(感性趣的区域、位置)
// 参  数：Type 创建ROI的类型
// 返  回：成功返回ROI数据句柄，否则返回NULL
CKVIS_API HROI CKCreateRoi( int Type );

// 函数名：CKSetRoi
// 功  能：以两个坐标点来调整ROI，不同的ROI类型效果不同，主要用于鼠标拉画ROI的情况
// 参  数：hRoi 需要进行调整的ROI句柄
// 参  数：x1 第一个坐标点的x轴
// 参  数：y1 第一个坐标点的y轴
// 参  数：x2 第二个坐标点的x轴
// 参  数：y2 第二个坐标点的y轴
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKSetRoi( HROI hRoi, int x1, int y1, int x2, int y2 );

// 函数名：CKGetRoiNode
// 功  能：获取ROI的调节点索引值，不同的ROI类型索引值不同，主要用于鼠标拉画ROI的情况
// 参  数：hRoi 获取调节点的ROI句柄
// 参  数：x 当前光标的坐标点x轴
// 参  数：y 当前光标的坐标点y轴
// 返  回：如果当前点在ROI的某个调节点内，则返回该调节点的索引值，否则返回NULL
CKVIS_API int CKGetRoiNode( HROI hRoi, int x, int y );
 
// 函数名：CKAdjustRoi
// 功  能：根据调节点的索引值，对ROI的相应位置进行调整，主要用于鼠标拉画ROI的情况
// 参  数：hRoi 需要进行调整的ROI句柄
// 参  数：Node 调节点的索引值
// 参  数：x 当前光标的坐标点x轴
// 参  数：y 当前光标的坐标点y轴
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKAdjustRoi( HROI hRoi, int Node, int x, int y );

// 函数名：CKSetRoiCursor
// 功  能：设置ROI的光标，当鼠标位于不同的调节点会产生不同的光标形状
// 参  数：hRoi ROI句柄
// 参  数：Node 调节点的索引值
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKSetRoiCursor( HROI hRoi, int Node );

// 函数名：CKCopyRoi
// 功  能：复制一个ROI
// 参  数：hRoi 源ROI句柄
// 返  回：成功返回一个该ROI的拷贝，否则返回NULL
CKVIS_API HROI CKCopyRoi( HROI hRoi );

// 函数名：CKGetRoiType
// 功  能：获取ROI的类型
// 参  数：hRoi ROI句柄
// 返  回：成功返回该ROI的类型，否则返回NULL
CKVIS_API int CKGetRoiType( HROI hRoi );

// 函数名：CKFreeRoi
// 功  能：释放一个ROI的内存
// 参  数：hRoi ROI句柄
CKVIS_API void CKFreeRoi( HROI hRoi );

// 函数名：CKMoveRoi
// 功  能：移动ROI
// 参  数：hRoi 需要移动的ROI句柄
// 参  数：x x方向的移动偏移量
// 参  数：y y方向的移动偏移量
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKMoveRoi( HROI hRoi, int x, int y );

// 函数名：CKScalingRoi
// 功  能：对ROI进行缩放
// 参  数：hRoi 需要进行缩放的ROI句柄
// 参  数：Scale 缩放倍数
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKScalingRoi( HROI hRoi, double Scale );

// 函数名：CKTransformRoi
// 功  能：转换ROI的空间坐标系，主要用在定位方面的坐标系实时转换
// 参  数：hRoi 需要进行转换的ROI句柄
// 参  数：pOldCoord 旧的、当前所在的坐标系
// 参  数：pNewCoord 新的、需要转换到的坐标系
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKTransformRoi( HROI hRoi, COORDINATE* pOldCoord, COORDINATE* pNewCoord );

// 函数名：CKTransformPoint
// 功  能：转换一个坐标点的空间坐标系
// 参  数：point 指向FPOINT型的指针
// 参  数：pOldCoord 旧的、当前所在的坐标系
// 参  数：pNewCoord 新的、需要转换到的坐标系
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKTransformPoint( FPOINT* point, COORDINATE* pOldCoord, COORDINATE* pNewCoord );

// 函数名：CKDisplayRoi
// 功  能：在屏幕上显示一个ROI
// 参  数：hDC 设备的绘图DC句柄
// 参  数：hRoi 需要显示的ROI句柄
// 参  数：Color 显示ROI的颜色
CKVIS_API void CKDisplayRoi( HDC hDC, HROI hRoi, int Color );

// 函数名：CKDisplayRoiNode
// 功  能：在屏幕上显示一个ROI的所有调节点
// 参  数：hDC 设备的绘图DC句柄
// 参  数：hRoi 需要显示的ROI句柄
// 参  数：Color 显示调节点的颜色
CKVIS_API void CKDisplayRoiNode( HDC hDC, HROI hRoi, int Color );

// 函数名：CKDisplayRoiSign
// 功  能：在ROI中心显示一个字符标签
// 参  数：hDC 设备的绘图DC句柄
// 参  数：hRoi 需要显示的ROI句柄
// 参  数：lpszSign 标签字符串
CKVIS_API void CKDisplayRoiSign( HDC hDC, HROI hRoi, LPCSTR lpszSign );

// 函数名：CKGetRoiFrame
// 功  能：获取ROI的RECT
// 参  数：hRoi 需要显示的ROI句柄
// 参  数：rect 返回的RECT数据
// 返  回：成功返回一个TRUE，否则返回FALSE
CKVIS_API BOOL CKGetRoiFrame( HROI hRoi, RECT& rect );

// 函数名：CKLineToRoi
// 功  能：从一个LINE型指针转换为一个ROI
// 参  数：pLine 指向LINE型指针
// 返  回：成功返回一个线形ROI句柄，否则返回NULL
CKVIS_API HROI CKLineToRoi( LINE* pLine );

// 函数名：CKRectToRoi
// 功  能：从一个RECT型指针转换为一个ROI
// 参  数：pRect 指向RECT型指针
// 返  回：成功返回一个矩形ROI句柄，否则返回NULL
CKVIS_API HROI CKRectToRoi( RECT* pRect );

// 函数名：CKRoundToRoi
// 功  能：从一个ROUND型指针转换为一个ROI
// 参  数：pRound 指向ROUND型指针
// 返  回：成功返回一个圆形ROI句柄，否则返回NULL
CKVIS_API HROI CKRoundToRoi( ROUND* pRound );

// 函数名：CKDRoundToRoi
// 功  能：从一个DROUND型指针转换为一个ROI
// 参  数：pDRound 指向DROUND型指针
// 返  回：成功返回一个双圆形ROI句柄，否则返回NULL
CKVIS_API HROI CKDRoundToRoi( DROUND* pDRound );

// 函数名：CKAnnulusToRoi
// 功  能：从一个ANNULUS型指针转换为一个ROI
// 参  数：pAnnulus 指向ANNULUS型指针
// 返  回：成功返回一个圆环形ROI句柄，否则返回NULL
CKVIS_API HROI CKAnnulusToRoi( ANNULUS* pAnnulus );

// 函数名：CKRotRectToRoi
// 功  能：从一个ROTRECT型指针转换为一个ROI
// 参  数：pRotRect 指向ROTRECT型指针
// 返  回：成功返回一个可旋转矩形ROI句柄，否则返回NULL
CKVIS_API HROI CKRotRectToRoi( ROTRECT* pRotRect );

// 函数名：CKGetLine
// 功  能：锁定ROI的内部数据，ROI类型必需为线形，否则会失败
// 参  数：hRoi 需要锁定的ROI句柄
// 返  回：成功返回指向该ROI内部的线形数据指针，否则返回NULL		
CKVIS_API LINE* CKGetLine( HROI hRoi );

// 函数名：CKGetRect
// 功  能：锁定ROI的内部数据，ROI类型必需为矩形，否则会失败
// 参  数：hRoi 需要锁定的ROI句柄
// 返  回：成功返回指向该ROI内部的矩形数据指针，否则返回NULL
CKVIS_API RECT* CKGetRect( HROI hRoi );

// 函数名：CKGetRound
// 功  能：锁定ROI的内部数据，ROI类型必需为圆形，否则会失败
// 参  数：hRoi 需要锁定的ROI句柄
// 返  回：成功返回指向该ROI内部的圆形数据指针，否则返回NULL		
CKVIS_API ROUND* CKGetRound( HROI hRoi );

// 函数名：CKGetDRound
// 功  能：锁定ROI的内部数据，ROI类型必需为双圆形，否则会失败
// 参  数：hRoi 需要锁定的ROI句柄
// 返  回：成功返回指向该ROI内部的双圆形数据指针，否则返回NULL		
CKVIS_API DROUND* CKGetDRound( HROI hRoi );

// 函数名：CKGetAnnulus
// 功  能：锁定ROI的内部数据，ROI类型必需为环形，否则会失败
// 参  数：hRoi 需要锁定的ROI句柄
// 返  回：成功返回指向该ROI内部的圆环数据指针，否则返回NULL		
CKVIS_API ANNULUS* CKGetAnnulus( HROI hRoi );

// 函数名：CKGetRotRect
// 功  能：锁定ROI的内部数据，ROI类型必需为有角度矩形，否则会失败
// 参  数：hRoi 需要锁定的ROI句柄
// 返  回：成功返回指向该ROI内部的有角度矩形数据指针，否则返回NULL
CKVIS_API ROTRECT* CKGetRotRect( HROI hRoi );





/***************************************************************************
*--------------------------------- 图像数据 -------------------------------*
****************************************************************************
*
*	图像数据传输和显示
*
****************************************************************************/

/*************** 宏定义 ***************/

// BitCount - 图像类型
#define IMAGE_GRAY			8		// 8位灰度图像
#define IMAGE_COLOR			24		// 24为彩色图像

// CKThresholdRgbQuad - Modality
#define THOLD_R_HIGH		0x01
#define THOLD_G_HIGH		0x02
#define THOLD_B_HIGH		0x04
#define THOLD_R_LOW			0x08
#define THOLD_G_LOW			0x10
#define THOLD_B_LOW			0x20

/************* 函数部分 **************/

// 函数名：CKCreateImage
// 功  能：创建一个图像句柄
// 参  数：pData 指向图像数据缓冲区的首地址指针，可设为NULL(全部像素为黑色)
// 参  数：BitCount 图像的位数，一般有8、16、24、32，必须跟数据缓冲区的位数对应上
// 参  数：Width 图像的宽度，必须跟数据缓冲区的位数对应上
// 参  数：Height 图像的高度，必须跟数据缓冲区的位数对应上
// 返  回：成功返回一个有效的图像句柄，否则返回NULL		
CKVIS_API HIMAGE CKCreateImage( BYTE* pData, int BitCount, int Width, int Height );

// 函数名：CKGetImageInfo
// 功  能：获取图象的相关信息，位数、宽度、高度
// 参  数：hImage 需要获取信息的图象句柄
// 参  数：BitCount 返回图像的位数，不需要可设为NULL
// 参  数：Width 返回图像的宽度，不需要可设为NULL
// 参  数：Height 返回图像的高度，不需要可设为NULL
// 返  回：成功返回TRUE，否则返回FALSE		
CKVIS_API BOOL CKGetImageInfo( HIMAGE hImage, int* BitCount, int* Width, int* Height );

// 函数名：CKCopyImage
// 功  能：复制图像句柄
// 参  数：hImage 需要复制的源图象句柄
// 返  回：成功返回该图像句柄的一个拷贝，否则返回NULL		
CKVIS_API HIMAGE CKCopyImage( HIMAGE hImage );

// 函数名：CKReplaceImage
// 功  能：用新的图象数据替换目标图像数据，两张图象的位数、宽度和高度必须一样
// 参  数：hSource 来源图象句柄，输入图像
// 参  数：hDest 目标图象句柄，输出图像
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKReplaceImage( HIMAGE hSource, HIMAGE hDest );

// 函数名：CKReplaceImageFromMask
// 功  能：用新的图象数据替换目标图像数据，两张图象的位数、宽度和高度必须一样
// 参  数：hSource 来源图象句柄，输入图像
// 参  数：hDest 目标图象句柄，输出图像
// 参  数：hMask 掩码图像，只替换该图像的当前值大于零的像素
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKReplaceImageFromMask( HIMAGE hSource, HIMAGE hDest, HIMAGE hMask );

// 函数名：CKSetImageBuffer
// 功  能：更新图像数据，将pData的数据复制到hImage中去
// 参  数：hImage 需要更新数据的图象句柄
// 参  数：pData 指向图像数据缓冲区的首地址指针
CKVIS_API void CKSetImageBuffer( HIMAGE hImage, BYTE* pData );

// 函数名：CKSetImageBuffer2
// 功  能：更新图像数据，将pData的数据复制到hImage中去
// 参  数：hImage 需要更新数据的图象句柄
// 参  数：pData 指向图像数据缓冲区的首地址指针
CKVIS_API void CKSetImageBuffer2( HIMAGE hImage, BYTE* pData );

// 函数名：CKGetImageBuffer
// 功  能：获取图像的数据，将hImage的数据复制到pData中去
// 参  数：hImage 需要获取数据的图象句柄
// 参  数：pData 必须是已经分配好的一块内存区域，大小跟hImage一样
CKVIS_API void CKGetImageBuffer( HIMAGE hImage, BYTE* pData );

// 函数名：CKFreeImage
// 功  能：释放图像的内存
// 参  数：hImage 需要释放的图象句柄
CKVIS_API void CKFreeImage( HIMAGE hImage );

// 函数名：CKFreeImage
// 功  能：释放内存
// 参  数：pMemory 指向需要释放的内存块首地址
CKVIS_API void CKFreeMemory( void* pMemory );

// 函数名：CKReadBMPFile
// 功  能：从文件读取一张BMP图片
// 参  数：pszFileName 文件全路径名
// 返  回：成功返回一个图像句柄，否则返回NULL
CKVIS_API HIMAGE CKReadBMPFile( LPCSTR pszFileName );		

// 函数名：CKWriteBMPFile
// 功  能：以BMP格式保存一张图片
// 参  数：pszFileName 文件全路径名
// 参  数：hImage 图像句柄
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKWriteBMPFile( LPCSTR pszFileName, HIMAGE hImage );

// 函数名：CKSetRgbQuad
// 功  能：改变图像的颜色表，可以进行伪彩色显示，只能用在8位图
// 参  数：pRgbQuad 8位图像的颜色表，大小为256，NULL为默认使用256级灰度的颜色表
CKVIS_API void CKSetRgbQuad( RGBQUAD* pRgbQuad );

// 函数名：CKGetRgbQuad
// 功  能：获取图像的颜色表，只能用在8位图
// 参  数：pRgbQuad 8位图像的颜色表，大小为256
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGetRgbQuad( RGBQUAD* pRgbQuad );

// 函数名：CKDisplayImage
// 功  能：正常显示一张图像
// 参  数：hDC 设备的绘图DC句柄
// 参  数：hImage 图象句柄
// 参  数：x 显示图象的左上角x坐标
// 参  数：y 显示图象的左上角y坐标
CKVIS_API void CKDisplayImage( HDC hDC, HIMAGE hImage, int x, int y );

// 函数名：CKDisplayImageEx
// 功  能：放大或缩小显示一张图像
// 参  数：hDC 设备的绘图DC句柄
// 参  数：hImage 图象句柄
// 参  数：x 显示图象的左上角x坐标
// 参  数：y 显示图象的左上角y坐标
// 参  数：scaleX x方向比例
// 参  数：scaleY y方向比例
CKVIS_API void CKDisplayImageEx( HDC hDC, HIMAGE hImage, int x, int y, float scaleX, float scaleY );

// 函数名：CKDisplayThresholdImage
// 功  能：以二值化方式显示一张图像
// 参  数：hDC 设备的绘图DC句柄
// 参  数：hImage 图象句柄
// 参  数：Threshold 二值化阈值
// 参  数：lColor 灰度值小于等于Threshold的颜色
// 参  数：hColor 灰度值大于Threshold的颜色
// 参  数：x 显示图象的左上角x坐标
// 参  数：y 显示图象的左上角y坐标
CKVIS_API void CKDisplayThresholdImage( HDC hDC, HIMAGE hImage, int Threshold, int lColor, int hColor, int x, int y );

// 函数名：CKDisplayImageEx
// 功  能：以二值化方式放大或缩小显示一张图像
// 参  数：hDC 设备的绘图DC句柄
// 参  数：hImage 图象句柄
// 参  数：Threshold 二值化阈值
// 参  数：lColor 灰度值小于等于Threshold的颜色
// 参  数：hColor 灰度值大于Threshold的颜色
// 参  数：x 显示图象的左上角x坐标
// 参  数：y 显示图象的左上角y坐标
// 参  数：scaleX x方向比例
// 参  数：scaleY y方向比例
CKVIS_API void CKDisplayThresholdImageEx( HDC hDC, HIMAGE hImage, int Threshold, int lColor, int hColor, int x, int y, float scaleX, float scaleY );





/***************************************************************************
*--------------------------------- 图像像素 -------------------------------*
****************************************************************************
*
*	图像
*
****************************************************************************/

/*************** 宏定义 ***************/


// AlgorithmImage - Modality
#define	ALGOR_REP			0
#define	ALGOR_ADD			1
#define	ALGOR_SUB			2
#define	ALGOR_AND			3
#define	ALGOR_OR			4
#define	ALGOR_XOR			5
#define	ALGOR_AVE			6

/************* 函数部分 **************/

// 函数名：CKGetPixelValue
// 功  能：获取单个像素的值
// 参  数：hImage 图象句柄
// 参  数：x 相对于图象的x轴坐标
// 参  数：y 相对于图象的y轴坐标
// 返  回：返回当前的像素值
CKVIS_API int CKGetPixelValue( HIMAGE hImage, int x, int y );

// 函数名：CKSetPixelValue
// 功  能：获取单个像素的值
// 参  数：hImage 图象句柄
// 参  数：x 相对于图象的x轴坐标
// 参  数：y 相对于图象的y轴坐标
CKVIS_API void CKSetPixelValue( HIMAGE hImage, int x, int y, int Value );

// 函数名：CKGetRectPixels
// 功  能：获取一个矩形区域范围内的所有像素的平均值
// 参  数：hImage 图象句柄
// 参  数：pRect 一个矩形区域
// 返  回：返回该区域内所有像素的灰度平均值
CKVIS_API float CKGetRectPixels( HIMAGE hImage, RECT *pRect );

// 函数名：CKSetRectPixels
// 功  能：设置一个矩形区域范围内的所有像素的值
// 参  数：hImage 图象句柄
// 参  数：pRect 一个矩形区域
// 参  数：Value 所要设置的灰度值
CKVIS_API void CKSetRectPixels( HIMAGE hImage, RECT *pRect, BYTE Value );

// 函数名：CKGetRoundPixels
// 功  能：获取一个圆形区域范围内的所有像素的平均值
// 参  数：hImage 图象句柄
// 参  数：pRound 一个圆形区域
// 返  回：返回该区域内所有像素的灰度平均值
CKVIS_API float CKGetRoundPixels( HIMAGE hImage, ROUND *pRound );

// 函数名：CKSetRoundPixels
// 功  能：设置一个圆形区域范围内的所有像素的值
// 参  数：hImage 图象句柄
// 参  数：pRound 一个圆形区域
// 参  数：Value 所要设置的灰度值
CKVIS_API void CKSetRoundPixels( HIMAGE hImage, ROUND *pRound, BYTE Value );

// 函数名：CKGetRotRectPixels
// 功  能：获取一个圆形区域范围内的所有像素的平均值
// 参  数：hImage 图象句柄
// 参  数：pRound 一个圆形区域
// 返  回：返回该区域内所有像素的灰度平均值
CKVIS_API float CKGetRotRectPixels( HIMAGE hImage, ROTRECT *pRRect );

// 函数名：CKSetRotRectPixels
// 功  能：设置一个圆形区域范围内的所有像素的值
// 参  数：hImage 图象句柄
// 参  数：pRound 一个圆形区域
// 参  数：Value 所要设置的灰度值
CKVIS_API void CKSetRotRectPixels( HIMAGE hImage, ROTRECT *pRRect, BYTE Value );

// 函数名：CKPointInRect
// 功  能：判断一个点是否在一个矩形之内
// 参  数：Rect 一个矩形区域
// 参  数：point 该点的坐标
// 返  回：如果该点在区域内返回TRUE，否则返回FALSE
CKVIS_API BOOL CKPointInRect( RECT Rect, POINT point );

// 函数名：CKPointInRound
// 功  能：判断一个点是否在一个圆形之内
// 参  数：Round 一个圆形区域
// 参  数：point 该点的坐标
// 返  回：如果该点在区域内返回TRUE，否则返回FALSE
CKVIS_API BOOL CKPointInRound( ROUND Round, POINT point );

// 函数名：CKPointInRotRect
// 功  能：判断一个点是否在一个有角度形矩形之内
// 参  数：RRect 一个有角度形矩形区域
// 参  数：point 该点的坐标
// 返  回：如果该点在区域内返回TRUE，否则返回FALSE
CKVIS_API BOOL CKPointInRotRect( ROTRECT RRect, POINT point );

// 函数名：CKCopyImageRect
// 功  能：复制图像的一个矩形区域
// 参  数：hImage 图象句柄
// 参  数：pRect 复制区域
// 返  回：成功返回一个新的图像句柄，否则返回NULL
CKVIS_API HIMAGE CKCopyImageRect( HIMAGE hImage, RECT* pRect );

// 函数名：CKPasteImage
// 功  能：贴图，将一张图像贴到另一张图像上的指定位置
// 参  数：hImage 源图像句柄
// 参  数：hPaste 贴图图像句柄
// 参  数：hPaste 贴图图像句柄
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKPasteImage( HIMAGE hImage, HIMAGE hPaste, int x, int y );

// 函数名：CKAlgorithmImage
// 功  能：对两张图进行相加、相减、求平均、与、或和异或等操作，结果存于hDest
// 参  数：hSource 来源图像句柄
// 参  数：hDest 目标图像句柄
// 参  数：pRect 计算区域
// 参  数：Modality 计算方式
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKAlgorithmImage( HIMAGE hSource, HIMAGE hDest, RECT* pRect, int Modality );

// 函数名：CKUniteImage
// 功  能：将多张小图像合并成一张大图像，新图像宽度为Width*Row，高度为Height*Col
// 参  数：hImageArray 来源图像数组
// 参  数：ImageCount 来源图像数量
// 参  数：Width 单张图像的宽度，为零或小于零时默认为第一张图像的宽度
// 参  数：Width 单张图像的高度，为零或小于零时默认为第一张图像的高度
// 参  数：Row 行数量
// 参  数：Col 列数量
// 返  回：成功返回合并后的图像，否则返回NULL
CKVIS_API HIMAGE CKUniteImage( HIMAGE* hImageArray, int ImageCount, int Width, int Height, int Row, int Col );





/***************************************************************************
*------------------------------ 图像统计与分析 ----------------------------*
****************************************************************************
*
*	主要用于图像的表面检测和一些简单的定位
*
****************************************************************************/

/**************** 宏定义 ****************/

// Connexity - 连通性 
#define CONNEXITY_4			0	// 四连通
#define CONNEXITY_8			1	// 八连通

// PixelMode - 像素模式
#define PIXEL_DARK			0	// 黑色区域
#define PIXEL_LIGHT			1	// 白色区域

/************ 结构类型定义 **************/

// CKGrayProjection - 投影返回数据
typedef struct tagPROJECTION {
	int		hLenght;		// 水平方向长度
	int*	hProfile;		// 水平方向曲线数据
	int		vLenght;		// 垂直方向长度
	int*	vProfile;		// 垂直方向曲线数据
} PROJECTION, *PPROJECTION;

// CKGetObjects - 对象记数参数选项
typedef struct tagOBJECTOPTION {
	int		MinArea;		// 最小面积(像素数量)
	int		MaxArea;		// 最大面积(像素数量)
	int		MinWidth;		// 最小宽度
	int		MaxWidth;		// 最大宽度
	int		MinHeight;		// 最小高度
	int		MaxHeight;		// 最大高度
	int		Threshold;		// 二值化阈值(0~255)
	int		Connexity;		// 连通性，CONNEXITY_4和CONNEXITY_8
	int		PixelMode;		// 像素模式，PIXEL_DARK和PIXEL_LIGHT
	int		FilBorder;		// 是去除边界对象，TRUE为是，FALSE为否
} OBJECTOPTION, *POBJECTOPTION;

// CKGetObjects - 对象记数返回数据
typedef struct tagOBJECT {
	int		Area;			// 面积，像素数量
	int		Hole;			// 孔数量，在对象中存在的相反值的区域的数量
	float	AveGray;		// 平均灰度，所有像素的灰度平均值
	FPOINT	Center;			// 重心，所有像素的坐标平均
	RECT	NaturBox;		// 外接矩形
} OBJECT, *POBJECT;

// CKPixelAnalyse - 灰度分析返回数据
typedef struct tagPIXANALYSE {
	int		Area;			// 所分析的所有像素总数量
	int		MinGray;		// 最小的灰度值
	int		MaxGray;		// 最大的灰度值
	float	AverGray;		// 平均灰度值
} PIXANALYSE, *PPIXANALYSE;

// CKPixelCount - 像素统计返回数据
typedef struct tagPIXELCOUNT {
	int		AnyCount;		// 全部像素数量
	int		HoldCount;		// 当前像素数量
	float	Percent;		// 当前像素数量和全部像素数量的比
} PIXELCOUNT, *PPIXELCOUNT;

// CKBlobAnalyse - Blob分析参数选项1
typedef struct tagBLOBOPTION {
	int		MinArea;		// 最小面积(像素数量)
	int		MaxArea;		// 最大面积(像素数量)
	int		MinHole;		// 最少孔数
	int		MaxHole;		// 最多孔数
	int		Threshold;		// 二值化阈值(0~255)
	int		Connexity;		// 连通性，CONNEXITY_4和CONNEXITY_8
	int		PixelMode;		// 像素模式，PIXEL_DARK和PIXEL_LIGHT
	int		FilBorder;		// 是去除边界对象，TRUE为是，FALSE为否
} BLOBOPTION, *PBLOBOPTION;

// CKBlobAnalyse - Blob分析参数选项2
typedef struct tagMOREBLOBOPTION {
	float	MinAveGray;		// 最小的灰度平均值(0.0~255.0)
	float	MaxAveGray;		// 最大的灰度平均值(0.0~255.0)
	float	MinRectSur;		// 最小的矩形度(0.0~1.2)
	float	MaxRectSur;		// 最大的矩形度(0.0~1.2)
	float	MinLathySur;	// 最小的细长度(0.0~1.0)
	float	MaxLathySur;	// 最大的细长度(0.0~1.0)
	float	MinLeastWidth;	// 最小的宽度，最小面积外接矩形
	float	MaxLeastWidth;	// 最大的宽度，最小面积外接矩形
	float	MinLeastHeight;	// 最小的高度，最小面积外接矩形
	float	MaxLeastHeight;	// 最大的高度，最小面积外接矩形
} MOREBLOBOPTION, *PMOREBLOBOPTION;

// CKBlobAnalyse - Blob分析返回数据
typedef struct tagBLOBOBJECT {
	int			Area;		// 区域的面积(像素数量)
	int			Hole;		// 区域中孔的数量
	float		AveGray;	// 亮度，区域的所有像素的灰度平均值
	float		RectSur;	// 矩形度，区域面积与最小外接矩形的面积比
	float		LathySur;	// 细长度，最小长宽比
	FPOINT		Center;		// 区域的重心，所有像素的坐标平均值
	RECT		NaturBox;	// 水平方向的外接矩形，不带角度
	FROTRECT	LeastBox;	// 最小面积的外接矩形，带有角度
	int			CHPCount;	// 凸包边缘点数量
	POINT*		CHPoints;	// 凸包边缘的坐标点
} BLOBOBJECT, *PBLOBOBJECT;

// CKGetEdgeContours - 边缘检测参数选项
typedef struct tagEDGEOPTION {
	int		MinLenght;		// 最短边缘
	int		MaxLenght;		// 最长边缘
	int		Threshold;		// 边缘梯度阈值(0~128)
} EDGEOPTION, *PEDGEOPTION;

// CKGetEdgeContours - 边缘检测返回数据
typedef struct tagCONEDGE {
	int		Lenght;			// 边缘的长度
	POINT*	Points;			// 边缘的所有坐标点
} CONEDGE, *PCONEDGE;

// CKFindRoundFromEdge - 找圆参数选项
typedef struct tagFREDOPTION {
	float	MinRadii;		// 最小半径，最好在20以上
	float	MaxRadii;		// 最大半径，最好在20以上
	float	MinSample;		// 最小采样率(0.0~1.0)
	float	MinLacuna;		// 最小缺陷度(0.0~1.0)
	float	Tolerance;		// 容忍的误差值，一般为1.0~4.0
} FREOPTION, *PFREDOPTION;

// CKFindRoundFromEdge - 找圆返回数据
typedef struct tagFREROUND {
	float	Sample;			// 采样率
	float	Lacuna;			// 缺陷度
	FROUND	Round;			// 圆数据，参见FROUND
} FREROUND, *PFREROUND;

/************* 函数部分 **************/

// 函数名：CKGrayHistogram
// 功  能：获取图像的灰度值方图
// 参  数：hImage 图像句柄
// 参  数：pRect 检测区域，NULL为整张图像
// 参  数：retSize 返回值方图数组的大小
// 返  回：成功返回值方图数据，否则返回NULL
CKVIS_API int* CKGrayHistogram( HIMAGE hImage, RECT *pRect, int *retSize );

// 函数名：CKGrayProjection
// 功  能：获取图像的灰度投影图
// 参  数：hImage 图像句柄
// 参  数：pRect 检测区域，NULL为整张图像
// 返  回：成功返回投影数据，否则返回NULL
CKVIS_API PROJECTION* CKGrayProjection( HIMAGE hImage, RECT* pRect );

// 函数名：CKBinaryProjection
// 功  能：获取二值图像的投影图
// 参  数：hImage 图像句柄
// 参  数：pRect 检测区域，NULL为整张图像
// 返  回：成功返回投影数据，否则返回NULL
CKVIS_API PROJECTION* CKBinaryProjection( HIMAGE hImage, RECT* pRect );

// 函数名：CKPixelAnalyse
// 功  能：分析图像的灰度平均值、最大值、最小值
// 参  数：hImage 图像句柄
// 参  数：pRect 检测区域，NULL为整张图像
// 返  回：成功返回相关的数据，否则返回NULL
CKVIS_API PIXANALYSE* CKPixelAnalyse( HIMAGE hImage, RECT *pRect );

// 函数名：CKPixelCount
// 功  能：统计图像中黑白区域的像素数量
// 参  数：hImage 图像句柄
// 参  数：pRect 检测区域，NULL为整张图像
// 参  数：PixelMode 检测模式，0为黑色像素，1为白色像素
// 参  数：Threshold 分割阈值，灰度值大于该值为白色，否则为黑色
// 返  回：成功返回相关的数据，否则返回NULL
CKVIS_API PIXELCOUNT* CKPixelCount( HIMAGE hImage, RECT *pRect, int PixelMode, int Threshold );

// 函数名：CKGetObjects
// 功  能：对象计数，计算出图像中连通区域的数量，并给出一些简单的特征
// 参  数：hImage 图像句柄
// 参  数：pRect 检测区域，NULL为整张图像
// 参  数：Option 相关的参数，参见OBJECTOPTION
// 参  数：retCount 返回对象的数量
// 返  回：成功返回所有对象的数据，否则返回NULL
CKVIS_API OBJECT* CKGetObjects( HIMAGE hImage, RECT* pRect, OBJECTOPTION* Option, int* retCount );

// 函数名：CKBlobAnalyse
// 功  能：相对于函数CKGetObjects的基础上给出更多的特征和参数
// 参  数：hImage 图像句柄
// 参  数：pRect 检测区域，NULL为整张图像
// 参  数：Option1 相关的参数，参见BOLBOPTION
// 参  数：Option2 更多的相关的参数，NULL为不使用参数，参见MOREBOLBOPTION
// 参  数：retCount 返回对象的数量
// 返  回：成功返回所有Bolb对象的数据，否则返回NULL
CKVIS_API BLOBOBJECT* CKBlobAnalyse( HIMAGE hImage, RECT* pRect, BLOBOPTION* Option1, MOREBLOBOPTION* Option2, int* retCount );

// 函数名：CKBlobAnalyse2
// 功  能：相对于函数CKGetObjects的基础上给出更多的特征和参数
// 参  数：hImage 图像句柄
// 参  数：hRoi 检测区域，NULL为整张图像
// 参  数：Option1 相关的参数，参见BOLBOPTION
// 参  数：Option2 更多的相关的参数，NULL为不使用参数，参见MOREBOLBOPTION
// 参  数：retCount 返回对象的数量
// 返  回：成功返回所有Bolb对象的数据，否则返回NULL
CKVIS_API BLOBOBJECT* CKBlobAnalyse2( HIMAGE hImage, ROTRECT* pRotRect, BLOBOPTION* Option1, MOREBLOBOPTION* Option2, int* retCount );

// 函数名：CKBlobAnalyse
// 功  能：相对于函数CKGetObjects的基础上给出更多的特征和参数
// 参  数：hImage 图像句柄，支持8位
// 参  数：hMask 8位的二值图像，0值为不检测区域，非0值为检测区域
// 参  数：Option1 相关的参数，参见BOLBOPTION
// 参  数：Option2 更多的相关的参数，NULL为不使用参数，参见MOREBOLBOPTION
// 参  数：retCount 返回对象的数量
// 返  回：成功返回所有Bolb对象的数据，否则返回NULL
CKVIS_API BLOBOBJECT* CKBlobAnalyseFromMask( HIMAGE hImage, HIMAGE hMask, BLOBOPTION* Option1, MOREBLOBOPTION* Option2, int* retCount );

// 函数名：CKGetEdgeContours
// 功  能：获取图象的边缘轮廓
// 参  数：hImage 图像句柄
// 参  数：pRect 检测区域，NULL为整张图像
// 参  数：Option 相关的参数，参见EDGEOPTION
// 参  数：retCount 返回边缘轮廓的数量
// 返  回：成功返回所有轮廓对象的数据，否则返回NULL
CKVIS_API CONEDGE* CKGetEdgeContours( HIMAGE hImage, RECT* pRect, EDGEOPTION* Option, int* retCount );

// 函数名：CKFindRoundFromContour
// 功  能：根据边缘轮廓拟合圆形
// 参  数：ContourArray 轮廓数据数组
// 参  数：ContourCount 数组大小
// 参  数：Option 相关的参数，参见FIROUOPTION
// 参  数：retCount 返回圆形的数量
// 返  回：成功返回所有符合的圆形数据，否则返回NULL
CKVIS_API FREROUND* CKFindRoundFromEdge( CONEDGE *pEdgeArray, int EdgeCount, FREOPTION *Option, int* retCount );

// 函数名：CKConvexHull
// 功  能：求一个有序点集的凸包(最小外接的凸多边形)
// 参  数：PointArray 点集数据数组
// 参  数：PointCount 点集数据的大小，点的数量
// 参  数：retCount 返回凸包顶点的数量
// 返  回：成功返回凸包的所有顶点数据，否则返回NULL
CKVIS_API POINT* CKConvexHull( POINT* PointArray, int PointCount, int *retCount );

// 函数名：CKLeastRectangle
// 功  能：根据凸多边形的顶点求出一个最小面积的外接矩形
// 参  数：ConvexHullPoints 凸包顶点点集数据
// 参  数：PointCount 点集数据的大小，点的数量
// 返  回：返回一个可旋转矩形的数据结构
CKVIS_API FROTRECT CKLeastRectangle( POINT* ConvexHullPoints, int PointCount );

// 函数名：CKGrayLine1
// 功  能：检测一条线上所有点的灰度值
// 参  数：hImage 图像句柄
// 参  数：pLine 指向线形数据结构的指针
// 参  数：retSize 返回所有灰度点的数量
// 返  回：成功返回线上所有点的灰度值，否则返回NULL
CKVIS_API int* CKGrayLine1( HIMAGE hImage, LINE* pLine, int* retSize );

// 函数名：CKGrayLine2
// 功  能：检测一个圆形边上所有点的灰度值
// 参  数：hImage 图像句柄
// 参  数：pRound 指向圆形数据结构的指针
// 参  数：retSize 返回所有灰度点的数量
// 返  回：成功返回线上所有点的灰度值，否则返回NULL
CKVIS_API int* CKGrayLine2( HIMAGE hImage, ROUND* pRound, int* retSize );

// 函数名：CKGrayCompare
// 功  能：图像比较功能
// 参  数：hImage 待比较的图像句柄，比较结果存于该的图像句柄
// 参  数：hPattern 模板图像句柄
// 参  数：hMask 掩摸图像句柄
// 参  数：x hPattern与hImage对应位置，相对于hImage的坐标系的左上角位置x轴
// 参  数：y hPattern与hImage对应位置，相对于hImage的坐标系的左上角位置y轴
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGrayCompare( HIMAGE hImage, HIMAGE hPattern, HIMAGE hMask, int x, int y );

// 函数名：CKMakeMask
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKMakeMask( HIMAGE hImage, HIMAGE hMask );





/***************************************************************************
*------------------------------- 二值化处理 -------------------------------*
****************************************************************************
*
*	二值化
*
****************************************************************************/

/**************** 宏定义 ****************/

/*
// Connexity - 连通性 
#define CONNEXITY_4			0	// 四连通
#define CONNEXITY_8			1	// 八连通

// PixelMode - 像素模式
#define PIXEL_DARK			0	// 黑色区域
#define PIXEL_LIGHT			1	// 白色区域
*/

/************* 函数部分 **************/

// 函数名：CKAutomThreshold
// 功  能：获取图像的二值化自动分割阈值
// 参  数：hImage 图像句柄
// 参  数：pRect 计算的区域，NULL为整张图像
// 返  回：返回二值化分割阈值
CKVIS_API int CKAutomThreshold( HIMAGE hImage, RECT *pRect );

// 函数名：CKGrayThreshold1
// 功  能：对图像进行单阈值二值化
// 参  数：hImage 图像句柄
// 参  数：Threshold 二值化分割阈值
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGrayThreshold1( HIMAGE hImage, int Threshold );

// 函数名：CKGrayThreshold1
// 功  能：对图像进行双阈值二值化
// 参  数：hImage 图像句柄
// 参  数：Threshold1 二值化分割阈值1
// 参  数：Threshold2 二值化分割阈值2
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGrayThreshold2( HIMAGE hImage, int Threshold1, int Threshold2 );

// 函数名：CKDistanceTransform
// 功  能：对二值图像进行距离变换
// 参  数：hImage 图像句柄
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKDistanceTransform( HIMAGE hImage );

// 函数名：CKDistanceTransformEx
// 功  能：对二值图像进行距离变换
// 参  数：hImage 图像句柄
// 参  数：Value1 系数1
// 参  数：Value2 系数2
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKDistanceTransformEx( HIMAGE hImage, int Value1, int Value2 );

// 函数名：CKBinaryContour
// 功  能：对二值图像进行轮廓提取
// 参  数：hImage 图像句柄
// 参  数：Connexity 连通性，0为4连通，1为8连通
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKBinaryContour( HIMAGE hImage, int Connexity );

// 函数名：CKBinaryThin
// 功  能：对二值图像进行细化处理
// 参  数：hImage 图像句柄
// 参  数：PixelMode 0为黑色像素，1为白色像素
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKBinaryThin( HIMAGE hImage, int PixelMode );

// 函数名：CKShearNoises
// 功  能：去除图像突出的区域
// 参  数：hImage 图像句柄
// 参  数：PixelMode 0为黑色区域，1为白色区域
// 参  数：sizeX x方向的...
// 参  数：sizeY y方向的...
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKShearNoises( HIMAGE hImage, int PixelMode, int sizeX, int sizeY );

// 函数名：CKBinaryContour
// 功  能：对二值图像进行腐蚀处理
// 参  数：sourceImage 来源的图像句柄，需要处理的图像
// 参  数：destImage 目标图像句柄，处理后的图像存于该句柄
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKBinaryErosion( HIMAGE sourceImage, HIMAGE destImage );

// 函数名：CKBinaryDilation
// 功  能：对二值图像进行膨胀处理
// 参  数：sourceImage 来源的图像句柄，需要处理的图像
// 参  数：destImage 目标图像句柄，处理后的图像存于该句柄
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKBinaryDilation( HIMAGE sourceImage, HIMAGE destImage );

// 函数名：CKFillHoles
// 功  能：对二值图像进行填充
// 参  数：hImage 图像句柄
// 参  数：PixelMode 0为黑色像素，1为白色像素
// 参  数：Connexity 连通性，0为4连通，1为8连通
// 参  数：ThresholdArea 面积阈值，小于该面积的区域则被填充
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKFillHoles( HIMAGE hImage, int PixelMode, int Connexity, int MinArea );





/***************************************************************************
*------------------------------- 图像预处理 -------------------------------*
****************************************************************************
*
*	主要用于图像预处理
*
****************************************************************************/

/************* 函数部分 **************/

// 函数名：CKGraySmooth
// 功  能：对图像进行平滑处理
// 参  数：hSource 来源的图像句柄，需要处理的图像
// 参  数：hDest 目标图像句柄，处理后的图像存于该句柄
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGraySmooth( HIMAGE hSource, HIMAGE hDest );

// 函数名：CKGraySharp
// 功  能：对图像进行锐化处理
// 参  数：hSource 来源的图像句柄，需要处理的图像
// 参  数：hDest 目标图像句柄，处理后的图像存于该句柄
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGraySharp( HIMAGE hSource, HIMAGE hDest );

// 函数名：CKGrayMedian
// 功  能：对图像进行中值滤波处理
// 参  数：hSource 来源的图像句柄，需要处理的图像
// 参  数：hDest 目标图像句柄，处理后的图像存于该句柄
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGrayMedian( HIMAGE hSource, HIMAGE hDest );

// 函数名：CKGrayErosion
// 功  能：对图像进行中腐蚀处理
// 参  数：hSource 来源的图像句柄，需要处理的图像
// 参  数：hDest 目标图像句柄，处理后的图像存于该句柄
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGrayErosion( HIMAGE hSource, HIMAGE hDest );

// 函数名：CKGrayDilation
// 功  能：对图像进行膨胀处理
// 参  数：hSource 来源的图像句柄，需要处理的图像
// 参  数：hDest 目标图像句柄，处理后的图像存于该句柄
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGrayDilation( HIMAGE hSource, HIMAGE hDest );

// 函数名：CKGrayEdge
// 功  能：对图像进行边缘检测处理
// 参  数：hSource 来源的图像句柄，需要处理的图像
// 参  数：hDest 目标图像句柄，处理后的图像存于该句柄
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGrayEdge( HIMAGE hSource, HIMAGE hDest );

// 函数名：CKGrayReverse
// 功  能：对图像进行反色处理
// 参  数：hSource 来源的图像句柄，需要处理的图像
// 参  数：hDest 目标图像句柄，处理后的图像存于该句柄
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGrayReverse( HIMAGE hSource, HIMAGE hDest );

// 函数名：CKGrayAdding
// 功  能：对两张图像进行相加
// 参  数：sourceImage 输入图像
// 参  数：destImage 输出图像，计算结果存于该句柄
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGrayAdding( HIMAGE sourceImage, HIMAGE destImage );

// 函数名：CKGraySubtract
// 功  能：对两张图像进行相减
// 参  数：sourceImage 输入图像
// 参  数：destImage 输出图像，计算结果存于该句柄
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGraySubtract( HIMAGE sourceImage, HIMAGE destImage );

// 函数名：CKGrayAdjust
// 功  能：对图像的亮度和对比度进行调整
// 参  数：sourceImage 输入图像
// 参  数：destImage 输出图像，计算结果存于该句柄
// 参  数：Brightness 亮度补偿值，一般为(-128~128)
// 参  数：Contrast 对比度补偿值，一般为(-128~128)
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGrayAdjust( HIMAGE sourceImage, HIMAGE destImage, int Brightness, int Contrast );



/***************************************************************************
*-------------------------------- 曲线分析 --------------------------------*
****************************************************************************
*
*	曲线
*
****************************************************************************/

/**************** 宏定义 ****************/

// 检测边缘点方式 - GetEdgeMode
#define GEM_RISE			0	// 黑到白
#define GEM_DROP			1	// 白到黑
#define GEM_RISE_DROP		2	// 黑到白或白到黑

// CKProfileThreshold - Mode
#define AUTOM_HIGH			-1
#define AUTOM_NATURAL		-2
#define AUTOM_LOW			-3

/************ 结构类型定义 **************/

// CKGetProfileEdge(1,2) - 获取曲线的边缘点返回数据
typedef struct tagPROEDGE {
	int		State;			// 状态，0为黑到白，1为白到黑
	float	Distance;		// 距离，从开始位置到当前位置的距离(pixel)
	float	Intensity;		// 强度，该位置的灰度变化强度
} PROEDGE, *PPROEDGE;

// CKGetProfileObject - 投影返回数据
typedef struct tagPROBJOPTION {
	int		Threshold;		// 边缘强度阈值(0~255)
	int		EdgeMode;		// 边缘模式，0为黑到白，1为白到黑
	int		Direction;		// 检测方向，0为内到外，1为外到内
	int		Smoothness;		// 平滑范围，一般设为1~3
} PROBJOPTION, *PPROBJOPTION;

// CKGetProfileObject - 投影返回数据
typedef struct tagPROBJECT {
	float	Intensity;		// 强度
	FRECT	BorderBox;		// 边界框
} PROBJECT, *PPROBJECT;

/************* 函数部分 **************/

// 函数名：CKProfileSmooth
// 功  能：对曲线进行平滑处理
// 参  数：profileData 曲线数据
// 参  数：profileSize 曲线数据大小
// 参  数：Range 平滑范围
// 参  数：Mode 平滑模式，1为环绕平滑，0不使用
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKProfileSmooth( int* profileData, int profileSize, int Range, int Mode );

// 函数名：CKProfileThreshold
// 功  能：计算曲线的分割阈值
// 参  数：profileData 曲线数据
// 参  数：profileSize 曲线数据大小
// 参  数：Mode 模式
// 返  回：返回分割阈值
CKVIS_API int CKProfileThreshold( int* profileData, int profileSize, int Mode );

// 函数名：CKGetProfileGrads
// 功  能：获取曲线的梯度
// 参  数：profileData 曲线数据
// 参  数：profileSize 曲线数据大小
// 参  数：IsAbs 是否取绝对值
// 返  回：成功返回梯度曲线数据，大小和原曲线一样，否则返回NULL
CKVIS_API int* CKGetProfileGrads( int* profileData, int profileSize, int IsAbs );

// 函数名：CKGetProfileEdge1
// 功  能：获取曲线的顶点，局部最大值或最小值
// 参  数：profileData 曲线数据
// 参  数：profileSize 曲线数据大小
// 参  数：Threshold 分割阈值，曲线的当前点的值的绝对值大于该阈值才被检测出来
// 参  数：GetEdgeMode 获取顶点模式
// 参  数：retCount 获取顶点模式
// 返  回：成功返回所有检测到的顶点，否则返回NULL
CKVIS_API PROEDGE* CKGetProfileEdge1( int* profileData, int profileSize, int Threshold, int GetEdgeMode, int* retCount );

// 函数名：CKGetProfileEdge2
// 功  能：获取曲线边缘点，二阶梯度的过零点
// 参  数：profileData 原曲线的一阶梯度
// 参  数：profileSize 曲线数据大小
// 参  数：Threshold 分割阈值，曲线的当前点的值的绝对值大于该阈值才被检测出来
// 参  数：GetEdgeMode 获取顶点模式
// 参  数：retCount 获取顶点模式
// 返  回：成功返回所有检测到的顶点，否则返回NULL
CKVIS_API PROEDGE* CKGetProfileEdge2( int* profileData, int profileSize, int Threshold, int GetEdgeMode, int* retCount );

// 函数名：CKGetProfileObject
// 功  能：根据曲线图找出对象
// 参  数：profileX x轴方向曲线
// 参  数：sizeX profileX曲线的长度
// 参  数：profileY y轴方向曲线
// 参  数：sizeY profileY曲线的长度
// 参  数：Option 相关参数，参见PROBJOPTION
// 返  回：成功返回对象数据，否则返回NULL
CKVIS_API PROBJECT* CKGetProfileObject( int* profileX, int sizeX, int* profileY, int sizeY, PROBJOPTION* Option );

// 函数名：CKDisplayProfile
// 功  能：在屏幕的指定范围内显示一条曲线
// 参  数：hDC 显示设备的DC句柄
// 参  数：pRect 显示曲线的范围
// 参  数：profileData 曲线数据
// 参  数：profileSize 曲线数据大小
// 参  数：MaxValue 曲线垂直方向的最大值
// 参  数：bColor 背景颜色，0xFFFFFFFF为不使用背景颜色
// 参  数：lColor 曲线颜色
CKVIS_API void CKDisplayProfile( HDC hDC, RECT* pRect, int* profileData, int profileSize, int MaxValue, int bColor, int lColor );

// 函数名：CKDisplayFProfile
// 功  能：在屏幕的指定范围内显示一条曲线
// 参  数：hDC 显示设备的DC句柄
// 参  数：pRect 显示曲线的范围
// 参  数：profileData 曲线数据
// 参  数：profileSize 曲线数据大小
// 参  数：MaxValue 曲线垂直方向的最大值
// 参  数：bColor 背景颜色，0xFFFFFFFF为不使用背景颜色
// 参  数：lColor 曲线颜色
CKVIS_API void CKDisplayFProfile( HDC hDC, RECT* pRect, float* profileData, int profileSize, float MaxValue, int bColor, int lColor );





/***************************************************************************
*-------------------------------- 测量工具 --------------------------------*
****************************************************************************
*
*	主要用于测量和一些简单的定位
*
****************************************************************************/

/**************** 宏定义 ****************/

/* 检测边缘点方式 - GetEdgeMode
#define GEM_RISE			0	// 黑到白
#define GEM_DROP			1	// 白到黑
#define GEM_RISE_DROP		2	// 黑到白或白到黑
*/

// 检测方向	- 
#define DIR_IN_TO_OUT		0
#define DIR_OUT_TO_IN		1
#define DIR_LEFT_TO_RIGHT	0
#define DIR_TOP_TO_BOTTOM	1
#define DIR_FIRST			0
#define DIR_END				1
#define DIR_FIRST_END		2
#define DIR_ALL				3

/************ 结构类型定义 **************/

// 所有测量功能的参数选项
typedef struct tagMEASOPTION {
	int		Threshold;		// 待测的边缘位置的灰度变化强度阈值(0~255)
	int		LineSpace;		// 测量的密度，每隔多少个像素做一次检测，只用在非线形ROI测量功能(pixel)
	int		Smoothness;		// 平滑范围，一般设为1~3
	int		GetEdgeMode;	// 获取边缘位置的模式，0为黑到白，1为白到黑，2为黑到白或白到黑
	int		Directional;	// 测量方向或是开始和结束位置的选择，根椐测量功能的不同而定
} MEASOPTION, *PMEASOPTION;

// CKMeasurePoint(1,2) - 边缘点测量返回数据
typedef struct tagMEASPOINT {
	int		State;			// 状态，0为黑到白，1为白到黑
	float	Distance;
	float	Intensity;		// 强度，该位置的灰度变化强度
	FPOINT	LocatePoint;	// 该位置对应的一个点，用在屏幕上显示
} MEASPOINT, *PMEASPOINT;

// CKMeasureDistance - 距离测量返回数据
typedef struct tagMEASDISTANCE {
	int		State;			// 状态，0为黑到白，1为白到黑
	float	Distance;		// 距离，从ROI的开始位置到当前位置的距离(pixel)
	float	Intensity;		// 强度，该位置的灰度变化强度
	FLINE	LocateLine;		// 该位置对应的一条线，用在屏幕上显示
} MEASDISTANCE, *PMEASDISTANCE;

// CKGetBestSpace - 间距测量返回数据
typedef struct tagMEASSPACE {
	float	Distance;		// 间距，两个边缘位置间的距离，必须是一个白到黑和一个黑到白(pixel)
	float	Intensity;		// 强度，该位置的灰度变化强度
	FLINE	LocateLine;		// 该位置对应的一条线，用在屏幕上显示
} MEASSPACE, *PMEASSPACE;

// CKGetBestLine - 线测量返回数据
typedef struct tagMEASLINE {
	float	Sample;			// 采样率，当前找到的线所用到的边缘点与全部点的比
	float	Distance;		// 线条的长度(pixel)
	float	LineAngle;		// 线条相对于水平方向的角度
	float	Intensity;		// 强度，所有位置的强度平均
	FLINE	LocateLine;		// 该位置对应的一条线，用在屏幕上显示
} MEASLINE, *PMEASLINE;

// CKGetBestRound - 圆形测量返回数据
typedef struct tagMEASROUND {
	float	Sample;			// 采样率，当前找到的线所用到的边缘点与全部点的比
	float	Intensity;		// 强度，所有位置的强度平均
	FROUND	LocateRound;	// 测量到的圆的数据，该位置对应的一个圆，用在屏幕上显示
} MEASROUND, *PMEASROUND;

// CKMeasCallipers - 卡尺测量返回数据
typedef struct tagCALLIPERS
{
	float	Distance;		// 卡尺工具测到的两个位置间的距离(pixel)
	float	Intensity1;		// 第一个位置强度
	float	Intensity2;		// 第二个位置强度
	FLINE	LocateLine1;	// 第一个位置对应的一条线，用在屏幕上显示
	FLINE	LocateLine2;	// 第二个位置对应的一条线，用在屏幕上显示
	FPOINT	LocatePoint1;	// 第一个位置对应的一个点，用在屏幕上显示
	FPOINT	LocatePoint2;	// 第二个位置对应的一个点，用在屏幕上显示
} CALLIPERS, *PCALLIPERS;

/************* 函数部分 **************/

// 函数名：CKMeasurePoint
// 功  能：在一条线上检测边缘点
// 参  数：hImage 图像句柄，支持的图像类型为8Bit
// 参  数：pLine 一个指向线形数据结构的指针
// 参  数：Option 测量工具的相关参数，参见MEASOPTION
// 参  数：retCount 返回检测到的边缘点数目
// 返  回：成功返回检测到的所有边缘点数据，否则返NULL
CKVIS_API MEASPOINT* CKMeasurePoint( HIMAGE hImage, LINE* pLine, MEASOPTION* Option, int* retCount );

// 函数名：CKMeasurePoint2
// 功  能：在一圆形边上检测边缘点
// 参  数：hImage 图像句柄，支持的图像类型为8Bit
// 参  数：pRound 一个指向圆形数据结构的指针
// 参  数：Option 测量工具的相关参数，参见MEASOPTION
// 参  数：retCount 返回检测到的边缘点数目
// 返  回：成功返回检测到的所有边缘点数据，否则返NULL
CKVIS_API MEASPOINT* CKMeasurePoint2( HIMAGE hImage, ROUND* pRound, MEASOPTION* Option, int* retCount );

// 函数名：CKMeasureDistance
// 功  能：边缘位置检测功能，用于检测两个或多个边缘位置之间的间隔
// 参  数：hImage 图像句柄
// 参  数：pRotRect 一个指向可旋转矩形数据结构的指针
// 参  数：Option 测量工具的相关参数，参见MEASOPTION
// 参  数：retCount 返回检测到的边缘位置数目
// 返  回：成功返回检测到的所有边缘点数据，否则返NULL
CKVIS_API MEASDISTANCE* CKMeasureDistance( HIMAGE hImage, ROTRECT* pRotRect, MEASOPTION* Option, int* retCount );

// 函数名：CKGetBestSpace
// 功  能：边缘位置检测功能，用于检测两个或多个边缘位置之间的间隔
// 参  数：distanceList CKMeasureDistance函数返回的数据
// 参  数：distanceCount 边缘位置数目
// 参  数：distanceMode 0为黑色部分，1为白色部分
// 参  数：retCount 返回检测到间隔的数量
// 返  回：成功返回检测到的所有间隔数据，否则返NULL
CKVIS_API MEASSPACE* CKGetBestSpace( MEASDISTANCE* distanceList, int distanceCount, int distanceMode, int* retCount );

// 函数名：CKMeasureLinePoints
// 功  能：在指定的范围内检测边缘点
// 参  数：hImage 图像句柄
// 参  数：pRotRect 一个指向可旋转矩形数据结构的指针
// 参  数：Option 测量工具的相关参数，参见MEASOPTION
// 参  数：retCount 返回检测到的边缘位置数目
// 返  回：成功返回检测到的所有边缘点数据，否则返NULL
CKVIS_API FPOINT* CKMeasureLinePoints( HIMAGE hImage, ROTRECT* pRotRect, MEASOPTION* Option, int* retCount );

// 函数名：CKGetBestLine
// 功  能：根据CKMeasureLinePoints检测出来的点求出一条线
// 参  数：Points 所有点的数据
// 参  数：Count 点的数量
// 参  数：Tolerance 容忍的变动范围
// 返  回：成功返回一条线的数据，否则返NULL
CKVIS_API MEASLINE* CKGetBestLine( FPOINT* Points, int Count, float Tolerance );

// 函数名：CKMeasureRoundPoints
// 功  能：在指定的范围内检测边缘点
// 参  数：hImage 图像句柄
// 参  数：pAnnulus 一个指向环形数据结构的指针
// 参  数：Option 测量工具的相关参数，参见MEASOPTION
// 参  数：retCount 返回检测到的边缘位置数目
// 返  回：成功返回检测到的所有边缘点数据，否则返NULL
CKVIS_API FPOINT* CKMeasureRoundPoints( HIMAGE hImage, ANNULUS* pAnnulus, MEASOPTION* Option, int* retCount );

// 函数名：CKGetBestRound
// 功  能：根据CKMeasureRoundPoints检测出来的点求出一个圆
// 参  数：Points 所有点的数据
// 参  数：Count 点的数量
// 参  数：Tolerance 容忍的变动范围
// 返  回：成功返回一个圆的数据，否则返NULL
CKVIS_API MEASROUND* CKGetBestRound( FPOINT* Points, int Count, float Tolerance );

// 函数名：CKMeasCallipers
// 功  能：卡尺工具，测量物体的长度尺寸
// 参  数：hImage 图像句柄
// 参  数：pRotRect 一个指向可旋转矩形数据结构的指针
// 参  数：Option 测量工具的相关参数，参见MEASOPTION
// 返  回：成功返回测量到的相关数据，否则返NULL
CKVIS_API CALLIPERS* CKMeasCallipers( HIMAGE hImage, ROTRECT* pRotRect, MEASOPTION* Option );

// 函数名：CKDisplayAnnulusLine
// 功  能：在一个环行上显示测量路径的位置
// 参  数：hDC 显示设备DC句柄
// 参  数：pAnnulus 一个指向环形数据结构的指针
// 参  数：Space 每隔多少度画一条线
CKVIS_API void CKDisplayLineToAnnulus( HDC hDC, ANNULUS* pAnnulus, int Space );

// 函数名：CKDisplayRotRectLine
// 功  能：在一个环行上显示测量路径的位置
// 参  数：hDC 显示设备DC句柄
// 参  数：pAnnulus 一个指向环形数据结构的指针
// 参  数：Space 每隔多少像素画一条线
CKVIS_API void CKDisplayLineToRotRect( HDC hDC, ROTRECT* pRotRect, int Directional, int Space );





/***************************************************************************
*-------------------------------- 简单几何学 -------------------------------*
****************************************************************************
*
*	主要用于一些常用的简单几何计算
*
****************************************************************************/

/**************** 宏定义 ****************/

// Directional - 方向
#define LFP_LEVEL		0	// 水平方向
#define LFP_VERTICAL	1	// 垂直方向

/************ 结构类型定义 **************/

// CKGetLinesFromMatrixPoints - 参数选项
typedef struct tagLFPOPTION {
	int		LineMode;		// 线的模式
	int		Directional;	// 方向设置，水平方向LFP_LEVEL和垂直方向LFP_VERTICAL
	int		MinCount;		// 至少有多少个点才能算是一条线
	float	MinSpace;		// 两个点之间的最小距离
	float	MaxSpace;		// 两个点之间的最大距离
	float	ToleAngle;		// 一条线上的所有点之间的角度变化范围
} LFPOPTION, *PLFPOPTION;

/************* 函数部分 **************/

// 函数名：CKRotationImage
// 功  能：对图像进行旋转
// 参  数：hDest 目标图像句柄，存放旋转后的图像
// 参  数：hSource 原图像句柄，旋转前的图像
// 参  数：Angle 需要旋转的角度
// 返  回：成功返回TRUE，否则返FALSE
CKVIS_API BOOL CKRotationImage( HIMAGE hDest, HIMAGE hSource, float Angle );

// 函数名：CKScalingImage
// 功  能：对图像进行比例缩放
// 参  数：hDest 目标图像句柄，存放缩放后的图像
// 参  数：hSource 原图像句柄，缩放前的图像
// 参  数：Scale 缩放倍数
// 返  回：成功返回TRUE，否则返FALSE
CKVIS_API BOOL CKScalingImage( HIMAGE hDest, HIMAGE hSource, float Scale );

// 函数名：CKMirrorImage
// 功  能：对图像进行上下转置
// 参  数：hImage 需要转置的图像句柄
// 返  回：成功返回TRUE，否则返FALSE
CKVIS_API BOOL CKMirrorImage( HIMAGE hImage, int MirrorMode );

// 函数名：CK2PointDistance
// 功  能：求两个点的距离
// 参  数：point1 第一个点的数据
// 参  数：point2 第二个点的数据
// 返  回：返回两个点的距离
CKVIS_API double CK2PointDistance( FPOINT* point1, FPOINT* point2 );

// 函数名：CK2PointAngle
// 功  能：求两个点的角度
// 参  数：point1 第一个点的数据
// 参  数：point2 第二个点的数据
// 返  回：返回两个点的距离
CKVIS_API double CK2PointAngle( FPOINT* point1, FPOINT* point2 );

// 函数名：CK2PointCenter
// 功  能：求两个点的中心点
// 参  数：point1 第一个点的数据
// 参  数：point2 第二个点的数据
// 返  回：返回两个点的中心点
CKVIS_API FPOINT CK2PointCenter( FPOINT* point1, FPOINT* point2 );

// 函数名：CK3PointAngle
// 功  能：获得3个点的夹角
// 参  数：point1 原点坐标
// 参  数：point2 第一个点的数据
// 参  数：point3 第二个点的数据
// 返  回：返回夹角的角度
CKVIS_API double CK3PointAngle( FPOINT *point1, FPOINT *point2, FPOINT *point3 );

// 函数名：CK3PointRound
// 功  能：3个点求一个圆
// 参  数：point1 第一个点的数据
// 参  数：point2 第二个点的数据
// 参  数：point3 第三个点的数据
// 返  回：返回一个圆的数据
CKVIS_API FROUND CK3PointRound( FPOINT* point1, FPOINT* point2, FPOINT* point3 );

// 函数名：CK2LineJunction
// 功  能：获得两条直线的相交点
// 参  数：pLine1 第一条线的数据
// 参  数：pLine2 第二条线的数据
// 返  回：成功返回两条直线的相交点
CKVIS_API FPOINT CK2LineJunction( FLINE* pLine1, FLINE* pLine2 );

// 函数名：CKPointsAverage
// 功  能：求多个点的平均值
// 参  数：points 所有点的数据
// 参  数：pointCount 点的数量
// 返  回：返回所有点的平均值
CKVIS_API FPOINT CKPointsAverage( FPOINT* points, int pointCount );

// 函数名：CKGetLinesFromMatrixPoints
// 功  能：在一个坐标点矩阵中检测出水平或垂直线
// 参  数：points 输入的所有坐标点的数据
// 参  数：pointCount 坐标点的数量
// 参  数：Option 相关的参数，参见LFPOPTION
// 参  数：retCount 返回的线的数量
// 返  回：成功返回所有线条的数据，否则返回NULL
CKVIS_API FLINE* CKGetLinesFromMatrixPoints( FPOINT* points, int pointCount, LFPOPTION* Option, int* retCount );





/***************************************************************************
*-------------------------------- 定位识别 --------------------------------*
****************************************************************************
*
*	主要用于物体定位
*
****************************************************************************/

/**************** 宏定义 ****************/

// BarcodeType - 条码类型 
#define BARCODE_UPC_A		0
#define BARCODE_UPC_E		1
#define BARCODE_EAN_8		2
#define BARCODE_EAN_13		3
#define BARCODE_CODE_39		4

/************ 结构类型定义 **************/

// CKGetModelInfo - 模板信息头数据
typedef struct tagMODELINFO {
	int		 MinAngle;		// 模板的最小角度（-180~180）；
	int		 MaxAngle;		// 模板的最大角度（-180~180）；
	int		 MinScale;		// 模板的最小比例（按照百分比，100为1倍）；
	int		 MaxScale;		// 模板的最大比例（按照百分比，100为1倍）；
	int		 ModWidth;		// 模板的宽度；
	int		 ModHeight;		// 模板的高度；
} MODELINFO;

// CKRoiToModel、CKLearnModel、CKUpdateModel - 学习或更新模板参数选项
typedef struct tagLEARNOPTION {
	int		MinAngle;		// 需要创建模板的最小角度（-180~180）；
	int		MaxAngle;		// 需要创建模板的最大角度（-180~180）；
	int		MinScale;		// 需要创建模板的最小比例（按照百分比，100为1倍）；
	int		MaxScale;		// 需要创建模板的最大比例（按照百分比，100为1倍）；
	int		Distance;		// 距离，默认为1，相对于大型模板可以增大该值来压缩模板，以便减少所占用空间的大小和提升速度，只在CKLearnModel时有用；
	int		Threshold;		// 边缘梯度阈值，只有那些梯度大于该阈值的边缘点才被检测出来，只在CKLearnModel时有用；
	int		NeedEdge;		// 最短的边缘，用以限制那些长度小于该值的边缘，以便减少噪音，只在CKLearnModel时有用；
} LEARNOPTION, *PLEARNOPTION;

// CKFindModel - 搜索模板参数选项
typedef struct tagFINDOPTION {
	int		MinScore;		// 搜索匹配对象的最小分数；
	int		NeedEdge;		// 最短的边缘，用以限制那些长度小于该值的边缘，以便减少噪音；
	int		Threshold;		// 边缘梯度阈值，只有那些梯度大于该阈值的边缘点才被检测出来；
	int		FindCount;		// 需要搜索的个数；
	int		FindLevel;		// 搜索水平(1~10)，搜索水平越高，能搜索到的匹配对象越多，但速度会变慢；
	int		Superpose;
} FINDOPTION, *PFINDOPTION;

// CKFindModel - 搜索模板返回数据
typedef struct tagMATCH {
	float	Angle;			// 该匹配对象的角度；
	float	Scale;			// 该匹配对象的比例；
	float	Score;			// 该匹配对象的分数(相似度)；
	float	CenterX;		// 该匹配对象的中心x轴坐标；
	float	CenterY;		// 该匹配对象的中心y轴坐标；
	float	Width;			// 该匹配对象的宽度；
	float	Height;			// 该匹配对象的高度；
} MATCH, *PMATCH;

// CKReadBarCode - 条码检测选项结构
typedef struct tagRBCOPTION {
	int		BarcodeType;
	int		Threshold;
	int		LineSpace;
	int		Smoothness;
} RBCOPTION, *PRBCOPTION;

// CKReadBarCode - 条码检测返回数据
typedef struct tagBARCODE {
	char	CodeText[256];
	int		CodeLenght;
	int		BarcodeType;
} BARCODE, *PBARCODE;

/************* 函数部分 **************/

// 函数名：CKRoiToModel
// 功  能：把ROI的边缘轮廓转换为模板数据，只支持矩形和圆形的ROI
// 参  数：hRoi ROI数据句柄
// 参  数：Option 相关的参数，参见LEARNOPTION
// 返  回：成功返回一个模板句柄，否则返回NULL
CKVIS_API HMODEL CKRoiToModel( HROI hRoi, LEARNOPTION* Option );

// 函数名：CKLearnModel
// 功  能：学习模板，从图像中提取边缘轮廓做为模板数据
// 参  数：hImage 图像句柄
// 参  数：pRect 学习的范围，NULL为整张图像
// 参  数：Option 相关的参数，参见LEARNOPTION
// 返  回：成功返回一个模板句柄，否则返回NULL
CKVIS_API HMODEL CKLearnModel( HIMAGE hImage, RECT* pRect, LEARNOPTION* Option );

// 函数名：CKLoadModel
// 功  能：从文件中装载一个以存在的模板
// 参  数：pszFileName 模板文件的全路径名
// 返  回：成功返回一个模板句柄，否则返回NULL
CKVIS_API HMODEL CKLoadModel( const char* pszFileName );

// 函数名：CKSaveModel
// 功  能：将模板保存到文件中去
// 参  数：pszFileName 保存模板文件的全路径名
// 参  数：hModel 模板句柄
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKSaveModel( const char* pszFileName, HMODEL hModel );

// 函数名：CKSetModelPointState
// 功  能：设置模板的边缘点的状态
// 参  数：hModel 模板句柄
// 参  数：pRect 设置的范围，只有在该范围内的边缘点的状态才会改变
// 参  数：State 状态，0为不使用该点作为模板特征，1为使用
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKSetModelPointState( HMODEL hModel, RECT *pRect, int State );

// 函数名：CKUpdateModel
// 功  能：在改变边缘点状态和改变角度和比例变换时须用该函数更新模板
// 参  数：hModel 模板句柄
// 参  数：Option 相关的参数，参见LEARNOPTION
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKUpdateModel( HMODEL hModel, LEARNOPTION* Option );

// 函数名：CKGetModelInfo
// 功  能：获取模板的相关信息
// 参  数：hModel 模板句柄
// 参  数：pModelInfo 返回模板的相关信息，参见MODELINFO
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKGetModelInfo( HMODEL hModel, MODELINFO* pModelInfo );

// 函数名：CKCopyModel
// 功  能：复制模板
// 参  数：hModel 模板句柄
// 返  回：成功返回一个新的模板，否则返回NULL
CKVIS_API HMODEL CKCopyModel( HMODEL hModel );

// 函数名：CKDestroyModel
// 功  能：模板在不用后用该函数销毁
// 参  数：hModel 模板句柄
CKVIS_API void CKDestroyModel( HMODEL hModel );

// 函数名：CKDisplayModel
// 功  能：在屏幕上显示模板的边缘点
// 参  数：hDC 显示设备的DC句柄
// 参  数：hModel 模板句柄
// 参  数：CX 显示模板的中心x
// 参  数：CY 显示模板的中心y
// 参  数：Angle 显示模板的角度
// 参  数：Scale 显示模板的比例
// 参  数：Color1 状态为1的边缘点颜色
// 参  数：Color2 状态为0的边缘点颜色
CKVIS_API void CKDisplayModel( HDC hDC, HMODEL hModel, float cx, float cy, float Angle, float Scale, int Color1, int Color2 );

// 函数名：CKFindModel
// 功  能：在一张图像上搜索跟模板相似的区域
// 参  数：hImage 图像句柄
// 参  数：pRect 搜索范围，NULL为整张图像
// 参  数：hModel 模板句柄
// 参  数：Option 搜索的相关参数，参见FINDOPTION
// 参  数：retCount 返回搜索到的匹配对象的个数
// 返  回：成功返回匹配对象的相关数据，否则返回NULL
CKVIS_API MATCH* CKFindModel( HIMAGE hImage, RECT* pRect, HMODEL hModel, FINDOPTION* Option, int* retCount );

// 函数名：CKDisplayMatch
// 功  能：在屏幕上显示一个匹配对象
// 参  数：hDC 显示设备的DC句柄
// 参  数：pMatch 匹配对象数据
// 参  数：Color 显示的颜色
CKVIS_API void CKDisplayMatch( HDC hDC, MATCH* pMatch, int Color );

// 函数名：CKLearnPattern
// 功  能：灰度模板学习
// 参  数：hImage 图像句柄
// 参  数：pRect 学习的范围，NULL为整张图像
// 返  回：成功返回灰度模板数据，否则返回NULL
CKVIS_API BYTE* CKLearnPattern( HIMAGE hImage, RECT* pRect );

// 函数名：CKMatchPattern
// 功  能：灰度模板匹配
// 参  数：hImage 图像句柄
// 参  数：pRect 搜索范围，NULL为整张图像
// 返  回：成功返回匹配对象的相关数据，否则返回NULL
CKVIS_API MATCH* CKMatchPattern( HIMAGE hImage, RECT* pRect, BYTE* Pattern, int MinScore, int* retCount );

// 函数名：CKReadBarCode
// 功  能：对一些常用的条码进行检测
// 参  数：hImage 图像句柄
// 参  数：pRRect 条码所在的位置
// 参  数：Option 条码检测的相关参数，参见RBCOPTION
// 返  回：成功返回匹配对象的相关数据，否则返回NULL
CKVIS_API BARCODE* CKReadBarCode( HIMAGE hImage, ROTRECT* pRRect, RBCOPTION* Option );





/***************************************************************************
*-------------------------------- 彩色处理 --------------------------------*
****************************************************************************
*
*	主要用于彩色检测
*
****************************************************************************/

/************ 结构类型定义 **************/

// CKColorHistogram - 彩色直方图返回数据
typedef struct tagCOLORHISTOGRAM {
	int		histogSize;
	int*	Channels1;
	int*	Channels2;
	int*	Channels3;
} COLORHISTOGRAM, *PCOLORHISTOGRAM;

// CKGetColorInfo - 彩色信息返回数据
typedef struct tagCOLORINFO {
	float	rValue;
	float	gValue;
	float	bValue;
} COLORINFO, *PCOLORINFO;

/************* 函数部分 **************/

// 函数名：CKColorHistogram
// 功  能：获取图像的彩色直方图
// 参  数：hImage 图像句柄
// 参  数：pRect 检测区域，NULL为整张图像
// 参  数：ColorMode 彩色空间模式
// 返  回：成功返回值方图数据，否则返回NULL
CKVIS_API COLORHISTOGRAM* CKColorHistogram( HIMAGE hImage, RECT *pRect, int ColorMode );

// 函数名：CKGetColorInfo
// 功  能：获取图像指定区域内的彩色信息
// 参  数：hImage 图像句柄
// 参  数：hRoi 获取区域，可支持RECT、ROUND和ROTRECT类型的ROI，NULL为整张图像
// 返  回：成功返回彩色数据信息，否则返回NULL
CKVIS_API COLORINFO* CKGetColorInfo( HIMAGE hImage, HROI hRoi );

// 函数名：CKMatchColorInfo
// 功  能：比较两个彩色信息是否相似
// 参  数：pColorInfo1 彩色信息1
// 参  数：pColorInfo2 彩色信息2
// 返  回：返回两个彩色信息的匹配程度
CKVIS_API float CKMatchColorInfo( COLORINFO* pColorInfo1, COLORINFO* pColorInfo2 );

// 函数名：CKColorToGray
// 功  能：彩色转换为灰度图
// 参  数：colorImage 输入的彩色图像
// 参  数：grayImage 输出的彩色图像
// 返  回：成功返回TRUE，否则返回FALSE
CKVIS_API BOOL CKColorToGray( const HIMAGE colorImage, HIMAGE grayImage, int Chunnel );
