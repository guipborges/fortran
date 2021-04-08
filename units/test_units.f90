! test_units.f90 --
!     Test the simple preprocessing programs for dealing with physical and
!     other units at compile time
!
!     Inspired by a proposal by Van Snyder, 31 january 2004
!
program test_units
    use physical_units
    implicit none

    real, unit(m)  :: length, width
    real, unit(m2) :: area
    real, unit(J)  :: work
    real, unit(N)  :: force

    area = length * width
    work = force * length

    !
    ! These two should fail:
    work = force + length
    work = force * force
end program
