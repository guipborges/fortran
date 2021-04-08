!The desired floating-point precision can be explicitly declared using a kind parameter. 
!The iso_fortran_env intrinsic module provides kind parameters for the common 32bit and 64bit floating point types.

program floatingPoint
    use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64 
    implicit none
    real(sp) :: float32 !single precision
    real(dp) :: float64 !douple precision
    float32 = 1.0_sp
    float64 = 1.0_dp
    !Important: Always use a kind suffix for floating point literal constants.

end program floatingPoint

subroutine  float2
    use, intrinsic :: iso_c_binding, only: sp=>c_float, dp=>c_double
    implicit none
  
    real(sp) :: float32
    real(dp) :: float64

end subroutine float2