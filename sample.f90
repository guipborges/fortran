program sample
    implicit none !não se deseja que nenhuma variável seja declarada implicitamente
    print *, 'Olá Mundo'
    !call converte_unidades
end program sample
!-------------------------
!Notice that we must declare the data type of the function both in the main program, and in the function itself as if it were a variable.
                                                                                               
function gas_ideal(temp,press,n_mols)      !retornam valores
    implicit none
    real temp,press,n_mols,gas_ideal            !: devem ter no máximo seis letras, não é permitido o uso de caracteres especiais e não podem começar com um número.
    gas_ideal = n_mols * 8.314 * temp / press
    return
    end

subroutine converte_unidades             !não retornam valores
    implicit none
    real temp,press,n_mols, T, P, volume, gas_ideal
    T = temp + 273.15
    P = press * 101325
    n_mols = 3

    volume = gas_ideal(T,P,n_mols) ! chama a função com os valores corrigidos de T e P
   end


