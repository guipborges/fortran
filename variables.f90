!There are 5 built-in data types in Fortran:
!integer – for data that represent whole numbers, positive or negative
!real – for floating-point data (not a whole number)
!complex – pair consisting of a real part and an imaginary part
!character – for text data
!logical – for data that represent boolean (true or false) values
program variables
    implicit none !This statement tells the compiler that all variables will be explicitly declared;
    integer  :: amount
    real :: pi
    complex :: frequency !Fortran code is case-insensitive; you don’t have to worry about the capitalisation of your variable names but it’s good practice to keep it consistent.
    character :: initial
    logical :: isOkay   

    amount = 10
    pi = 3.14
    frequency = (1.,-0.5)
    initial = 'A'
    isOkay = .false.  !or .true.


    print *, 'The amount value is:',amount
    print *, 'The pi value is:',pi
    print *, 'The frequency value is:',frequency
    print *, 'The initial value is:',initial
    print *, 'The bool variable value is:',isOkay
    





end program variables