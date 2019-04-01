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
      SUBROUTINE XSYSDAT
*
*
*
*     implicit none
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
      COMMON /XSYSPL2/ MFMT(2)
      CHARACTER *(20) MFMT
*
*      VARIABLES                 USE
*      ---------                 ---
*
* MMAJX,MMAJY,MMINX,   GRIDAL ARGUMENTS STORED HERE SO THEY WILL BE IN
* MMINY,MXLAB,MYLAB,   KNOWN ORDER FOR INSERTION IN THE INSTRUCTION
* MFLG                 STREAM ONLY WHEN ULTRACOMPACT METACODE IS
*                      BEING PRODUCED.
*
* MTYPE                SCALING TYPE OF THE MOST RECENT SET CALL
*
* MX,MY                PLOTTER ADDRESS OF THE PEN LOCATION
*
* MXA,MYA,MXB,MYB      PLOTTER ADDRESS CORRESPONDING TO THE FIRST FOUR
*                      ARGUMENTS OF THE MOST RECENT SET CALL.
*
* MTYPEX,MTYPEY        A DECODING OF MTYPE-- 0 = LINEAR, 1 = LOG
*
* XXA,YYA,XXB,YYB,     EXACT COPIES OF THE FIRST EIGHT PARAMETERS
* XXC,YYC,XXD,YYD      OF THE MOST RECENT SET CALL
*
* XFACTR,YFACTR,XADD,  NUMBERS COMPUTED FROM THE MOST RECENT SET CALL
* YADD                 ARGUMENTS SO THAT REAL VALUED COORDINATES CAN
*                      BE TRANSLATED TO INTEGERS BY
*                       MX = XFACTR*XX + XADD
*                      OR
*                       MX = XFACTR*ALOG10(XX) + XADD
*                      AND SIMILARLY FOR Y.
*
* XX,YY                MOST RECENT COORDINATE INPUT TO THE PLOT PACKAGE
*
* MFMTX,MFMTY,MUMX,    MOST RECENT LABMOD INPUTS EXCEPT THAT MXDEC = 0
* MUMY,MSIZX,MSIZY,    AND MYDEC = 0 ARE DECODED AND MXDEC = 1 AND
* MXDEC,MYDEC,MXOR     MYDEC = 1 BECOME 0.
*
* MOP(I)               OPTION VALUES ARE GIVEN IN MOP
*
* MXOLD,MYOLD,MXMAX,   ALL USED FOR INCREMENT INSTRUCTIONS ONLY.  MXOLD
* MYMAX,MXFAC,MYFAC    AND MYOLD ARE THE PLOTTER COORDINATES OF THE
*                      PREVIOUS POINT, MXMAX AND MYMAX ARE THE GREATEST
*                      DISTANCE AN INCREMENT CAN MOVE, AND MXFAC AND
*                      MYFAC ARE THE NUMBER OF PLOTTER UNITS PER
*                      INCREMENT UNIT (GENERALLY 1, BUT CAN BE MORE IF
*                      COMPACTION IS IMPORTANT AND HIGH RESOLUTION IS
*                      NOT).
*
* MODEF                = 0 FLASH ROUTINES HAVE NOT BEEN USED
*                      = 1 MOST RECENT FLASH CALL WAS TO FLASH1
*                          (WE ARE BETWEEN FLASH1 AND FLASH2 CALLS
*                          AND THE INSTRUCTIONS SHOULD BE PUT IN THE
*                          USERS BUFFER)
*                      = 2 FLASH1 CALL HAS BEEN CLOSED WITH A
*                          FLASH2 CALL
*
* MTABLE(64)           TRANSLATION TABLE TO CHANGE 6-BIT CHARACTERS
*                      TO 8-BIT CHARACTERS (ONLY ON 6 BIT-PER-CHARAC-
*                      TER MACHINES)
*
* MF2ER                = 0 NO FLASH BUFFER OVERFLOW
*                      = N COUNTS THE NUMBER OF TIMES THE BUFFER
*                          WAS REUSED SO THE REQUIRED SIZE CAN BE
*                          ESTIMATED
*
* MSHFTX,MSHFTY        THE POWER OF TWO OF THE RATIO BETWEEN THE
*                      RESOLUTION OF THE METACODE ADDRESS AND THE
*                      RESOLUTION THE USER IS WORKING IN.  IN THE
*                      DEFAULT CASE, THE USER ASSUMES THE PLOTTER
*                      IS 1024 BY 1024 (1024 = 2 **10).  METACODE
*                      ADDRESSES HAVE 15 BITS, SO THEIR CAPACITY IS
*                      32,768.  THUS, THE DEFAULT FOR MSHFTX AND MSHFTY
*                      IS 5, AND USER INTEGER COORDINATES ARE LEFT
*                      SHIFTED 5 TO MAKE PLOTTER ADDRESSES.
*
* MMGRX,MMGRY,MMNRX,   TICK MARK LENGTHS (POSITIVE VALUES POINT IN)
* MMNRY
*
* MFRCNT               COUNTS THE NUMBER OF FRAME CALLS IN A BUFFER FOR
*                      ACCOUNTING
*
* MJXMIN,MJYMIN,       USED TO KEEP TRACK OF THE RANGE OF THE PLOTTING
* MJXMAX,MJYMAX        ADDRESS ON THE FRAME BEING CREATED
*
* IPUNIT               UNIT NUMBER FOR PRINTING ERROR MESSAGES TOO
*                      EXTENSIVE TO BE HANDLED BY ULIBER
*
*   IBUF               BUFFER TO HOLD METACODE
*                      INSTRUCTIONS
*
*
* MINST                HOLDS INSTRUCTION OP-CODE FOR THE INSTRUCTION
*                      BEING FORMED
*
*
*
* MFWA,MLWA            CONTAINS THE FIRST WORD ADDRESS AND THE LAST
*                      WORD ADDRESS FOR THE FLASH BUFFERS
*
* MFLFR                CONTAINS THE NUMBER OF FRAME CALLS FOR EACH
*                      FLASH BUFFER
*
* MIPAIR,MBPRS         MBPRS IS USED TO STORE BYTE PAIRS OF METACODE
*                      UNTIL THEY CAN BE PACKED IN AN INTEGRAL NUMBER
*                      OF WORDS AND PLACED IN THE BUFFER POINTED TO BY
*                      USED.
*
*
* IMUNIT                UNIT NUMBER FOR WRITING METACODE
*
* SMALL                SMALLEST POSITIVE NUMBER ON THE HOST COMPUTER.
*                      THIS IS USED WHEN NONPOSITIVE NUMBERS ARE PLOTTE
*                      WITH LOG SCALING.
*
*
*
      DATA MTYPE,MTYPEX,MTYPEY/1,0,0/
      DATA MX,MY/0,0/
      DATA XXA,YYA,XXB,YYB/0.,0.,1.,1./
      DATA XXC,YYC,XXD,YYD/0.,0.,1.,1./
      DATA MXA,MYA,MXB,MYB/1,1,32767,32767/
      DATA XFACTR,YFACTR/32767.,32767./
      DATA XADD,YADD/-2.,-2./
      DATA MFMT(1) /'(F10.2)'/
      DATA MFMT(2) /'(F10.2)'/
      DATA MUMX,MUMY/10,10/
      DATA MSIZX,MSIZY/0,0/
      DATA MXDEC,MYDEC/20,20/
      DATA MXOR/0/
      DATA MXOLD,MYOLD/-9999,-9999/
      DATA MXMAX,MYMAX/31,31/
      DATA MXFAC,MYFAC/1,1/
      DATA MMGRX,MMGRY/12,12/
      DATA MMNRX,MMNRY/8,8/
      DATA MODEF/0/
      DATA PIPEFLG/0/
*
*IMPLICITES
*
*         REVERSE - ECRIRE LES CARACTERES BLANC SUR NOIR
*         INTEN   - INTESITE (EPAISSEUR DU TRAIT POUR LES CARACTERES)
*         ANOT    - ANGLE D'ANNOTATION POUR LES CARACTERES
*         SIZE    - GROSSEUR DES CARACTERES
*         CASE    - FONTE DES CARACTERES
*         UNDER   - SOUS-LIGNAGE
*         BOX     - ENCADREMENT
*         FILL    - EFFACE LES LIGNES AU LIEU DE TRACER
*         THICK   - EPAISSEUR DU TRAIT POUR LES LIGNES (1-255)
*         CLR     - NETTOIE AVANT D'ECRIRE
*         ENHANCE - AMELIORATION DE L'IMPRIME
*         HSPACE  - ESPACEMENT HORIZONTAL
*         VSPACE  - ESPACEMENT VERTICAL
*         ORN     - ANGLE D'ORIENTATION
*         SLANT   - ANGLE SLANT
*         COLOR   - COULEUR
*         BLINK   - CLIGNOTEMENT
*         DASH    - POINTILLE
*         CW      - LARGEUR DES CARACTERES
*         CH      - HAUTEUR DES CARACTERES
*         PAT     - PATRON DE REMPLISSAGE DES POLYGONES
*         PCHAR   - IMPRIMER/EFFACER POUR LES CARACTERES
*
*
      DATA(MOP(I,0),I=1 ,5 )   /   0   ,   1   ,   0   ,  16   ,  0
     %   /
      DATA(MOP(I,0),I=6 ,10)   /   0   ,   0   ,   1   ,   1   ,  0
     %   /
      DATA(MOP(I,0),I=11,15)   /   0   ,  16   ,  16   ,   0   ,  0
     %   /
      DATA(MOP(I,0),I=16,20)   /   1   ,   0   ,   0   ,  16   , 16
     %   /
      DATA(MOP(I,0),I=21,25)   /   0   ,   1   ,  12   ,   0   ,  1
     %   /
      DATA(MOP(I,0),I=26,30)   /   1   ,   1   ,   0   ,   0   ,  0
     %   /
*
*
      DATA (MOPRIN(I),I=1 ,5 )  /  0   ,   1   ,   0   ,  16   ,  0
     %   /
      DATA (MOPRIN(I),I=6 ,10)  /  0   ,   0   ,   1   ,   1   ,  0
     %   /
      DATA (MOPRIN(I),I=11,15)  /  0   ,  16   ,  16   ,   0   ,  0
     %   /
      DATA (MOPRIN(I),I=16,20)  /  1   ,   0   ,   0   ,  16   , 16
     %   /
      DATA (MOPRIN(I),I=21,25)  /  0   ,   1   ,  12   ,   0   ,  1
     %   /
      DATA (MOPRIN(I),I=26,30)  /  1   ,   1   ,   0   ,   0   ,  0
     %   /
*
      DATA PASDEF /30 * .TRUE./
*
*
      DATA IWCUR   /1/
      DATA IWCURF  /1/
* ********************** NOTE TO IMPLEMENTORS *************************
*
* ON 6 BIT PER CHARACTER MACHINES, THE ARRAY ITABLE SHOULD MAP THE INPU
* 6 BIT PATTERNS INTO THE PROPER OUTPUT 8 BIT PATTERNS.
*
      DATA MF2ER/0/
      DATA MSHFTX,MSHFTY/5,5/
      DATA MIPAIR/0/
      DATA MFRCNT/0/
      DATA MJXMAX,MJYMAX,MJXMIN,MJYMIN/0,0,32767,32767/
*
* ********************** NOTE TO IMPLEMENTORS *************************
*
* SET TO UNIT NUMBER FOR PRINTER
*
      DATA IPUNIT/6/
      DATA NBITS/0/
      DATA MBUF/90 * 0/
      DATA IVAR/0/
      DATA INDEX/0/
*
* ********************** NOTE TO IMPLEMENTORS *************************
*
* SET TO UNIT NUMBER FOR PLOTTER
*
      DATA SAVUNIT /0/
      DATA SEGSAVU /0/
      DATA IMUNIT  /888/
      DATA SEGUNIT /999/
      DATA MTCLOS /.TRUE./
      DATA FLCLOS /.TRUE./
      DATA SEGCLOS /.TRUE./
*
* ********************** NOTE TO IMPLEMENTORS *************************
*
* SET TO SMALLEST POSITIVE NUMBER ON THE COMPUTER
*
      DATA SMALL/1.E-35/
      DATA IWIDE/8,12,16,24/
      mxa = 1
      mya = 1
      call wglgwz(mxb, myb)
      mjxmin = mxb
      mjymin = myb
      mjxmax = mxa
      mjymax = mya
      RETURN
      END
