// CompareImageDlg.cpp : implementation file
//

#include "stdafx.h"
#include "CompareImage.h"
#include "CompareImageDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

CCompareImageDlg *pCompare ;

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCompareImageDlg dialog

CCompareImageDlg::CCompareImageDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CCompareImageDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCompareImageDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);

	m_iMatchCount	= 0;
	pMatchArray		= NULL;
}

void CCompareImageDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCompareImageDlg)
	DDX_Control(pDX, IDC_LIST1, m_list1);
	DDX_Control(pDX, IDC_DRAW_RECT, m_DrawRect);
	DDX_Control(pDX, IDC_DRAW_EDGE, m_DrawEdge);
	//}}AFX_DATA_MAP
    
}

BEGIN_MESSAGE_MAP(CCompareImageDlg, CDialog)
	//{{AFX_MSG_MAP(CCompareImageDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_OpenImage, OnOpenImage)
	ON_WM_LBUTTONDOWN()
	ON_WM_MOUSEMOVE()
	ON_BN_CLICKED(IDC_StartCollection, OnStartCollection)
	ON_BN_CLICKED(IDC_StopCollection, OnStopCollection)
	ON_BN_CLICKED(IDC_CreateModel, OnCreateModel)
	ON_BN_CLICKED(IDC_EditModel, OnEditModel)
	ON_BN_CLICKED(IDC_SearchObject, OnSearchObject)
	ON_BN_CLICKED(IDC_DRAW_RECT, OnDrawRect)
	ON_BN_CLICKED(IDC_DRAW_EDGE, OnDrawEdge)
	ON_BN_CLICKED(IDC_LoadModel, OnLoadModel)
	ON_BN_CLICKED(IDC_SaveModel, OnSaveModel)
	ON_BN_CLICKED(IDC_Rect, OnRect)
	ON_BN_CLICKED(IDC_ClearRect, OnClearRect)
	ON_BN_CLICKED(IDC_SetSearchArea, OnSetSearchArea)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCompareImageDlg message handlers

BOOL CCompareImageDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	
	m_list1.SetExtendedStyle( 0x22 );
	m_list1.InsertColumn( 0, "编号", LVCFMT_LEFT, 50 );
	m_list1.InsertColumn( 1, "相似度", LVCFMT_LEFT, 60 );
	m_list1.InsertColumn( 2, "角度", LVCFMT_LEFT, 60 );
	m_list1.InsertColumn( 3, "比例", LVCFMT_LEFT, 60 );
	m_list1.InsertColumn( 4, "中心x", LVCFMT_LEFT, 60 );
	m_list1.InsertColumn( 5, "中心y", LVCFMT_LEFT, 60 );


	GetDlgItem( IDC_PORFILE_RECT )->GetWindowRect( &m_Rect );
	ScreenToClient( &m_Rect );

    m_DispPoint.x = m_Rect.left;
    m_DispPoint.y = m_Rect.top;

	m_DispPoint.x = 0;   //视图原点x
	m_DispPoint.y = 0;   //视图原点y


	m_hImage = NULL;    //图像句柄初始化
	m_ImgType = 8;      //图像位深初始化
	m_ImgWidth = 0;     //图像宽度初始化
	m_ImgHeight = 0;    //图像高度初始化

	m_hRoi		= NULL;      //ROI初始化
	m_RoiNode	= 0;         //ROI节点初始化
	m_RoiType	= ROI_NULL;  //ROI类型初始化

	pCompare = this ;  //把当前指针指向pCompare
	MAInitial( 0 );                   //图像采集卡初始化
	MASetColorFormat( 0, CLFM_Y8 );   //图像采集卡初始化
	MASetVideoFormat( 0, VIFM_PAL );  //图像采集卡初始化
	MASelectChannel( 0, CHANNEL_0 );  //图像采集卡初始化
	MASetCallBack( 0, GrabProcess );  //图像采集卡初始化

	SetDlgItemInt( IDC_P1, 1 );
	SetDlgItemInt( IDC_P2, 800 );
	SetDlgItemInt( IDC_P3, 20 );
	SetDlgItemInt( IDC_P4, 40 );
	SetDlgItemInt( IDC_P5, 5 );
	SetDlgItemInt( IDC_P6, 5 );

	SetDlgItemInt( IDC_P7, 0 );
	SetDlgItemInt( IDC_P8, 0 );
	SetDlgItemInt( IDC_P9, 0 );
	SetDlgItemInt( IDC_P10, 0 );

	m_DrawRect.SetCheck( 1 );
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CCompareImageDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
    
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CCompareImageDlg::OnPaint() 
{

	CPaintDC dc(this); // device context for painting

	if (IsIconic())
	{
		
		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		DrawObject(&dc);
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CCompareImageDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CCompareImageDlg::BeginTime()
{
	QueryPerformanceFrequency( &m_Frequency );
	QueryPerformanceCounter( &m_BeginTime );
}

void CCompareImageDlg::EndTime()
{
	QueryPerformanceCounter(&m_EndTime);
	double fTime = double(m_EndTime.LowPart-m_BeginTime.LowPart)/double(m_Frequency.LowPart);
	CString strTime;
	strTime.Format( "消耗时间 %0.3f 毫秒", fTime * 1000.0 );
	SetDlgItemText( IDC_TIMER, strTime );
}

void CCompareImageDlg::OnLButtonDown(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	

	m_RsPoint.x = point.x;
	m_RsPoint.y = point.y;

	m_RoiNode = ::CKGetRoiNode( m_hRoi, point.x - m_DispPoint.x,
		                        point.y - m_DispPoint.y );
	if( !m_RoiNode )
	{
		CKFreeRoi( m_hRoi );
		m_hRoi = NULL;
	}

	CDialog::OnLButtonDown(nFlags, point);
}

void CCompareImageDlg::OnMouseMove(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	CKSetRoiCursor( m_hRoi, CKGetRoiNode( m_hRoi, point.x - m_DispPoint.x, 
		                                  point.y - m_DispPoint.y ) );

	if( nFlags == MK_LBUTTON ) 
	{
		if( m_RoiNode == 0 ) 
		{
			if( !m_hRoi )
				m_hRoi = ::CKCreateRoi( m_RoiType );
		
			::CKSetRoi( m_hRoi,                                                                                                                   
						m_RsPoint.x - m_DispPoint.x, 
						m_RsPoint.y - m_DispPoint.y, 
						point.x - m_DispPoint.x, 
						point.y - m_DispPoint.y );
		} 
		else 
		{
			::CKAdjustRoi( m_hRoi, m_RoiNode, point.x - m_DispPoint.x,
				           point.y - m_DispPoint.y );
			
			
		}
		RECT * pRect = CKGetRect( m_hRoi );
		if(pRect)
		{
	   			SetDlgItemInt( IDC_P7, pRect->left );
				SetDlgItemInt( IDC_P8, pRect->top );
				SetDlgItemInt( IDC_P9, pRect->right );
				SetDlgItemInt( IDC_P10, pRect->bottom );
		
		}
		Invalidate( FALSE );
	}

	if (nFlags==MK_RBUTTON) 
	{	//移动图像时使用;
		m_DispPoint.x += (point.x-m_OldPoint.x);
		m_DispPoint.y += (point.y-m_OldPoint.y);
		Invalidate(FALSE);
	}

	m_OldPoint = point;
	CDialog::OnMouseMove(nFlags, point);
}
void CCompareImageDlg::DrawObject(CDC *pDC)
{
	pDC->SetViewportOrg( m_DispPoint.x , m_DispPoint.y);
	m_DispRect2.left = m_Rect.left - m_DispPoint.x;
	m_DispRect2.top =  m_Rect.top - m_DispPoint.y;
	m_DispRect2.right = m_Rect.right - m_DispPoint.x; 
	m_DispRect2.bottom = m_Rect.bottom - m_DispPoint.y;
	CRectMemDC DispDC( pDC, m_DispRect2);
	CBrush BkBrush( 4, RGB( 0, 255, 255 ) ), *OldBrush;
	OldBrush = DispDC.SelectObject( &BkBrush );
	DispDC.Rectangle( &m_DispRect2 );
	DispDC.SelectObject( OldBrush );
	DispDC.SetTextColor( RGB(255,0,0) );
	DispDC.SetBkMode( 1 );
	BkBrush.DeleteObject();   //删除背景刷
//========================================================================================//

	if(m_hImage)
     CKDisplayImage( DispDC.GetSafeHdc(), m_hImage, 0, 0 );  //显示图像

	CKDisplayRoi(DispDC.GetSafeHdc(), m_hRoi, RGB(255, 0, 0) );      //在图像框中画矩形
	CKDisplayRoiNode(DispDC.GetSafeHdc(), m_hRoi, RGB(255, 0, 0) );  //显示ROI节点


	if( pMatchArray ) 
	{
		for( int i = 0; i < m_iMatchCount; i ++ ) 
		{
			if( m_DrawRect.GetCheck() )
				CKDisplayMatch( DispDC.GetSafeHdc(), &pMatchArray[i], RGB( 0, 0, 255 ) );
			if( m_DrawEdge.GetCheck() )
			{
				CKDisplayModel( DispDC.GetSafeHdc(), m_ModelEditDlg.m_hModel, 
								 pMatchArray[i].CenterX, pMatchArray[i].CenterY,  
								 pMatchArray[i].Angle, pMatchArray[i].Scale, RGB( 0, 255, 0 ), NULL );
			}
		}
	}

}

void CCompareImageDlg::OnOpenImage() 
{
	// TODO: Add your control notification handler code here
	CFileDialog fd(TRUE,"",NULL,OFN_HIDEREADONLY |OFN_OVERWRITEPROMPT,"(*.bmp)|*.bmp||");
	fd.m_ofn.lpstrTitle = "打开图像文件";
	if( fd.DoModal() == IDOK )
	{
		m_FileName = fd.GetPathName();
	
		if( m_hImage )
			CKFreeImage( m_hImage );
		m_hImage = CKReadBMPFile( m_FileName );
		if( !m_hImage ) 
		{
			AfxMessageBox( "读取文件失败!" );
			Invalidate( FALSE );
			return;
		}
		CKGetImageInfo( m_hImage, &m_ImgType, &m_ImgWidth, &m_ImgHeight );
	 	CString st;
		st.Format( "类型[%d位] 尺寸[%d×%d]", m_ImgType, m_ImgWidth, m_ImgHeight );
		SetDlgItemText( IDC_IMAGE_INFO, st );    //在IDC_IMAGE_INFO显示类型[%d位] 尺寸[%d×%d]
		Invalidate( FALSE );

	}	
}
VOID CALLBACK GrabProcess( DWORD Data, WORD Port )
{

	CKSetImageBuffer( pCompare->m_hImage, (BYTE*)Data );

	CDC * pDC = pCompare->GetDC();

	pCompare->DrawObject(pDC);

	pCompare->ReleaseDC( pDC );

}

void CCompareImageDlg::OnStartCollection() 
{
	// TODO: Add your control notification handler code here
	
	DWORD BitCount  ;
	DWORD Width     ;
	DWORD Height    ;
	MAGetImageInfo( 0,  &BitCount, &Width, &Height );
	if( m_hImage )
	{
	  CKFreeImage( m_hImage );
	}
	m_hImage = CKCreateImage( NULL, 8, Width, Height );

	MAStart( 0, 0xFFFFFFFF );

}

void CCompareImageDlg::OnStopCollection() 
{
	// TODO: Add your control notification handler code here
	
	MAStop( 0 );

}

void CCompareImageDlg::OnCreateModel() 
{
	// TODO: Add your control notification handler code here
	m_ModelEditDlg.m_hImage = m_hImage;
	m_ModelEditDlg.EditModel( FALSE );
	m_ModelEditDlg.DoModal();
}

void CCompareImageDlg::OnEditModel() 
{
	// TODO: Add your control notification handler code here
	m_ModelEditDlg.EditModel( TRUE );
	m_ModelEditDlg.DoModal();
}

void CCompareImageDlg::OnSearchObject() 
{
	// TODO: Add your control notification handler code here
	FINDOPTION Option;
	Option.FindCount	= GetDlgItemInt( IDC_P1 );  //搜索数量
	Option.MinScore		= GetDlgItemInt( IDC_P2 );  //最小分数
	Option.Threshold	= GetDlgItemInt( IDC_P3 );  //边缘阈值
	Option.NeedEdge		= GetDlgItemInt( IDC_P4 );  //最短边缘
	Option.FindLevel	= GetDlgItemInt( IDC_P5);   //搜索级别
	Option.Superpose	= GetDlgItemInt( IDC_P6 );  //重叠距离

	if( pMatchArray )
	{
		CKFreeMemory( pMatchArray );
		pMatchArray = NULL;
	}
	BeginTime();	// 开始测试时间
    pMatchArray = CKFindModel( m_hImage, CKGetRect( m_hRoi ), m_ModelEditDlg.m_hModel, &Option, &m_iMatchCount );
	EndTime();		// 结束测试时间

    m_list1.DeleteAllItems();
	if( pMatchArray ) 
	{
		char s[100];
		int i, item;
		for( i = 0; i < m_iMatchCount; i ++ ) 
		{
			item = m_list1.InsertItem( i, "" );
			sprintf( s, "%d", i + 1 );
			m_list1.SetItemText( item, 0, s );
			sprintf( s, "%0.3f", pMatchArray[i].Score );
			m_list1.SetItemText( item, 1, s );
			sprintf( s, "%0.2f", pMatchArray[i].Angle );
			m_list1.SetItemText( item, 2, s );
			sprintf( s, "%0.2f", pMatchArray[i].Scale );
			m_list1.SetItemText( item, 3, s );
			sprintf( s, "%0.2f", pMatchArray[i].CenterX );
			m_list1.SetItemText( item, 4, s );
			sprintf( s, "%0.2f", pMatchArray[i].CenterY );
			m_list1.SetItemText( item, 5, s );
		}
	} else
	{
		MessageBox( "搜索不到相匹配的对象！" );
	}
	Invalidate( FALSE );
}

void CCompareImageDlg::OnDrawRect() 
{
	// TODO: Add your control notification handler code here

	Invalidate( FALSE );    //显示位置
}

void CCompareImageDlg::OnDrawEdge() 
{
	// TODO: Add your control notification handler code here
	
	Invalidate( FALSE );  //显示边缘
}

void CCompareImageDlg::OnLoadModel() 
{
	// TODO: Add your control notification handler code here
	CFileDialog fd( TRUE, "", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,"(*.mod)|*.mod||" );
	fd.m_ofn.lpstrTitle = "装载模板文件";
	if( fd.DoModal() == IDOK )
	{
		if( m_ModelEditDlg.m_hModel )
		{
			CKDestroyModel( m_ModelEditDlg.m_hModel );
		}
		m_ModelEditDlg.m_hModel = CKLoadModel( fd.GetPathName() );
		if( m_ModelEditDlg.m_hModel )
		{
			MODELINFO ModelInfo;
			CKGetModelInfo( m_ModelEditDlg.m_hModel, &ModelInfo );
		} else 
		{
			AfxMessageBox( "装载模板失败！" );
		}
	}
}

void CCompareImageDlg::OnSaveModel() 
{
	// TODO: Add your control notification handler code here
	CFileDialog fd( FALSE, "", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,"(*.mod)|*.mod||" );
	fd.m_ofn.lpstrTitle = "保存模板文件";
	if( fd.DoModal() == IDOK ) 
	{
		if( m_ModelEditDlg.m_hModel ) 
		{
			if( !CKSaveModel( fd.GetPathName(), m_ModelEditDlg.m_hModel ) )
			{
				AfxMessageBox("保存模板失败！");
			}
		}

	}
}

void CCompareImageDlg::OnRect() 
{
	// TODO: Add your control notification handler code here
	m_RoiType=ROI_RECT;
}

void CCompareImageDlg::OnClearRect() 
{
	// TODO: Add your control notification handler code here
	if( m_hRoi ) {
		::CKFreeRoi( m_hRoi );
		m_hRoi = NULL;
		Invalidate( FALSE );
		m_RoiType = ROI_NULL; 
	}
}

void CCompareImageDlg::OnSetSearchArea() 
{
	// TODO: Add your control notification handler code here
	RECT rect;
	rect.left=GetDlgItemInt( IDC_P7 );
	rect.top=GetDlgItemInt( IDC_P8 );
	rect.right=GetDlgItemInt( IDC_P9 );
	rect.bottom=GetDlgItemInt( IDC_P10 );
	if(m_hRoi)
		::CKFreeRoi( m_hRoi );
	m_hRoi = CKRectToRoi( &rect );
    Invalidate( FALSE );
}