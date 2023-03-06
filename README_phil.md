# Notes about the changes I made

This could be a commit message but I want to have a file that I can add stuff
to.

## In-house dependencies

I use the librmn compiled on my mac for which I needed to update the 
`cmake_rpn` submodule.  I used this `cmake_rpn`.

I used the one on my mac and didn't bother to update the submodule.  For
reference this is commit : 

`cmake_rpn` : `108622a2bf2e586c7d4097402cede5eb04680291`
`librmn` : 1ebfa86633710d66a7c6543e8b84626cc2b6a9d3

```
export librmn_DIR=<...>
export EC_CMAKE_MODULE_PATH=<...>
mkdir build
cd build
cmake ..
```

## Non-in-house dependencies

Other than that, I added `find_package(<X> REQUIRED)` for 
- PNG
- X11
- Motif
- JPEG
and replaced some `-l<x>` with the appropriate imported target from one of those
libraries.  Only `Motif` did not provide an imported target so I had to use
`${MOTIF_LIBRARIES}` for that one.

For linking, although I did my best to link with all the right libraries, I
still got undefined references when doing the link step for some executables.
For some of these, it seemed that I had indeed specified the right
`target_link_libraries()` to get the symbol.  I investigated this by either looking
at the linking command or printing out the `IMPORTED_LOCATION` property of the
target I suspected to provide the symbol.  Then using `nm` to see if indeed the
library did have the symbol I was looking for.  When I found that it did have
the symbol, I stopped looking and added the `-undefined dynamic_lookup` option.

This being an Apple Clang option, it should be made conditional on the compiler
ID.  But now that it works, I want to save a version before I make any changes
whatsoever.

## Function declarations

The most frequent problem was function declarations.  I started by fixing them
by finding the function definitions and adding their declaration in what looked
like the most appropriate place.

After a while I stopped doing that and simply added 
`target_compile_definitions(<X> PRIVATE -Wno-error=implicit-function-declaration)`.

## Function return types

Many functions are declared as returning `int` (some explicit, some implicit)
but containt `return;` in the code.  That tells me that nobody cares about their
return values so I got rid of the warnings by changing `return;` to `return 0;`
without much regard for what the actual value should be.

Also, I think these were all warnings that I fixed out of zeal.  This zeal
vanished at the same time as my desire to fix `implicit-function-declaration`
errors.

