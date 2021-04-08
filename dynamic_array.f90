program dynArray
    implicit none
    real, dimension(:), allocatable :: myArray
    integer::n_elements

    n_elements = 3

    allocate(myArray(n_elements))

    myArray(1) = 3
    myArray(2) = 4
    myArray(3) = 5

    print *, myArray

    deallocate(myArray) 


end program dynArray