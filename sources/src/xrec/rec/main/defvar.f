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
      subroutine defvar(nom, id, unites, palette, scale, inddef,
     *                  int1,  int2,  int3,  int4,  int5,  int6,
     *                  int7,  int8,  int9,  int10, int11, int12,
     *                  int13, int14, int15, int16, int17, int18,
     *                  int19, int20, int21, int22, int23, int24)
      implicit none
	integer npar
	common /cdefvar/ npar
      integer nom, id(24), unites(8), palette(8)
      real  scale
      integer inddef
      real  int1(32), int2(32), int3(32), int4(32), int5(32), int6(32)
      real  int7(32), int8(32), int9(32),int10(32),int11(32),int12(32)
      real int13(32),int14(32),int15(32),int16(32),int17(32),int18(32)
      real int19(32),int20(32),int21(32),int22(32),int23(32),int24(32)
      real tabint(24,32)
      integer ntabint(24)
      character*4 cnom
      character*64 cid
      character*32 cunites
      character*32 cpalette
      integer argdims
      external argdims
      integer i,j
      integer ntab, ioffset
      write (cnom, '(a4)') nom
      write (cid, '(24a4)') (id(i),i=1,argdims(2))
      write (cunites, '(8a4)') (unites(i),i=1,argdims(3))
      write (cpalette, '(8a4)') (palette(i),i=1,argdims(4))
      do 10 i=1,24
         ntabint(i) = 0
         do 20 j=1,32
            tabint(i,j) = 0.0
 20      continue
 10   continue
      ntab = npar - 6
      ioffset = 6
      i = 1
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 100 j=1,ntabint(i)
 100        tabint(i,j) = int1(j)
      endif
      i = 2
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 200 j=1,ntabint(i)
 200        tabint(i,j) = int2(j)
      endif
      i = 3
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 300 j=1,ntabint(i)
 300        tabint(i,j) = int3(j)
      endif
      i = 4
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 400 j=1,ntabint(i)
 400        tabint(i,j) = int4(j)
      endif
      i = 5
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 500 j=1,ntabint(i)
 500        tabint(i,j) = int5(j)
      endif
      i = 6
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 600 j=1,ntabint(i)
 600        tabint(i,j) = int6(j)
      endif
      i = 7
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 700 j=1,ntabint(i)
 700        tabint(i,j) = int7(j)
      endif
      i = 8
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 800 j=1,ntabint(i)
 800        tabint(i,j) = int8(j)
      endif
      i = 9
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 900 j=1,ntabint(i)
 900        tabint(i,j) = int9(j)
      endif
      i = 10
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 1000 j=1,ntabint(i)
 1000        tabint(i,j) = int10(j)
      endif
      i = 11
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 1100 j=1,ntabint(i)
 1100        tabint(i,j) = int11(j)
      endif
      i = 12
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 1200 j=1,ntabint(i)
 1200        tabint(i,j) = int12(j)
      endif
      i = 13
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 1300 j=1,ntabint(i)
 1300        tabint(i,j) = int13(j)
      endif
      i = 14
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 1400 j=1,ntabint(i)
 1400        tabint(i,j) = int14(j)
      endif
      i = 15
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 1500 j=1,ntabint(i)
 1500        tabint(i,j) = int15(j)
      endif
      i = 16
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 1600 j=1,ntabint(i)
 1600        tabint(i,j) = int16(j)
      endif
      i = 17
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 1700 j=1,ntabint(i)
 1700        tabint(i,j) = int17(j)
      endif
      i = 18
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 1800 j=1,ntabint(i)
 1800        tabint(i,j) = int18(j)
      endif
      i = 19
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 1900 j=1,ntabint(i)
 1900        tabint(i,j) = int19(j)
      endif
      i = 20
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 2000 j=1,ntabint(i)
 2000        tabint(i,j) = int20(j)
      endif
      i = 21
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 2100 j=1,ntabint(i)
 2100        tabint(i,j) = int21(j)
      endif
      i = 22
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 2200 j=1,ntabint(i)
 2200        tabint(i,j) = int22(j)
      endif
      i = 23
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 2300 j=1,ntabint(i)
 2300        tabint(i,j) = int23(j)
      endif
      i = 24
      if ((i + ioffset).le.npar) then
         ntabint(i) = argdims(i+ioffset)
         do 2400 j=1,ntabint(i)
 2400        tabint(i,j) = int24(j)
      endif
      call initvar(cnom, cid, cunites, cpalette,
     *             scale, inddef, tabint, ntabint)
      return
      end
