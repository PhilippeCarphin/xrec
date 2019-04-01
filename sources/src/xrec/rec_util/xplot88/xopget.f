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
***S/P  OPGET  ROUTINE QUI FOUILLE UN DICTIONNAIRE
*
      SUBROUTINE xOPGET(DICT,REF,IAR,IVAL,N)
*
      IMPLICIT NONE
      INTEGER   N
      INTEGER   IAR(N), REF, IVAL, DICT(N)
*
*AUTEUR   M. VALIN  -  C. THIBEAULT   AVRIL 1979
*
*LANGAGE  FORTRAN
*
*OBJET(OPGET)
*         OPGET CHERCHE LA POSITION DE "REF" DANS UN DICTIONNAIRE "DICT"
*         AFIN DE TROUVER DANS LE CHAMP "IAR" LA VALEUR QUI SE TROUVE
*         A LA MEME POSITION.   CETTE VALEUR EST RETOURNE DANS "IVAL".
*         SI ON NE TROUVE PAS "REF" DANS LE DICTIONNAIRE, RIEN N'EST
*         CHANGE.
*
*LIBRAIRIE
*       RMNLIB5,ID=RMNP       (CRAY)
*       CRAYLIB/UN=ASPHLIB    (CYBER)
*       DECK = OPGET
*
*ARGUMENTS
*         DICT   DICTIONNAIRE
*
*         REF    LE PATRON DE CARACTERES QUE L'ON VEUT TROUVER DANS
*                LE DICTIONNAIRE
*
*         IAR    CHAMP D'OU L'ON EXTRAIE IVAL DE LA MEME POSITION QUE
*                REF DANS LE DICTIONNAIRE
*
*         IVAL   VALEUR RETOURNEE
*
*         N      LONGUEUR DU DICTIONNAIRE
*
**
      INTEGER   I
*
      DO 23000 I=1,N
         IF( (DICT(I) .EQ. REF))THEN
            IVAL = IAR(I)
            RETURN
         ENDIF
*
*
23000 CONTINUE
      RETURN
      END
