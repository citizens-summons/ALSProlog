/*=====================================================================*
 |
 |	odbcaux.c
 |	Copyright (c) 1996 Applied Logic Systems, Inc.
 |
 *=====================================================================*/

#include "alspi.h"
#include "cinterf.h"

#ifdef WIN32
#include <windows.h>
#endif

static int pbi_GetForegroundWindow(void)
{
	PWord arg1, rval;
	int type1, rtype;
		
	PI_getan(&arg1,&type1,1);
	
#ifdef WIN32
	PI_makedouble(&rval,&rtype,(double) (long) GetForegroundWindow());
	if (!PI_unify(arg1,type1,rval,rtype)) PI_FAIL;
#else
	PI_makedouble(&rval,&rtype, 0.0);
	if (!PI_unify(arg1,type1,rval,rtype)) PI_FAIL;
#endif
	PI_SUCCEED;
}

PI_BEGIN
	PI_PDEFINE("o_GetForegroundWindow", 1, pbi_GetForegroundWindow, "_pbi_GetForegroundWindow")
PI_END

void odbcaux_init(void);
void odbcaux_init(void)
{
	PI_INIT;
}
