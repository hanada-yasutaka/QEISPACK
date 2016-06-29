program main
  implicit none
  ! the test to solving a complex general matrix by using CG
  call timestamp ( )
  call test_2by2_matrix ( )
  call test_3by3_matrix ( )
  call test_4by4_matrix ( )  
  call timestamp ( )

  stop
end

subroutine test_2by2_matrix ( )
!*****************************************************************************80
!
!! test_2by2_matrix tests CG.
!
!  Discussion:
!
!    CG is for the eigenvalues of a complex general matrix.
!
!    solve eigenvalues and eigenvectors of a complex unitary matrix.
!
!    (Pi    i)
!    (i    Pi)
!
!    The eigenvalues are Pi + i, -Pi + i
!
!    The eigenvector matrix is
!
!    (  1,  1 )/sqrt(2)
!    ( -1,  1 )/sqrt(2)
!
!    Note that the actual eigenvector matrix from EISPACK could
!    be scaled by a real value, or by i, and the columns may
!    appear in any order.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    17 December 2013
!
!  Author:
!
!    Yasutaka Hanada


  integer ( kind = 4 ), parameter :: n = 2
  real ( kind(0Q0) ), parameter :: pi = 4.0*atan(1.0Q0)
  real ( kind(0Q0) ) ai(n,n)
  real ( kind(0Q0) ) ar(n,n)
  integer ( kind = 4 ) i
  integer ( kind = 4 ) ierr
  integer ( kind = 4 ) j
  integer ( kind = 4 ) matz
  real ( kind(0Q0) ) wi(n)
  real ( kind(0Q0) ) wr(n)
  real ( kind(0Q0) ) xi(n,n)
  real ( kind(0Q0) ) xr(n,n)
  
  write ( *, '(a)' ) '========== test_2by2_matrix=========='
  write ( *, '(a)' ) 'test_2by2_matrix'
  write ( *, '(a)' ) '  CG computes the eigenvalues and eigenvectors of '
  write ( *, '(a)' ) '  a unitary class matrix.'
  write ( *, '(a)' ) ' '
  write ( *, '(a,i8)' ) '  Matrix order = ', n
!
!  Set the values of the matrix.
!
  ar(1,1) = 0.0Q+00
  ar(1,2) = pi

  ar(2,1) = pi
  ar(2,2) = 0.0Q+00

  ai(1,1) = 1.0Q+00
  ai(1,2) = 0.0Q+00

  ai(2,1) = 0.0Q+00
  ai(2,2) = 1.0Q+00
!
!  matz = 0 for eigenvalues only,
!  matz = 1 for eigenvalues and eigenvectors.
!
  matz = 1
  call cg ( n, ar, ai, wr, wi, matz, xr, xi, ierr ) !対角化

  if ( ierr /= 0 ) then
    write ( *, '(a)' ) ' '
    write ( *, '(a)' ) 'test_2by2_matrix - Warning!'
    write ( *, '(a,i8)' ) '  The error return flag IERR = ', ierr
    return
  end if

  call r16vec2_print ( n, wr, wi, '  Real and imaginary parts of eigenvalues:(exact result: pi + i, -pi + i)' )
  write ( *, fmt='(a,F45.36)')  "Exact Pi", pi
  
  
  if ( matz /= 0 ) then
    write ( *, '(a)' ) ' '
    write ( *, '(a)' ) 'The eigenvectors are:'
    do i = 1, n
      write ( *, '(a)' ) ' '
      write ( *, '(a,i8)' ) '  Eigenvector ', i
      write ( *, '(a)' ) ' '
      do j = 1, n
        write ( *, * ) xr(j,i), xi(j,i)
      end do
    end do
  end if

  return
end

subroutine test_3by3_matrix ( )
!
!! test_3by3_matrix tests CG.
!
!  Discussion:
!
!    CG is for the eigenvalues of a complex general matrix.
!
!    solve eigenvalues and eigenvectors of a complex unitary matrix.
!
!    (i    Pi    0)
!    (Pi   i    Pi)
!    (0    Pi    i)
!
!    The eigenvalues are -sqrt(2)*pi +i, sqrt(2)*pi + i , i
!    (sqrt(2)pi = 4.4428829381583662470158809900607... ) 
!
!    The eigenvector matrix is
!
!    (  1,  -sqrt(2), 1)/2
!    ( -1,   sqrt(2), 1)/2
!    ( -1,         0, 1)/sqrt(2)
!
!    Note that the actual eigenvector matrix from EISPACK could
!    be scaled by a real value, or by i, and the columns may
!    appear in any order.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    17 December 2013
!
!  Author:
!
!    Yasutaka Hanada

  integer ( kind = 4 ), parameter :: n = 3
  real ( kind(0Q0) ), parameter :: pi = 4.0*atan(1.0q0)
  real ( kind(0Q0) ) ai(n,n)
  real ( kind(0Q0) ) ar(n,n)
  integer ( kind = 4 ) i
  integer ( kind = 4 ) ierr
  integer ( kind = 4 ) j
  integer ( kind = 4 ) matz
  real ( kind(0Q0) ) wi(n)
  real ( kind(0Q0) ) wr(n)
  real ( kind(0Q0) ) xi(n,n)
  real ( kind(0Q0) ) xr(n,n)

  write ( *, '(a)' ) '========== test_3by3_matrix=========='
  write ( *, '(a)' ) '  CG computes the eigenvalues and eigenvectors of '
  write ( *, '(a)' ) '  a unitary class matrix.'
  write ( *, '(a)' ) ' '
  write ( *, '(a,i8)' ) '  Matrix order = ', n
!
!  Set the values of the matrix.
!
  ar(1,1) = 0.0Q+00
  ar(1,2) = pi
  ar(1,3) = 0.0Q+00

  ar(2,1) = pi
  ar(2,2) = 0.0Q+00
  ar(2,3) = pi
  
  ar(3,1) = 0.0Q+00
  ar(3,2) = pi
  ar(3,3) = 0.0Q+00

  ai(1,1) = 1.0Q+00
  ai(1,2) = 0.0Q+00
  ai(1,3) = 0.0Q+00
  
  ai(2,1) = 0.0Q+00
  ai(2,2) = 1.0Q+00
  ai(2,3) = 0.0Q+00
  
  ai(3,1) = 0.0Q+00
  ai(3,2) = 0.0Q+00
  ai(3,3) = 1.0Q+00
!
!  matz = 0 for eigenvalues only,
!  matz = 1 for eigenvalues and eigenvectors.
!
  matz = 1
  call cg ( n, ar, ai, wr, wi, matz, xr, xi, ierr )

  if ( ierr /= 0 ) then
    write ( *, '(a)' ) ' '
    write ( *, '(a)' ) 'test_3by3_matrix - Warning!'
    write ( *, '(a,i8)' ) '  The error return flag IERR = ', ierr
    return
  end if

  call r16vec2_print ( n, wr, wi, '  Real and imaginary parts of eigenvalues:' )

  if ( matz /= 0 ) then
    write ( *, '(a)' ) ' '
    write ( *, '(a)' ) 'The eigenvectors are:'
    do i = 1, n
      write ( *, '(a)' ) ' '
      write ( *, '(a,i8)' ) '  Eigenvector ', i
      write ( *, '(a)' ) ' '
      do j = 1, n
!        write ( *, '(2g14.6)' ) xr(i,j), xi(i,j)
        write ( *, * ) xr(i,j), xi(i,j)
      end do
    end do
  end if

  return
end


subroutine test_4by4_matrix ( )

!*****************************************************************************80
!
!! test_4by4matrix tests CG.
!
!  Discussion:
!
!    CG is for the eigenvalues of a complex general matrix.
!
!    eigenvalues and eigenvectors of a complex general matrix
!    note that the eigenvalues of such a matrix are in general complex.
!    however, we will use the same example we used before, namely
!    a hermitian matrix, so the eigenvalues will in fact be real.
!
!    (3     1     0     0+2i)
!    (1     3     0-2i  0   )
!    (0     0+2i  1     1   )
!    (0-2i  0     1     1   )
!
!    The eigenvalues are 2+2*sqrt(2), 2-2*sqrt(2), 4 and 0
!    (2*sqrt(2)=2.8284271247461900976033774484194)
!
!    The eigenvector matrix is
!
!    (  1+sqrt(2),  1,                -1,          1)
!    (  1+sqrt(2),  1,                 1,         -1)
!    (     i,       -(1+sqrt(2))*i,    i,          i)
!    (    -i,        (1+sqrt(2))*i,    i,          i)
!
!    Note that the actual eigenvector matrix from EISPACK could
!    be scaled by a real value, or by i, and the columns may
!    appear in any order.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    27 January 2008
!
!  Author:
!
!    John Burkardt
!
  implicit none

  integer ( kind = 4 ), parameter :: n = 4

  real ( kind(0Q0) ) ai(n,n)
  real ( kind(0Q0) ) ar(n,n)
  integer ( kind = 4 ) i
  integer ( kind = 4 ) ierr
  integer ( kind = 4 ) j
  integer ( kind = 4 ) matz
  real ( kind(0Q0) ) wi(n)
  real ( kind(0Q0) ) wr(n)
  real ( kind(0Q0) ) xi(n,n)
  real ( kind(0Q0) ) xr(n,n)
  write ( *, '(a)' ) '========== test_4by4_matrix=========='
  write ( *, '(a)' ) 'test_4by4_matrix'
  write ( *, '(a)' ) '  CG computes the eigenvalues and eigenvectors of '
  write ( *, '(a)' ) '  a complex general matrix.'
  write ( *, '(a)' ) ' '
  write ( *, '(a,i8)' ) '  Matrix order = ', n
!
!  Set the values of the matrix.
!
  ar(1,1) = 3.0Q+00
  ar(1,2) = 1.0Q+00
  ar(1,3) = 0.0Q+00
  ar(1,4) = 0.0Q+00

  ar(2,1) = 1.0Q+00
  ar(2,2) = 3.0Q+00
  ar(2,3) = 0.0Q+00
  ar(2,4) = 0.0Q+00

  ar(3,1) = 0.0Q+00
  ar(3,2) = 0.0Q+00
  ar(3,3) = 1.0Q+00
  ar(3,4) = 1.0Q+00

  ar(4,1) = 0.0Q+00
  ar(4,2) = 0.0Q+00
  ar(4,3) = 1.0Q+00
  ar(4,4) = 1.0Q+00

  ai(1,1) = 0.0Q+00
  ai(1,2) = 0.0Q+00
  ai(1,3) = 0.0Q+00
  ai(1,4) = 2.0Q+00

  ai(2,1) = 0.0Q+00
  ai(2,2) = 0.0Q+00
  ai(2,3) = -2.0Q+00
  ai(2,4) = 0.0Q+00

  ai(3,1) = 0.0Q+00
  ai(3,2) = 2.0Q+00
  ai(3,3) = 0.0Q+00
  ai(3,4) = 0.0Q+00

  ai(4,1) = -2.0Q+00
  ai(4,2) = -0.0Q+00
  ai(4,3) = -0.0Q+00
  ai(4,4) = 0.0Q+00
!
!  matz = 0 for eigenvalues only,
!  matz = 1 for eigenvalues and eigenvectors.
!
  matz = 1
  call cg ( n, ar, ai, wr, wi, matz, xr, xi, ierr )

  if ( ierr /= 0 ) then
    write ( *, '(a)' ) ' '
    write ( *, '(a)' ) 'test_4by4_matrix - Warning!'
    write ( *, '(a,i8)' ) '  The error return flag IERR = ', ierr
    return
  end if

  call r16vec2_print ( n, wr, wi, '  Real and imaginary parts of eigenvalues:' )

  if ( matz /= 0 ) then
    write ( *, '(a)' ) ' '
    write ( *, '(a)' ) 'The eigenvectors are:'
    do i = 1, n
      write ( *, '(a)' ) ' '
      write ( *, '(a,i8)' ) '  Eigenvector ', i
      write ( *, '(a)' ) ' '
      do j = 1, n
!        write ( *, '(2g14.6)' ) xr(i,j), xi(i,j)
        write ( *, * ) xr(i,j), xi(i,j)
      end do
    end do
  end if

  return
end
