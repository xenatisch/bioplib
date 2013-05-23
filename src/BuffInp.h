/*************************************************************************

   Program:    
   File:       BuffInp.h
   
   Version:    V1.0R
   Date:       08.03.94
   Function:   Header file for BuffInp.c
   
   Copyright:  (c) SciTech Software 1994
   Author:     Dr. Andrew C. R. Martin
   Address:    SciTech Software
               23, Stag Leys,
               Ashtead,
               Surrey,
               KT21 2TD.
   Phone:      +44 (0) 1372 275775
   EMail:      martin@biochem.ucl.ac.uk
               
**************************************************************************

   This program is not in the public domain, but it may be copied
   according to the conditions laid out in the accompanying file
   COPYING.DOC

   The code may not be sold commercially or included as part of a 
   commercial product except as described in the file COPYING.DOC.

**************************************************************************

   Description:
   ============

**************************************************************************

   Usage:
   ======

**************************************************************************

   Revision History:
   =================

*************************************************************************/
#ifndef _BUFFINPUT_H
#define _BUFFINPUT_H

/************************************************************************/
/* Includes
*/
#include <stdio.h>
#include "SysDefs.h"

/************************************************************************/
/* Defines
*/
typedef struct
{
   FILE *fp;
   char *buffer;
   int  nlines,
        maxstr;
}  INBUFFER;

/************************************************************************/
/* Prototypes
*/
INBUFFER *OpenBufferedFile(char *filename, int maxstr);
BOOL ReadBufferedFile(INBUFFER *bfp, char *string, int length);
BOOL ProbeBufferedFile(INBUFFER *bfp, char *string, int length);

#endif
