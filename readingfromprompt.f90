program readingfromprompt
    implicit none
    integer :: age
    print *, 'Tell me your something'
    read(*,*) age

    print *, 'Your age is:',age

end program readingfromprompt