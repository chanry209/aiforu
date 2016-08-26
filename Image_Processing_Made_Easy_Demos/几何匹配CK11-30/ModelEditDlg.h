#if !defined(AFX_MODELEDITDLG_H__55891B86_FC62_4739_9448_D2026372F134__INCLUDED_)
#define AFX_MODELEDITDLG_H__55891B86_FC62_4739_9448_D2026372F134__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// ModelEditDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CModelEditDlg dialog

class CModelEditDlg : public CDialog
{
// Construction
public:
	void EnableAll();
	void EditModel( BOOL IsEdit );
	CModelEditDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CModelEditDlg)
	enum { IDD = IDD_MODEL_EDIT_DLG };
	CComboBox	m_ModelTypeBox;
	//}}AFX_DATA

	BOOL	m_EditModel;

	HMODEL	m_hModel;
	LEARNOPTION m_Option;

	double	m_ModelCX;
	double	m_ModelCY;

	RECT	m_PenRect;
	int		m_PenWidth;
	int		m_PointState;

	CRect	m_ViewRect;
	CPoint	m_ViewPoint;
	CPoint	m_RsPoint;
	CPoint	m_OldPoint;

	HROI	m_hRoi;
	short	m_RoiType;
	int		m_RoiNode; 
	BOOL	m_IsDispRoiNode;

	HIMAGE	m_hImage;


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CModelEditDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CModelEditDlg)
	afx_msg void OnPaint();
	virtual BOOL OnInitDialog();
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnAddEdge();
	afx_msg void OnDelEdge();
	virtual void OnOK();
	virtual void OnCancel();
	afx_msg void OnSelchangeCombo1();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MODELEDITDLG_H__55891B86_FC62_4739_9448_D2026372F134__INCLUDED_)
