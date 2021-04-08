! units_module.f90 --
!     Create a module to support compile-time checking of units
!
!     Input:
!     #                     - the rest of the line is comment
!     unit                  - simply define a unit
!     unit op unit => unit  - define a conversion (op = * or /)
!
!     TODO:
!     sqrt()
!     cos() etc
!     unitless
!     ...
!     convert the unit to a suitable Fortran name (/ for instance!)
!     distinguish lower and upper case
!     make the module name configurable
!
program units_module
    implicit none

    character(len=80) :: line
    character(len=20) :: unit, op, unit2, dummy, unit3
    integer           :: status
    integer           :: k

    open( 10, file = 'units_module.inp' )
    open( 20, file = 'physical_units.f90' )
    open( 30, file = 'physical_units_include.f90' )

    write( 20, '(a)' ) 'module physical_units'
    write( 20, '(a)' ) '    implicit none'

    do
        read( 10, '(a)', iostat = status ) line
        if ( status /= 0 ) then
            exit
        endif
        write(*,*) trim(line)

        k = index( line, '#' )
        if ( k > 0 ) then
            line(k:) = ' '
        endif
        if ( line == ' ' ) then
            cycle
        endif

        !
        ! Do we have a line with one or with four strings?
        !
        read( line, *, iostat = status ) unit, op, unit2, dummy, unit3

        if ( status /= 0 ) then
            read( line, * ) unit
            call define_unit( unit )
        else
            call define_conversion( unit, op, unit2, unit3 )
        endif
    enddo

    write( 20, '(a)' ) 'contains'
    write( 20, '(a)' ) '    include ''physical_units_include.f90'''
    write( 20, '(a)' ) 'end module physical_units'
contains

subroutine define_unit( unit )
    character(len=*) :: unit

    character(len=1), dimension(2) :: operations = ['+',   '-'  ]
    character(len=3), dimension(2) :: op_names   = ['add', 'sub']
    integer                        :: i

    !
    ! Define the interfaces and the dummy routines for a derived type representing the unit
    !
    write( 20, '(a)' ) &
        '    type :: unit_'// trim(unit),   &
        '        real :: value',       &
        '    end type unit_' // trim(unit)
    write( 20, '(a)' ) &
        '    interface operator(-)',   &
        '        module procedure neg_' // trim(unit), &
        '    end interface'
    write( 30, '(a)' ) &
        '    function ' // 'neg_' // trim(unit) // '(a) result(c)', &
        '        type(unit_' // trim(unit) // '), intent(in) :: a', &
        '        type(unit_' // trim(unit) // ')             :: c', &
        '        c = a', &
        '    end function'

    do i = 1,size(operations)
        write(*,*) 'define: ',i, operations(i)
        write( 20, '(a)' ) &
            '    interface operator(' // trim(operations(i)) // ')',                                    &
            '        module procedure ' // trim(op_names(i)) // '_' // trim(unit) // '_' // trim(unit), &
            '    end interface'
        write( 30, '(a)' ) &
            '    function ' // trim(op_names(i)) // '_' // trim(unit) // '_' // trim(unit) // '(a, b) result(c)', &
            '        type(unit_' // trim(unit) // '), intent(in) :: a, b', &
            '        type(unit_' // trim(unit) // ')             :: c', &
            '        c = a', &
            '    end function'
    enddo
end subroutine define_unit

subroutine define_conversion( unit, op, unit2, unit3 )
    character(len=*) :: unit, op, unit2, unit3

    character(len=10) :: op_name

    if ( op == '*' ) then
        op_name = 'mul'
    else
        op_name = 'div'
    endif

    if ( unit /= unit2 ) then
        write( 20, '(a)' ) &
            '    interface operator(' // trim(op) // ')',                                       &
            '        module procedure ' // trim(op_name) // '_' // trim(unit)  // '_' // trim(unit2), &
            '        module procedure ' // trim(op_name) // '_' // trim(unit2) // '_' // trim(unit),  &
            '    end interface'
        write( 30, '(a)' ) &
            '    function ' // trim(op_name) // '_' // trim(unit2) // '_' // trim(unit) // '(a, b) result(c)', &
            '        type(unit_' // trim(unit2) // '), intent(in) :: a', &
            '        type(unit_' // trim(unit)  // '), intent(in) :: b', &
            '        type(unit_' // trim(unit3) // ')             :: c', &
            '        c%value = 0.0', &
            '    end function'
    else
        write( 20, '(a)' ) &
            '    interface operator(' // trim(op) // ')',                                       &
            '        module procedure ' // trim(op_name) // '_' // trim(unit2) // '_' // trim(unit),  &
            '    end interface'
    endif

    write( 30, '(a)' ) &
        '    function ' // trim(op_name) // '_' // trim(unit) // '_' // trim(unit2) // '(a, b) result(c)', &
        '        type(unit_' // trim(unit) // '), intent(in)  :: a', &
        '        type(unit_' // trim(unit2) // '), intent(in) :: b', &
        '        type(unit_' // trim(unit3) // ')             :: c', &
        '        c%value = 0.0', &
        '    end function'
end subroutine define_conversion
end program units_module
