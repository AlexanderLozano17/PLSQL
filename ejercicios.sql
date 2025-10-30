/**
|| ------------------------------------------------
||             PRACTICA DE PAQUETES
|| ------------------------------------------------
|| 1. Crear un paquete denominado REGIONES que tenga los
|| siguientes componentes:
||  • PROCEDIMIENTOS:
||  • ALTA_REGION, con parámetro de código y nombre Región.
||    Debe devolver un error si la región ya existe. Inserta una nueva
||    región en la tabla. Debe llamar a la función EXISTE_REGION
||    para controlarlo.
||
|| •  BAJA_REGION, con parámetro de código de región y que
||    debe borrar una región. Debe generar un error si la región no
||    existe, Debe llamar a la función EXISTE_REGION para
||    controlarlo
||
||  • MOD_REGION: se le pasa un código y el nuevo nombre de la
||    región Debe modificar el nombre de una región ya existente.
||    Debe generar un error si la región no existe, Debe llamar a la
||    función EXISTE_REGION para controlarlo
||  • FUNCIONES
||  • CON_REGION. Se le pasa un código de región y devuelve el
||    nombre
||  • EXISTE_REGION. Devuelve verdadero si la región existe. Se
||    usa en los procedimientos y por tanto es PRIVADA, no debe
||    aparecer en la especificación del paquete
||
|| 2. Crear un paquete denominado NOMINA que tenga sobrecargado
||     la función CALCULAR_NOMINA de la siguiente forma:
||  • CALCULAR_NOMINA(NUMBER): se calcula el salario del
||    empleado restando un 15% de IRPF.
||
||  • CALCULAR_NOMINA(NUMBER,NUMBER): el segundo
||    parámetro es el porcentaje a aplicar. Se calcula el salario del
||    empleado restando ese porcentaje al salario
||
||  • CALCULAR_NOMINA(NUMBER,NUMBER,CHAR): el segundo
||    parámetro es el porcentaje a aplicar, el tercero vale ‘V’ . Se
||    calcula el salario del empleado aumentando la comisión que le
||    pertenece y restando ese porcentaje al salario siempre y
||    cuando el empleado tenga comisión.
*/