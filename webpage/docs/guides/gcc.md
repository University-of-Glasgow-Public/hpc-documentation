# GCC

The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Java, Ada, and Go, as well as libraries for these languages (libstdc++, libgcj,…). GCC was originally written as the compiler for the GNU operating system.

Please pay attention to use the right version needed! Dependency to other modules will be handled by the module system.

Loading modules with differing GCC versions as dependency could cause problems. Please make sure to use module purge in between working with modules with differing GCC dependencies.

If you need to use a lot of packages with differing GCC versions, you might want to switch to using a conda environment or Apptainer containers instead.

For usage information run the following command after loading the module:

`gcc --help`

## Example

My source code is written in C below and saved to a file called helloMARS.c:

```
#include <stdio.h>

int main (void)
{
        printf ("I used GCC version %d.%d to compile this on MARS!\n", __GNUC__, __GNUC_MINOR__);
        return 0;
}
```

For my example I am loading GCC in the version 13.1, but could use any other available one:

```
module load compilers/gcc/13.1.0
```

I can now compile my program:

```
gcc helloMARS.c -o hello_mars
```

Now I can run my created executable:

```
$ ./hello_mars
I used GCC version 13.1 to compile this on MARS!
```

## External Resources

[GCC Website](https://gcc.gnu.org/)
