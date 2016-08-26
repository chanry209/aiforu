// ModelEditDlg.cpp : implementation file
//

#include "stdafx.h"
#include "CompareImage.h"
#include "ModelEditDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CModelEditDlg dialog


CModelEditDlg::CModelEditDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CModelEditDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CModelEditDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT

	m_hImage = NULL ;

	m_EditModel		= FALSE;

	m_hModel		= NULL;
	m_Option.MinAngle = 0;
	m_Option.MaxAngle = 0;
	m_Option.MinScale = 100;
	m_Option.MaxScale = 100;
	m_Option.Distance = 1;
	m_Option.Threshold = 20;
	m_Option.NeedEdge = 40;

	m_PenWidth		= 5;
	m_PointState	= 0;

	m_ModelCX		= 0.0;
	m_ModelCY		= 0.0;

	m_RsPoint.x		= 0;
	m_RsPoint.y		= 0;
	m_OldPoint.x	= 0;
	m_OldPoint.y	= 0;
	m_RoiType		= ROI_RECT;
	m_RoiNode		= 0; 
	m_hRoi			= NULL;
	m_IsDispRoiNode	= FALSE;

}


void CModelEditDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CModelEditDlg)
	DDX_Control(pDX, IDC_COMBO1, m_ModelTypeBox);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CModelEditDlg, CDialog)
	//{{AFX_MSG_MAP(CModelEditDlg)
	ON_WM_PAINT()
	ON_WM_LBUTTONDOWN()
	ON_WM_MOUSEMOVE()
	ON_BN_CLICKED(IDC_ADD_EDGE, OnAddEdge)
	ON_BN_CLICKED(IDC_DEL_EDGE, OnDelEdge)
	ON_CBN_SELCHANGE(IDC_COMBO1, OnSelchangeCombo1)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CModelEditDlg message handlers

void CModelEditDlg::OnPaint() 
{
	CPaintDC dc(this); // device context for painting
	
	// TODO: Add your message handler code here
	

	CRect rect( m_ViewRect.left-m_ViewPoint.x, 
				m_ViewRect.top-m_ViewPoint.y,
				m_ViewRect.right-m_ViewPoint.x, 
				m_ViewRect.bottom-m_ViewPoint.y );
	dc.SetWindowOrg( -m_ViewPoint.x, -m_ViewPoint.y );

	CRectMemDC rmdc( &dc, rect );
	if( m_EditModel == FALSE )
	{
		CKDisplayImage( rmdc.GetSafeHdc(), m_hImage, 0, 0 );
	} else if( m_hModel )
	{
		CKDisplayModel( rmdc.GetSafeHdc(), m_hModel, (float)m_ModelCX, (float)m_ModelCY, 0, 1, RGB( 0, 255, 0 ), RGB( 0, 100, 0 ) );
		int OldRop = rmdc.SetROP2( R2_XORPEN );
		CKDisplayRect( rmdc.GetSafeHdc(), &m_PenRect );
		rmdc.SetROP2( OldRop );
	}
	CKDisplayRoi( rmdc.GetSafeHdc(), m_hRoi, RGB(255, 0, 0) );
	CKDisplayRoiNode( rmdc.GetSafeHdc(), m_hRoi, RGB(255, 0, 0) );

	// Do not call CDialog::OnPaint() for painting messages
}

BOOL CModelEditDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	// TODO: Add extra initialization here
	

	GetDlgItem( IDC_MODEL_RECT )->GetWindowRect( &m_ViewRect );
	ScreenToClient( &m_ViewRect );
	m_ViewPoint.x = m_ViewRect.left;
	m_ViewPoint.y = m_ViewRect.top;

	m_RoiType = ROI_RECT;
	CheckDlgButton( IDC_ADD_EDGE, m_PointState );
	CheckDlgButton( IDC_DEL_EDGE, !m_PointState );

	m_ModelTypeBox.InsertString( 0, "图像边缘" );
	m_ModelTypeBox.InsertString( 1, "圆形" );
	m_ModelTypeBox.InsertString( 2, "矩形" );
	m_ModelTypeBox.SetCurSel( 0 );

	SetDlgItemInt( IDC_EDIT1, m_Option.MinAngle );
	SetDlgItemInt( IDC_EDIT2, m_Option.MaxAngle );
	SetDlgItemInt( IDC_EDIT3, m_Option.MinScale );
	SetDlgItemInt( IDC_EDIT4, m_Option.MaxScale );
	SetDlgItemInt( IDC_EDIT5, m_Option.Threshold );
	SetDlgItemInt( IDC_EDIT6, m_Option.NeedEdge );
	SetDlgItemInt( IDC_EDIT7, m_Option.Distance );
	SetDlgItemInt( IDC_EDIT8, m_PenWidth );

	if( m_hModel )
	{
		MODELINFO ModelInfo;
		CKGetModelInfo( m_hModel, &ModelInfo );
		m_ModelCX = double(ModelInfo.ModWidth) / 2.0;
		m_ModelCY = double(ModelInfo.ModHeight) / 2.0;
		if( m_EditModel	== TRUE )
		{
			m_ViewPoint.x = (long)(m_ViewRect.CenterPoint().x - m_ModelCX);
			m_ViewPoint.y = (long)(m_ViewRect.CenterPoint().y - m_ModelCY);
		}
		if( m_EditModel == TRUE ) 
		{
			SetDlgItemInt( IDC_EDIT1, ModelInfo.MinAngle );
			SetDlgItemInt( IDC_EDIT2, ModelInfo.MaxAngle );
			SetDlgItemInt( IDC_EDIT3, ModelInfo.MinScale );
			SetDlgItemInt( IDC_EDIT4, ModelInfo.MaxScale );
		}
	}

	EnableAll();

	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CModelEditDlg::OnLButtonDown(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	

	m_RsPoint.x = point.x;
	m_RsPoint.y = point.y;
	if( m_EditModel == FALSE )
	{
		m_RoiNode = ::CKGetRoiNode( m_hRoi, point.x - m_ViewPoint.x, point.y - m_ViewPoint.y );
		if( m_RoiNode == 0 )
		{
			if( m_hRoi )
				CKFreeRoi(  m_hRoi );
			m_hRoi = NULL;
			Invalidate( FALSE );
		}
	} else 
	{
		CKSetModelPointState( m_hModel, &m_PenRect, m_PointState );
	}

	CDialog::OnLButtonDown(nFlags, point);
}

void CModelEditDlg::OnMouseMove(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	

	if( m_EditModel == FALSE ) 
	{
		CKSetRoiCursor( m_hRoi, CKGetRoiNode( m_hRoi, point.x-m_ViewPoint.x,
			                                  point.y-m_ViewPoint.y ) );
		if( nFlags == MK_LBUTTON ) 
		{
			if( m_RoiNode == 0 ) 
			{
				if( !m_hRoi )
					m_hRoi = ::CKCreateRoi( m_RoiType );
				::CKSetRoi( m_hRoi,
							m_RsPoint.x - m_ViewPoint.x, 
							m_RsPoint.y - m_ViewPoint.y, 
							point.x - m_ViewPoint.x, 
							point.y - m_ViewPoint.y );
			} else 
			{
				::CKAdjustRoi( m_hRoi, m_RoiNode, point.x - m_ViewPoint.x, 
					           point.y - m_ViewPoint.y );
			}
			Invalidate( FALSE );
		}
	} else 
	{
		m_PenWidth = GetDlgItemInt( IDC_EDIT8 );
		m_PenRect.left		= point.x - m_ViewPoint.x - m_PenWidth;
		m_PenRect.right		= point.x - m_ViewPoint.x + m_PenWidth+1;
		m_PenRect.top		= point.y - m_ViewPoint.y - m_PenWidth;
		m_PenRect.bottom	= point.y - m_ViewPoint.y + m_PenWidth+1;
		if( nFlags == MK_LBUTTON )
		{
			CKSetModelPointState( m_hModel, &m_PenRect, m_PointState );
		}
		Invalidate( FALSE );
	}
	if( nFlags==MK_RBUTTON ) 
	{
		//移动图像时使用;
		m_ViewPoint.x += (point.x-m_OldPoint.x);
		m_ViewPoint.y += (point.y-m_OldPoint.y);
		Invalidate(FALSE);
	}
	m_OldPoint = point;

	CDialog::OnMouseMove(nFlags, point);
}

void CModelEditDlg::OnAddEdge() 
{
	// TODO: Add your control notification handler code here
	
	m_PointState = 1;
	CheckDlgButton( IDC_DEL_EDGE, 0 );

}

void CModelEditDlg::OnDelEdge() 
{
	// TODO: Add your control notification handler code here
	
	m_PointState = 0;
	CheckDlgButton( IDC_ADD_EDGE, 0 );

}

void CModelEditDlg::OnOK() 
{
	// TODO: Add extra validation here
	
	if( m_EditModel == FALSE )
	{
		m_Option.MinAngle	= 0;
		m_Option.MaxAngle	= 0;
		m_Option.MinScale	= 100;
		m_Option.MaxScale	= 100;
		m_Option.Threshold	= GetDlgItemInt( IDC_EDIT5 );
		m_Option.NeedEdge	= GetDlgItemInt( IDC_EDIT6 );
		m_Option.Distance	= GetDlgItemInt( IDC_EDIT7 );

		if( m_hModel )
			CKDestroyModel( m_hModel );

		if( m_ModelTypeBox.GetCurSel() == 0 ) 
		{
			RECT * pRect = CKGetRect( m_hRoi );
			m_hModel = CKLearnModel(m_hImage, pRect, &m_Option );
		} else 
		{
			m_hModel = CKRoiToModel( m_hRoi, &m_Option );
		}
		if( m_hModel )
		{
			MODELINFO ModelInfo;
			CKGetModelInfo( m_hModel, &ModelInfo );
			m_ModelCX = double(ModelInfo.ModWidth) / 2.0;
			m_ModelCY = double(ModelInfo.ModHeight) / 2.0;
			m_ViewPoint.x = (long)(m_ViewRect.CenterPoint().x - m_ModelCX);
			m_ViewPoint.y = (long)(m_ViewRect.CenterPoint().y - m_ModelCY);
			m_EditModel	= TRUE;
			EnableAll();
		} else 
		{
			AfxMessageBox( "学习失败！" );
		}
		if( m_hRoi )
		{
			::CKFreeRoi( m_hRoi );
			m_hRoi = NULL;
		}
		Invalidate( FALSE );
	} else 
	{
		m_Option.MinAngle	= GetDlgItemInt( IDC_EDIT1 );
		m_Option.MaxAngle	= GetDlgItemInt( IDC_EDIT2 );
		m_Option.MinScale	= GetDlgItemInt( IDC_EDIT3 );
		m_Option.MaxScale	= GetDlgItemInt( IDC_EDIT4 );
		CKUpdateModel( m_hModel, &m_Option );
		CDialog::OnOK();
	}


}

void CModelEditDlg::OnCancel() 
{
	// TODO: Add extra cleanup here
	

	if( m_hRoi ) 
	{
		::CKFreeRoi( m_hRoi );
		m_hRoi = NULL;
	}

	CDialog::OnCancel();
}

void CModelEditDlg::OnSelchangeCombo1() 
{
	// TODO: Add your control notification handler code here
	
	switch( m_ModelTypeBox.GetCurSel() ) 
	{
	case 0:
		m_RoiType = ROI_RECT;
		break;
	case 1:
		m_RoiType = ROI_ROUND;
		break;
	case 2:
		m_RoiType = ROI_RECT;
		break;
	}
	Invalidate(FALSE);

}

void CModelEditDlg::EditModel(BOOL IsEdit)
{
	m_EditModel = IsEdit;
}

void CModelEditDlg::EnableAll()
{
	if( m_EditModel )
	{
		SetWindowText( "编辑模板" );
		SetDlgItemText( IDOK, "确定" );
		GetDlgItem( IDC_S1 )->EnableWindow( TRUE );
		GetDlgItem( IDC_S2 )->EnableWindow( TRUE );
		GetDlgItem( IDC_S3 )->EnableWindow( TRUE );
		GetDlgItem( IDC_S4 )->EnableWindow( TRUE );
		GetDlgItem( IDC_S5 )->EnableWindow( FALSE );
		GetDlgItem( IDC_S6 )->EnableWindow( FALSE );
		GetDlgItem( IDC_S7 )->EnableWindow( FALSE );
		GetDlgItem( IDC_EDIT1 )->EnableWindow( TRUE );
		GetDlgItem( IDC_EDIT2 )->EnableWindow( TRUE );
		GetDlgItem( IDC_EDIT3 )->EnableWindow( TRUE );
		GetDlgItem( IDC_EDIT4 )->EnableWindow( TRUE );
		GetDlgItem( IDC_EDIT5 )->EnableWindow( FALSE );
		GetDlgItem( IDC_EDIT6 )->EnableWindow( FALSE );
		GetDlgItem( IDC_EDIT7 )->EnableWindow( FALSE );
		GetDlgItem( IDC_ADD_EDGE )->EnableWindow( TRUE );
		GetDlgItem( IDC_DEL_EDGE )->EnableWindow( TRUE );
		GetDlgItem( IDC_COMBO1 )->EnableWindow( FALSE );
	} else 
	{
		SetWindowText( "创建模板" );
		SetDlgItemText( IDOK, "学习" );
		GetDlgItem( IDC_S1 )->EnableWindow( FALSE );
		GetDlgItem( IDC_S2 )->EnableWindow( FALSE );
		GetDlgItem( IDC_S3 )->EnableWindow( FALSE );
		GetDlgItem( IDC_S4 )->EnableWindow( FALSE );
		GetDlgItem( IDC_S5 )->EnableWindow( TRUE );
		GetDlgItem( IDC_S6 )->EnableWindow( TRUE );
		GetDlgItem( IDC_S7 )->EnableWindow( TRUE );
		GetDlgItem( IDC_EDIT1 )->EnableWindow( FALSE );
		GetDlgItem( IDC_EDIT2 )->EnableWindow( FALSE );
		GetDlgItem( IDC_EDIT3 )->EnableWindow( FALSE );
		GetDlgItem( IDC_EDIT4 )->EnableWindow( FALSE );
		GetDlgItem( IDC_EDIT5 )->EnableWindow( TRUE );
		GetDlgItem( IDC_EDIT6 )->EnableWindow( TRUE );
		GetDlgItem( IDC_EDIT7 )->EnableWindow( TRUE );
		GetDlgItem( IDC_ADD_EDGE )->EnableWindow( FALSE );
		GetDlgItem( IDC_DEL_EDGE )->EnableWindow( FALSE );
		GetDlgItem( IDC_COMBO1 )->EnableWindow( TRUE );
	}
}
