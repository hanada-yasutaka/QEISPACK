# QEISPACK

QEISPACK is a modified [fortrun90 eispack library](https://people.sc.fsu.edu/~jburkardt/f_src/eispack/eispack.html) which calculates the eigenvalues and eigenvectors of a matrix in the quadruple precision.
Note that the test has NOT been completed even in the latest version.


## Requirement

- gfortrun (>=4.7) (or the other fortrun compiler which supports quadruple precision computing)

## Usage

   gfortrun -c qeispack.f90
   
## Related Multiple precision Programs

- [mpmath](http://mpmath.org/)
- [MPACK](http://mplapack.sourceforge.net/)

## Comparison
   
- the evaluation for the energy gap (tunnel splitting) in a Hamiltonian system by using double precision Lapack (numpy), Mathematica (100 digits precision) and qeispack (quadruple precision).
![comparison with lapack mathematica qeispack diagonalization routine](figs/compare-res.png)
- the eigenvalues for an unitary matrix 
![comparison for unitary matrxi](figs/unitary_eigenvalues.png)

## Examples and Tests:

   now preparing...
   
## Support

Author has been supported by JSPS KAKENHI Grants No. 16K17767
      