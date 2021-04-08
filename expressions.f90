!Operator  	Description
!**	Exponent
!*	Multiplication
!/	Division
!+	Addition
!-	Subtraction
program expressionsSample
    implicit none
    real :: pi, radius, height, area, volume
    pi = 3.14
    print *, 'Enter the cilinder base radius:'
    read(*,*) radius
    print *, 'Enter the cylinder height'
    read(*,*) height

    area = pi * radius ** 2.
    volume = area * height
    print *, 'Cylinder base:',radius
    print *, 'Cylinder area:', area
    print *, 'Cylinder volume:',volume
    print *, 'Cylinder height:',height

end program expressionsSample
