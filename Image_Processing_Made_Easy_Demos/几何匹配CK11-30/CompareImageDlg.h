// CompareImageDlg.h : header file
//

#if !defined(AFX_COMPAREIMAGEDLG_H__654CF798_6C05_4EEA_9128_A3B2C3AD24B4__INCLUDED_)
#define AFX_COMPAREIMAGEDLG_H__654CF798_6C05_4EEA_9128_A3B2C3AD24B4__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "ModelEditDlg.h"

/////////////////////////////////////////////////////////////////////////////
// CCompareImageDlg dialog

VOID CALLBACK GrabProcess( DWORD Data, WORD Port );

class CCompareImageDlg : public CDialog
{
// Construction
public:
	CCompareImageDlg(CWnd* pParent = NULL);	// standard constructor
	void BeginTime();
	void EndTime();


	void DrawObject(CDC *pDC);  //显示对象(图像或其他)

	CPoint		m_DispPoint; //视图原点
	RECT		m_Rect;     //图像背景显示区域
	CRect		m_DispRect2;  //图像背景定义的变量


	CString		m_FileName; //文件名
	HIMAGE		m_hImage;    //图像数据句柄
	int			m_ImgType;//图像类型
	int			m_ImgWidth;     //图像宽度
	int			m_ImgHeight;    //图像高度

	HROI		m_hRoi;		//ROI
	int			m_RoiNode;  //ROI节点
	short		m_RoiType;  //ROI类型

	POINT		m_RsPoint;  //图像移动定义的变量
	CPoint		m_OldPoint;  //图像移动定义的变量

	CModelEditDlg m_ModelEditDlg;//匹配
	int			m_iMatchCount;  //匹配
	MATCH*		pMatchArray; //匹配
 
	// 
	LARGE_INTEGER m_Frequency;
	LARGE_INTEGER m_BeginTime;
	LARGE_INTEGER m_EndTime;
// Dialog Data
	//{{AFX_DATA(CCompareImageDlg)
	enum { IDD = IDD_COMPAREIMAGE_DIALOG };
	CListCtrl	m_list1;
	CButton	m_DrawRect;
	CButton	m_DrawEdge;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCompareImageDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CCompareImageDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnOpenImage();
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnStartCollection();
	afx_msg void OnStopCollection();
	afx_msg void OnCreateModel();
	afx_msg void OnEditModel();
	afx_msg void OnSearchObject();
	afx_msg void OnDrawRect();
	afx_msg void OnDrawEdge();
	afx_msg void OnLoadModel();
	afx_msg void OnSaveModel();
	afx_msg void OnRect();
	afx_msg void OnClearRect();
	afx_msg void OnSetSearchArea();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_COMPAREIMAGEDLG_H__654CF798_6C05_4EEA_9128_A3B2C3AD24B4__INCLUDED_)
