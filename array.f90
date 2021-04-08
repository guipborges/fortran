!Important: Arrays in Fortran are one-based by default; this means that the first element along any dimension is at index 1.
program arrayTest
    implicit none
    integer, dimension(10) :: array1
    !or
    integer :: array2(10)

    !2d array
    integer, dimension(10,10) :: array3
    !or
    integer :: array4(10,10)
    !custom array 
    real :: array5(0:10)
    real :: array6(-5:5)
    print *, 'array 5', array6(-5:5)

    
end program arrayTest