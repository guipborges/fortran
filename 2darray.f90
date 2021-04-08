program Array2d
    implicit none
    !variables
    real, dimension(:,:), allocatable :: myArray
    integer::n_row, n_col, i,j
    !receive data from std terminal
    print *, 'Enter the row size:'
    read *, n_row
    print *, 'Enter the column size'
    read*, n_col
    !allocate memory for dynamic array
    allocate(myArray(n_row,n_col))
    !fill the array
    do i = 1, n_row
        do j = 1, n_col
        myArray(i,j) = i * 2
        enddo
    end do
    !print *, n, myArray(:,:)

    !do i = 1, n_row
    !    print *, i, myArray(i,:)
    !end do
    !wrong
    !do j = 1, n_col
    !    print *, i, myArray(:,j)
    !end do
    write( * , "(*(g0)) ") myArray

    write( * , "(*(g0))" ) ( (myArray(i,j)," ",j=1,n_row), new_line("A"), i=1,n_col )
    deallocate(myArray)
    
end program Array2d