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
*
***S/P    XLINRD    CONSTRUIT LE FORMAT HOLLERITH POUR NUMEROTER LES
*                  AXES X OU Y D'UN GRAPHIQUE.  ROUTINE UTILISEE PAR
*                  PLOT80 POUR DES AXES LINEAIRES.
*
      SUBROUTINE XLINRD (XMIN,XMAX,XB,XT,MGRX,INRX,IFMT,NUM,IOR)
      IMPLICIT NONE
*
*AUTEUR   SYSTEME NCAR
*
*REVISION001   FEVRIER 1977  -  MODIFIE POUR UTILISER DES VALEURS DE X
*                               DECROISSANTES QUAND L'USAGER FAIT UN
*                               APPEL A SET.
*
*REVISION002   AVRIL 1977    -  AMELIORE REVISION001 ET MODIFIE LA
*                               DOCUMENTATION.
*
*REVISION 003  RPN  M.VALIN / C.THIBEAULT  1-4-79  REFAIT DOCUMENTATION
*
*----------------------------------------------------------------------
*
      INTEGER ICRT,ID,ILGRG,INRX,IOR,ISIGN,J1,J2,MGRX,NM,NUM
      REAL DIVSIZ,EPS,RANGE,RDN,RDX,RONDRG,XB,XC,XMAX,XMIN,XSV,XT
      CHARACTER *8 IFMT
*
      ISIGN=0
      IF (XMIN .LE. XMAX) GO TO 100
      ISIGN=1
      XSV=XMIN
      XMIN=XMAX
      XMAX=XSV
  100 CONTINUE
      RANGE = XMAX-XMIN
      EPS = 1.E-8*AMAX1(ABS (XMAX),ABS (XMIN))
      IF (RANGE .GT. EPS) GOTO 102
  101 XB=(XMIN-1.)-XMIN*(1.-(XMIN-(XMIN-1.)))
      XT=XMAX+XMIN-XB
      MGRX = 2
      INRX = 2
      RANGE = XT-XB
      ILGRG = ALOG10(RANGE)
      GO TO 106
  102 ILGRG = ALOG10(RANGE)
      IF (RANGE .LE. 1.) ILGRG = ILGRG-1
      RONDRG = 10.**ILGRG
      RDN = RANGE/RONDRG
      RDX = 1.
      IF (RDN .LE. 6.) RDX = .5
      IF (RDN .LE. 2.) RDX = .2
      DIVSIZ = RONDRG*RDX
      J1 = XMIN/DIVSIZ
      J2 = XMAX/DIVSIZ
      XB = J1*DIVSIZ
      XT = J2*DIVSIZ
      IF (XB .LE. XMIN+EPS) GO TO 103
      XB = XB-DIVSIZ
      J1 = J1-1
  103 IF (XT .GE. XMAX-EPS) GO TO 105
  104 XT = XT+DIVSIZ
      J2 = J2+1
  105 IF (J1 .EQ. J2) GO TO 104
      MGRX = J2-J1
      INRX = AMIN1(10.*RDX+.1,5.05)
  106 CONTINUE
      IF (ABS (XB) .LT. EPS) XB = 0
      IF (ABS (XT) .LT. EPS) XT = 0
      XC = AMAX1(ABS (XB),ABS (XT))
      NM=AMAX1(ALOG10(XC)+1.01,1.)
      IF (XB .LT. 0) NM = NM+1
      ID = AMAX0(-ILGRG+1,0)
      NM=NM+1
      NUM = NM+ID
      IF (NUM .GT. 5) GOTO 108
  107 WRITE (IFMT,1001) NUM,ID
      GO TO 109
  108 NUM = 9
      IFMT = '(E9.2)'
  109 ICRT = 12*NUM*MGRX
      IOR = 0
      IF (ICRT .GT. 790) IOR = 90
      IF (ISIGN .EQ. 0) GO TO 110
      XSV=XMIN
      XMIN=XMAX
      XMAX=XSV
      XSV=XB
      XB=XT
      XT=XSV
  110 CONTINUE
      RETURN
*
*----------------------------------------------------------------------
*
 1001 FORMAT ('(F',I2,'.',I1,')')
*
      END
