// stdafx.h : include file for standard system include files,
//  or project specific include files that are used frequently, but
//      are changed infrequently
//

#if !defined(AFX_STDAFX_H__FB3CD660_CB87_4BA1_99CB_A8C7FFD4FD23__INCLUDED_)
#define AFX_STDAFX_H__FB3CD660_CB87_4BA1_99CB_A8C7FFD4FD23__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define VC_EXTRALEAN		// Exclude rarely-used stuff from Windows headers

#include <afxwin.h>         // MFC core and standard components
#include <afxext.h>         // MFC extensions
#include <afxdisp.h>        // MFC Automation classes
#include <afxdtctl.h>		// MFC support for Internet Explorer 4 Common Controls
#ifndef _AFX_NO_AFXCMN_SUPPORT
#include <afxcmn.h>			// MFC support for Windows Common Controls
#endif // _AFX_NO_AFXCMN_SUPPORT


#include "ckvision.h"
#include "MAVision.h"


class CRectMemDC : public CDC
{

public:

	// constructor sets up the memory DC
	CRectMemDC(CDC* pDC, CRect &rect) : CDC()
    {
		ASSERT(pDC != NULL);
		
		m_pDC = pDC;
		m_pOldBitmap = NULL;
		m_rect = rect;
        m_bMemDC = !pDC->IsPrinting();
		
        if (m_bMemDC)	// Create a Memory DC
		{
            CreateCompatibleDC(pDC);
            m_bitmap.CreateCompatibleBitmap(pDC, m_rect.Width(), m_rect.Height());
			m_pOldBitmap = SelectObject(&m_bitmap);
            SetWindowOrg( m_rect.left, m_rect.top );
        }
		else		// Make a copy of the relevent parts of the current DC for printing
		{
            m_bPrinting = pDC->m_bPrinting;
            m_hDC		= pDC->m_hDC;
            m_hAttribDC = pDC->m_hAttribDC;
        }
	}
// Destructor copies the contents of the mem DC to the original DC
	~CRectMemDC()
    {
		if (m_bMemDC) {	
			// Copy the offscreen bitmap onto the screen.
			m_pDC->BitBlt(m_rect.left, m_rect.top, m_rect.Width(), m_rect.Height(),
				this, m_rect.left, m_rect.top, SRCCOPY);
		//	m_pDC->SetStretchBltMode( HALFTONE );
		//	m_pDC->StretchBlt(m_rect.left, m_rect.top, m_rect.Width()*m_fd, m_rect.Height()*m_fd, this,
		//		m_rect.left, m_rect.top, m_rect.Width(), m_rect.Height(), SRCCOPY);
			
            //Swap back the original bitmap.
            SelectObject(m_pOldBitmap);
		} else {
			// All we need to do is replace the DC with an illegal value,
			// this keeps us from accidently deleting the handles associated with
			// the CDC that was passed to the constructor.
            m_hDC = m_hAttribDC = NULL;
		}
	}
	
	// Allow usage as a pointer
    CRectMemDC* operator->() {return this;}
	
    // Allow usage as a pointer
    operator CRectMemDC*() {return this;}

private:
	CBitmap  m_bitmap;		// Offscreen bitmap
    CBitmap* m_pOldBitmap;	// bitmap originally found in CMemDC
    CDC*     m_pDC;			// Saves CDC passed in constructor
    CRect    m_rect;		// Rectangle of drawing area.
    BOOL     m_bMemDC;		// TRUE if CDC really is a Memory DC.
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDAFX_H__FB3CD660_CB87_4BA1_99CB_A8C7FFD4FD23__INCLUDED_)
