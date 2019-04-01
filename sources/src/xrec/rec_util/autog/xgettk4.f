*/* RMNLIB - Library of useful routines for C and FORTRAN programming
* * Copyright (C) 1975-2001  Division de Recherche en Prevision Numerique
* *                          Environnement Canada
* *
* * This library is free software; you can redistribute it and/or
* * modify it under the terms of the GNU Lesser General Public
* * License as published by the Free Software Foundation,
* * version 2.1 of the License.
* *
* * This library is distributed in the hope that it will be useful,
* * but WITHOUT ANY WARRANTY; without even the implied warranty of
* * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* * Lesser General Public License for more details.
* *
* * You should have received a copy of the GNU Lesser General Public
* * License along with this library; if not, write to the
* * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
* * Boston, MA 02111-1307, USA.
* */
      SUBROUTINE XGETTK4 (MGRX,MNRX,MGRY,MNRY)
*     implicit none
*     IMPLICIT NONE volontairement laisse a OFF 
*
*
      INTEGER SAVUNIT,SEGUNIT,SEGSAVU,PIPEFLG
      LOGICAL MTCLOS,FLCLOS,SAVCLOS,SEGCLOS,SSCLOS,PASDEF
*
      COMMON /XSYSPL1/ MMAJX   ,MMAJY   ,MMINX   ,MMINY
      COMMON /XSYSPL1/ MXLAB   ,MYLAB   ,MFLG   ,MTYPE
      COMMON /XSYSPL1/ MXA   ,MYA   ,MXB   ,MYB
      COMMON /XSYSPL1/ MX   ,MY   ,MTYPEX   ,MTYPEY
      COMMON /XSYSPL1/ XXA   ,YYA   ,XXB   ,YYB
      COMMON /XSYSPL1/ XXC   ,YYC   ,XXD   ,YYD
      COMMON /XSYSPL1/ XFACTR   ,YFACTR   ,XADD   ,YADD
      COMMON /XSYSPL1/ MUMX   ,MUMY   ,MSIZX   ,MSIZY
      COMMON /XSYSPL1/ MXDEC   ,MYDEC   ,MXOR   ,MOP(30,-1:32)
      COMMON /XSYSPL1/ MXOLD   ,MYOLD   ,MXMAX   ,PASDEF(30)
      COMMON /XSYSPL1/ MYMAX   ,MXFAC   ,MYFAC   ,MODEF
      COMMON /XSYSPL1/ MF2ER   ,MSHFTX   ,MSHFTY
      COMMON /XSYSPL1/ MMGRX   ,MMGRY   ,MMNRX   ,MMNRY
      COMMON /XSYSPL1/ MFRCNT   ,MJXMIN   ,MJYMIN   ,MJXMAX
      COMMON /XSYSPL1/ MJYMAX   ,SMALL   ,XX   ,YY
      COMMON /XSYSPL1/ IVAR   ,IMUNIT   ,IPUNIT
      COMMON /XSYSPL1/ NBITS   ,INDEX   ,MBUF(90)
      COMMON /XSYSPL1/ IWIDE(0:3) ,IWCUR   ,PIPEFLG
      COMMON /XSYSPL1/ IFLSHNT   ,IWCURF   ,IWCURS   ,SAVUNIT
      COMMON /XSYSPL1/ MTCLOS   ,FLCLOS   ,SAVCLOS   ,SEGCLOS
      COMMON /XSYSPL1/ IWCSEG   ,SEGUNIT   ,SSCLOS   ,SEGSAVU
      INTEGER MOPRIN(30)
      EQUIVALENCE (MOPRIN(1), MOP(1,-1))
*
* MMGRX(Y) IS THE LENGTH IN THE X(Y) DIRECTION OF MAJOR TICK MARKS
* AND IS THEREFOR USED ON THE Y(X) AXIS (TO BE CONSISTENT WITH MX(Y)DEC
* OF LABMOD).
* MGRX(Y) IS THE LENGTH OF X(Y) AXIS MAJOR TICK MARKS.
* SIMILARLY FOR MMNRX(Y) AND MNRX(Y)
*
*     GET THE SIGNS OF TICK4 ARGUMENTS
*
      MSGRX=ISIGN(1,MMGRY)
      MSGRY=ISIGN(1,MMGRX)
      MSNRX=ISIGN(1,MMNRY)
      MSNRY=ISIGN(1,MMNRX)
*
*     GET THE ABSOLUTE VALUES OF TICK4 ARGUMENTS
*
      MAGRX =ishft(IABS(MMGRY),-(MSHFTY))
      MAGRY =ishft(IABS(MMGRX),-(MSHFTX))
      MANRX =ishft(IABS(MMNRY),-(MSHFTY))
      MANRY =ishft(IABS(MMNRX),-(MSHFTX))
*
*     COMPUTE ORIGINAL TICK4 ARGUMENTS
*
      MGRX = MAGRX*MSGRX
      MNRX = MANRX*MSNRX
      MGRY = MAGRY*MSGRY
      MNRY = MANRY*MSNRY
      RETURN
      END
