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
      SUBROUTINE XDASHI(IPAT)
*     implicit none
      COMMON /XDASHD2/ FPART,IPAU,IGP,IOFFS,TENSN,NP,SMALL,L1
      INTEGER IPAT,IPLOC
      CHARACTER *16 ICT
      IMSK = 32768
      DO 10 I = 1,16
        IF (IAND(IMSK,IPAT) .EQ. 0) THEN
          ICT(I:I) = '"'
        ELSE
          ICT(I:I) = '$'
        ENDIF
        IMSK = IMSK / 2
  10  CONTINUE
      CALL XDASHD(ICT,16,IPAU,0)
      RETURN
      END
