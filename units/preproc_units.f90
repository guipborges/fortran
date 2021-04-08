! preproc_units.f90 --
!     Preprocess the source code - convert unit specification to derived type
!     With this code transformation the compiler can check the correct use of
!     variables with units.
!
program preproc_units
    implicit none

    character(len=20)  :: option
    character(len=80)  :: source_name
    character(len=200) :: source_line

    integer            :: status
    integer            :: k, k1, k2

    call get_command_argument( 1, option, status = status )
    call get_command_argument( 2, source_name, status = status )

    if ( status /= 0 ) then
        write(*,*) 'Usage: program option source'
        write(*,*) 'option: -checkunits or -removeunits'
        stop
    endif
    if ( option /= '-checkunits' .and. option /= '-removeunits' ) then
        write(*,*) 'Option should be: -checkunits or -removeunits'
        write(*,*) 'It is: ', option
        stop
    endif

    open( 10, file = source_name, status = 'old' )

    k1 = index( source_name, '\', .true. )
    k2 = index( source_name, '/', .true. )
    k  = max( k1, k2 )
    if ( k > 0 ) then
        source_name = source_name(1:k-1) // '_' // source_name(k+1:)
    else
        source_name = '_' // source_name
    endif

    open( 20, file = source_name )

    do
        read( 10, '(a)', iostat = status ) source_line
        if ( status /= 0 ) then
            exit
        endif

        k1 = index( source_line, 'unit(' )
        k2 = index( source_line, 'UNIT(' )
        k  = max( k1, k2 )
        if ( k > 0 ) then
            call replace_unit( source_line )
        endif
        write( 20, '(a)' ) trim(source_line)
    enddo
contains

! replace_unit --
!     Replace the REAL type and the UNIT keyword by a derived type
!
! Arguments:
!     line           Line of code
!
! Note:
!     Several limitations:
!     - One UNIT(..) per line
!     - Assuming the basic data type is REAL - no support for KIND
!     - COMPLEX, DOUBLE PRECISION etc. ignored
!     - Simple treatment of case
!     - No transformation of / and lowercase yet
!
!
subroutine replace_unit( line )
    character(len=*)  :: line

    character(len=32) :: unit_type
    integer           :: k, k1, k2, k3

    k1 = index( line, 'real,' )
    k2 = index( line, 'REAL,' )
    k  = max( k1, k2 )

    line(k:k+4) = ' '
    k3 = k + 5

    k1 = index( line, 'unit(' )
    k2 = index( line, 'UNIT(' )
    k  = max( k1, k2 )

    k1 = k - 1 + index( line(k:), ')' )
    unit_type = 'type(unit_' // line(k+5:k1-1) // ')'

    line(k:) = line(k1+1:)
    line = trim(unit_type) // adjustl(line)

end subroutine replace_unit
end program









