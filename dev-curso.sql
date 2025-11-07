SET SERVEROUTPUT ON; -- GENERA LA SALIDA DE DATOS POR CONSOLA

/** ----------------------------------------
||          BLOQUES ANONIMOS
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| Es la unidad de código más fundamental y básica. Se llama "anónimo" 
|| porque no tiene un nombre asociado y no se almacena de forma permanente 
|| en la base de datos como un procedimiento o una función.
||
|| Su principal propósito es ejecutar una serie de sentencias SQL y lógica 
|| de programación PL/SQL de manera secuencial e inmediata.
*/ -----------------------------------------

BEGIN
    DBMS_OUTPUT.PUT_LINE('✔️  JOSE ALEXANDER LOZANO VELASCO');

END;
/

/** ----------------------------------------
||          VARIABLES
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| Son contenedores de memoria que se usan para almacenar datos temporales. 
|| Permiten manipular valores, almacenar resultados de cálculos o consultas, 
|| controlar el flujo de un programa y hacer que el código sea más flexible y reutilizable.
*/ -----------------------------------------

DECLARE
    -- Declaración de una variable simple
    v_contador NUMBER(2) := 0;
    
    -- Usando default
    v_nombre VARCHAR2(50) DEFAULT 'Desconocido';
    
    -- Usando %TYPE para heredar el tipo de una columna
    v_id_empleado employees.job_id%TYPE;

BEGIN
    -- Se pueden reasignar valores aquí
    v_contador := v_contador +1;
    
    DBMS_OUTPUT.PUT_LINE(v_contador);
    DBMS_OUTPUT.PUT_LINE(v_nombre);
    DBMS_OUTPUT.PUT_LINE(v_id_empleado);

END;
/

/** ----------------------------------------
||          CONSTANTES
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| Son identificadores que almacenan un valor que no puede cambiar durante 
|| la ejecución del programa. Una vez que se les asigna un valor en la sección DECLARE, este permanece fijo.
*/ -----------------------------------------

DECLARE
    -- Tasa de impuesto fija, no puede cambiar
    c_tasa_iva  CONSTANT    NUMBER(3, 2) := 0.19;
    
    -- Número de días de una semana
    c_dias_semana CONSTANT  INTEGER := 7;
    
    -- Nombre de la aplicación
    c_app_nombre CONSTANT   VARCHAR2(50) := 'Sistema Nómina V2.1';
        
BEGIN
    -- Se puede usar la constante en cálculos o sentencias:
    -- Calcular el impuesto para 1000
    DBMS_OUTPUT.PUT_LINE('✔️  Impuesto a pagar: ' || (1000 * c_tasa_iva));
    
END;
/

/** ----------------------------------------
||          VARIABLES BOOLEANAS
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| En PL/SQL son variables que solo pueden almacenar tres posibles valores lógicos: TRUE, FALSE, o NULL.
||
|| Son fundamentales para la programación condicional, ya que se utilizan para 
|| evaluar condiciones y controlar el flujo de ejecución de un programa (por ejemplo, 
|| dentro de sentencias IF-THEN-ELSE o bucles WHILE).
*/ -----------------------------------------

DECLARE
    v_es_mayor_edad     BOOLEAN := FALSE; -- Inicializada a FALSE
    v_registro_existe   BOOLEAN DEFAULT NULL; -- Inicializada a NULL (por defecto)
    v_es_fin_semana     BOOLEAN := TRUE; -- DInicializada a TRUE
    v_edad NUMBER := 25;
    v_esta_autorizado BOOLEAN;

BEGIN
    -- Asignación directa del resultado de una expresión relacional
    v_esta_autorizado := (v_edad >= 18 ) AND (v_edad < 65);
    
    -- Muestra el resultado (requiere que DBMS_OUTPUT esté activado)
    IF v_esta_autorizado THEN
        DBMS_OUTPUT.PUT_LINE('✔️  Aurotizado: TRUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Autorizado: FALSE o NULL');
    END IF;

END;
/

/** ----------------------------------------
||          ATRIBUTO %TYPE
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| El atributo %TYPE en PL/SQL es un calificador que se utiliza para declarar una 
|| variable o constante con el mismo tipo de dato y tamaño (precisión, escala, longitud) 
|| de una columna de una tabla o de otra variable ya declarada.
*/ -----------------------------------------

DECLARE 
    -- Variable de la base declarada como un tipo explicito
    v_base_monto NUMBER(10, 2) := 1000.00;
    
    -- Nueva variable que hereda el tipo de v_base_monto
    v_impuesto v_base_monto%TYPE;

BEGIN
    v_impuesto := v_base_monto * 0.19;
    DBMS_OUTPUT.PUT_LINE(v_impuesto);

END;
/

/** ----------------------------------------
||          OPERADORES
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| Son símbolos o palabras clave que se utilizan en expresiones para realizar operaciones, 
|| como cálculos matemáticos, comparaciones lógicas o manipulación de cadenas de texto. 
|| Son la base para construir la lógica y el flujo de control dentro de un bloque de código.
||
|| OPERADORES ARITMETICOS (MATEMATICOS)
|| Operador	Nombre	        Función	                                Ejemplo	Resultado
||   +	    Suma	        Añade valores.	                        10 + 5	    15
||   -	    Resta	        Sustrae un valor de otro.	            10 - 5	    5
||   *	    Multiplicación	Multiplica valores.	                    10 * 5	    50
||   /	    División	    Divide un valor entre otro.	            10 / 4	    2.5
||  **	    Exponenciación	Eleva un número a la potencia de otro.	2 ** 3	    8
||
|| OPERADORES RELACIONALES (COMPARACIÓN)
|| Operador	        Nombre	            Función	                                                        Ejemplo
||     =              Igual a	        Comprueba si dos valores son iguales.	                        v_saldo = 0
||  != o <> o ^=	Distinto de	        Comprueba si dos valores no son iguales.	                    v_nombre <> 'Admin'
||     <	        Menor que	        Comprueba si el valor izquierdo es menor que el derecho.	    v_edad < 18
||     >	        Mayor que	        Comprueba si el valor izquierdo es mayor que el derecho.	    v_salario > 5000
||     <=	        Menor o igual que	Comprueba si es menor o igual.	                                v_cantidad <= 100
||     >=	        Mayor o igual que	Comprueba si es mayor o igual.	                                v_stock >= 50
||   IS NULL	    Es nulo	            Comprueba si un valor es nulo (no se puede usar = para NULL).	v_fecha_fin IS NULL
||   BETWEEN	    Entre	            Comprueba si un valor está dentro de un rango inclusivo.	    v_nota BETWEEN 10 AND 20
||   LIKE	        Patrón	            Comprueba si un valor coincide con un patrón de cadena.	        v_apellido LIKE 'Perez%'
*/ -----------------------------------------
DECLARE
    -- 1.CONSTANTE: Tasa de bono, no cambia
    c_tasa_bono CONSTANT NUMBER(3, 2) := 0.10;
    
    -- 2. VARIABLES: Almacena datos que si cambian
    v_salario_base      NUMBER(8, 2) := 50000.00;
    v_monto_bono        NUMBER(8, 2);
    v_nombre_completo   VARCHAR2(100) DEFAULT 'José Alexander';

BEGIN
    -- 3. CÁLCULO: Usa la variable y la constante
    v_monto_bono := v_salario_base * c_tasa_bono;
    
    -- 4. SALIDA
     DBMS_OUTPUT.PUT_LINE('---- Cálculo de Bono ----');
     DBMS_OUTPUT.PUT_LINE('✔️  Empleado: ' || v_nombre_completo);
     DBMS_OUTPUT.PUT_LINE('✔️  Salario Base: $' || v_salario_base);
     DBMS_OUTPUT.PUT_LINE('✔️  Monto del Bono: (' || (c_tasa_bono * 100) || '%): $' || v_monto_bono);
END;
/

/** ----------------------------------------
||          BLOQUES ANIDADOS
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| Son bloques de código definidos dentro de la sección ejecutable (BEGIN...END;) 
|| o declarativa (DECLARE) de otro bloque. Esta técnica se llama anidación (nesting) 
|| y es una herramienta poderosa para modularizar el código, encapsular la lógica y controlar el ámbito de las variables.
*/ -----------------------------------------

<<BLOQUE_EXTERNO>> -- Etiqueta el bloque para referencia o salida (Opcional)
DECLARE    
    -- Variable accesible en AMBOS amboes bloques
    v_total_ventas NUMBER := 1000;
    
BEGIN 
    DBMS_OUTPUT.PUT_LINE('1. Inicio de Bloque Externo. Ventas: ' || v_total_ventas);
    
    <<BLOQUE_INTERNO>>
    DECLARE    
        -- Variable local, SOLO accesible dentro del Bloque Interno
        v_ajuste_impuesto CONSTANT NUMBER := 50;
    
    BEGIN 
        -- El bloque interno puede acceder a las variables del bloque externo
        v_total_ventas := v_total_ventas + v_ajuste_impuesto;
        
        DBMS_OUTPUT.PUT_LINE('2. Dentro del Bloque Interno. Ajuste Aplicado: ' || v_total_ventas);
    
    EXCEPTION
        WHEN OTHERS THEN 
            -- Manjea errores que solo ocurran en el bloque interno
            NULL;
    END BLOQUE_INTERNO; -- Se puede referenciar la etiqueta al final
    
    DBMS_OUTPUT.PUT_LINE('3. Fin del Bloque Externo. Nuevas Ventas: ' || v_total_ventas);
    
END BLOQUE_EXTERNO;
/

/** ----------------------------------------
||          VARIABLES LOCALES Y GLOBALES
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| Las variables globales y locales se distinguen por su ámbito (scope), es decir,
|| la región del código donde pueden ser accedidas y utilizadas. 
*/ -----------------------------------------

<<BLOQUE_EXTERNO>>
DECLARE
    -- v_salario es LOCAL al bloque Anonimo
    v_salario NUMBER(8, 2) := 60000;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Salario local: ' || v_salario);
    
    --Este bloque anidado puede acceder a v_salario (ámbito padre)
    <<BLOQUE_INTERNO>>
    DECLARE
        -- v_impuesto_anual es LOCAL al Bloque Anidado
        v_impuesto_anual NUMBER := v_salario * 0.15;
        
    BEGIN    
        DBMS_OUTPUT.PUT_LINE('✔️  ' || 'Impuesto local: ' || v_impuesto_anual);
    
    END BLOQUE_INTERNO; -- v_impuestov_impuesto_anual deja de existir aquí

END BLOQUE_EXTERNO; -- v_salario deja de existir aquí
/

/** ----------------------------------------
||   USO DE FUNCIONES SQL DENTRO DE PLSQL
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| El uso de Funciones SQL (como AVG, MAX, COUNT, TO_CHAR, etc.) dentro de un bloque 
|| PL/SQL es muy común y esencial para manipular y consultar datos directamente desde el motor SQL de Oracle. 
||
|| Las funciones SQL pueden utilizarse en PL/SQL de dos maneras principales:
||
|| 1. En Sentencias SQL (SELECT INTO, INSERT, UPDATE)
|| El uso más habitual es incluir funciones SQL dentro de comandos DML (Data Manipulation Language)
|| o en la cláusula SELECT para recuperar datos.
||
|| - Para Obtener un Resultado Agregado o Transformado
||   Se utiliza la sentencia SELECT...INTO para ejecutar una consulta SQL que usa funciones y almacenar 
||   el resultado en variables PL/SQL.
||
||  Función SQL Usada	                    Propósito en PL/SQL
||  Agregación (SUM, AVG, MAX, MIN,         Calcular estadísticas y guardar el resultado 
||  COUNT)	                                directamente.
||
||  Transformación (TO_CHAR, TO_DATE,       Formatear o modificar datos recuperados antes 
||  ROUND, TRUNC)	                        de guardarlos en una variable.
||
||  
||  ** Importante: Regla de las Funciones de Agregación **
||  Las funciones de agregación (COUNT, SUM, AVG, MAX, MIN) nunca se pueden usar directamente en la 
||  lógica PL/SQL. Siempre deben formar parte de una sentencia SQL con SELECT...INTO.
*/ -----------------------------------------

DECLARE
    v_total_empleados   NUMBER;
    v_salario_maximo    employees.salary%TYPE;
    v_fecha_formato     VARCHAR(20);

BEGIN
    -- 1. Usando COUNT yMAX (Funciones de Agregación)
    SELECT 
        COUNT(*),
        MAX(salary)
    INTO 
        v_total_empleados,
        v_salario_maximo
    FROM employees
    WHERE department_id = 10;
    
    -- 2. Usando TO_CHAR (Función de Transformación)
    SELECT 
        TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS')
    INTO
        v_fecha_formato
    FROM DUAL; -- DUAL es una tabla dummy para sentencias que no necesitan datos
    
    DBMS_OUTPUT.PUT_LINE('✔️  Total Empleados: ' || v_total_empleados);
    DBMS_OUTPUT.PUT_LINE('✔️  Salario Máximo: ' || v_salario_maximo);
    DBMS_OUTPUT.PUT_LINE('✔️  Fecha Actual: ' || v_fecha_formato);

END;
/

/** ----------------------------------------
||   USO DE FUNCIONES SQL DENTRO DE PLSQL
|| -----------------------------------------
|| 2. En Lógica PL/SQL (Asignación o Condicionales)
|| Las funciones SQL escalares (aquellas que devuelven un único valor por fila) 
|| pueden ser utilizadas directamente en la sección ejecutable de PL/SQL, sin necesidad de usar SELECT...INTO.
||
|| - Para Asignar Valores o Evaluar Condiciones
||   Esto aplica a la mayoría de las funciones de cadena, numéricas, de fecha y las de conversión.
||
||   Función SQL	                    Uso Directo en PL/SQL
||   Fecha (SYSDATE, ADD_MONTHS)	    v_fecha_futura := ADD_MONTHS(SYSDATE, 3);
||   Numérica (ABS, ROUND, POWER)	    v_redondeado := ROUND(v_monto, 2);
||   Cadena (SUBSTR, LENGTH, UPPER)	    v_nombre_mayus := UPPER(v_nombre);
*/

DECLARE
    v_nombre            VARCHAR(50) := 'Alicia';
    v_fecha_revision    VARCHAR(20);
    v_proxima_revision  DATE;
    
BEGIN
    -- 1. Uso de funciones de cadena (INITCAP)
    v_nombre := INITCAP(v_nombre);
    
    v_fecha_revision := TO_CHAR(SYSDATE, 'DD/MM/YYYY');
    
    -- 2. Uso de funciones de fecha (ADD_MONTH y SYSDATE)
    v_proxima_revision := ADD_MONTHS(SYSDATE, 6);
    --3. Uso de una condición
    IF LENGTH(v_nombre) < 10 THEN
        DBMS_OUTPUT.PUT_LINE('✔️  Nombre corto: ' || v_nombre);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('✔️  Fecha revision: ' || v_fecha_revision);
    DBMS_OUTPUT.PUT_LINE('✔️  Fecha próxima revision en: ' || v_proxima_revision);
    
END;
/

/** ----------------------------------------
||              COMANDO IF
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| IF en PL/SQL es la estructura de control de flujo más fundamental, utilizada 
|| para ejecutar un bloque de sentencias (o código) solo si se cumple una condición 
|| específica. Permite que el código tome decisiones basadas en valores booleanos (TRUE, FALSE o NULL).
||
|| El comando IF tiene tres formas principales, aumentando en complejidad según la necesidad de la lógica:
|| 1. IF-THEN (Estructura Simple)
|| 2. IF-THEN-ELSE (Dos Caminos)
|| 3. IF-THEN-ELSIF-ELSE (Múltiples Caminos)
*/

DECLARE 
    edad            NUMBER := 18;
    v_puntuacion    NUMBER := 100;
    v_nota_promedio NUMBER := 61;
    v_categoria     VARCHAR2(20);

BEGIN
    -- IF-THEN
    IF edad >= 18 THEN
        DBMS_OUTPUT.PUT_LINE('Es mayor de edad');
    END IF;
    
    -- IF-THEN-ELSE
    IF v_puntuacion >= 100 THEN 
        DBMS_OUTPUT.PUT_LINE('La puntuación es mayor o igual a 100');
    ELSE
        DBMS_OUTPUT.PUT_LINE('La puntuación no es mayor a 100');
    END IF;
    

    -- IF-THEN-ELSIF-ELSE
    IF v_nota_promedio >= 90 THEN
        v_categoria := 'Avanzado';
    
    ELSIF v_nota_promedio >= 80 THEN
        v_categoria := 'Competente';
        
    ELSIF v_nota_promedio >= '60' THEN
        v_categoria := 'Basico';
        
    ELSE
        v_categoria := 'Reprobado';
    
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('El estudiante con promedio ' || v_nota_promedio || 
                        ' esta en la categoria: ' || v_categoria);
END;
/

/** ----------------------------------------
||              CASE
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| Es una estructura de control que te permite ejecutar diferentes bloques de código 
|| basados en el valor de una expresión o en el cumplimiento de múltiples condiciones booleanas. 
|| Es una alternativa más legible y a menudo más eficiente que usar múltiples declaraciones IF-ELSIF-ELSE. 
||
|| En PL/SQL, existen dos formas principales de usar la estructura CASE:
|| 1. Expresión CASE (CASE Expression): Se utiliza para devolver un solo valor basado 
||    en la evaluación de una expresión. Se usa dentro de sentencias como SELECT, INSERT, 
||    o al asignar un valor a una variable.
||
|| 2. Sentencia CASE (CASE Statement): Se utiliza para controlar el flujo de la lógica 
||    (ejecutar diferentes acciones o bloques de código) basándose en la evaluación de condiciones.
      Reemplaza las construcciones IF-ELSIF-ELSE.
*/

DECLARE 
    v_grado     VARCHAR2(10) := 'A';
    v_mensaje   VARCHAR2(50) ;
    v_puntos    NUMBER := 85;
    
BEGIN
    -- Expresión CASE (CASE Expression)
    v_mensaje := CASE v_grado 
                    WHEN 'A' THEN 'Excelente'
                    WHEN 'B' THEN 'Notable'
                    WHEN 'C' THEN 'Aprobado'
                    ELSE 'Suspendido'
                END;
    DBMS_OUTPUT.PUT_LINE('Resultado: ' || v_mensaje);
    
    -- Sentencia CASE (CASE Statement)
    CASE
        WHEN v_puntos >= 90 THEN
            DBMS_OUTPUT.PUT_LINE('✔️  Calificación A');
        
        WHEN v_puntos >= 80 AND v_puntos < 90 THEN
            DBMS_OUTPUT.PUT_LINE('✔️  Calificación B');
            
        ELSE
            DBMS_OUTPUT.PUT_LINE('✔️  Calificación C o inferior');
        
    END CASE;
END;
/

/** ----------------------------------------
||              BUCLE LOOP
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| Es la estructura de bucle más fundamental en PL/SQL, que repite un bloque de 
|| código hasta que se encuentra una condición de salida específica.
||
|| ### Estructura del Bucle LOOP ###
|| El bucle LOOP básico no tiene una condición de iteración o finalización en su 
|| encabezado, lo que significa que es un bucle infinito por naturaleza. Debe utilizarse 
|| junto con la sentencia EXIT (o EXIT WHEN) para detener la ejecución o usa una sentencia 
|| IF completa para evaluar la condición y salir..
*/ -----------------------------------------

DECLARE
    v_contador NUMBER := 1;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando el bucle LOOP:');
    
    LOOP
        -- 1. Sentencia a ejecutar
        DBMS_OUTPUT.PUT_LINE('Número :' || v_contador);
        
        --2. Condición de Salida (se evalúa antes de la siguiente iteración)
        EXIT WHEN v_contador = 5;
        
        -- 3. Actualización de la variable
        v_contador := v_contador + 1;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('✔️  Bucle LOOP terminado.');

END;
/

/** ----------------------------------------
||              BUCLE LOOP ANIDADO
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| Un bucle LOOP anidado (o anidamiento de bucles) ocurre cuando colocas un bucle 
|| completo dentro del cuerpo de otro bucle. Esta técnica se usa para procesar estructuras 
|| de datos multidimensionales o cuando necesitas ejecutar repetidamente una acción para cada iteración de otra acción.
*/ -----------------------------------------

DECLARE

BEGIN 
    <<bucle_exterior>> -- Etiqueta opcional para mayor claridad
    FOR i IN 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE('--- Bucle Exterior (i): ' || i || ' ---');
    
        <<bucle_interior>> -- Etiqueta opcional
        FOR j IN 1..2 LOOP
            -- Esta línea se ejecuta 2 veces por cada 'i'
            DBMS_OUTPUT.PUT_LINE('--- Bucle Interior (j): ' || j);
            
        END LOOP bucle_interior;
        
        DBMS_OUTPUT.PUT_LINE('--- Fin de la iteración ' || i || ' del Bucle Exterior ---');
    
    END LOOP bucle_exterior;

END;
/

/** ----------------------------------------
|| BUCLE LOOP ANIDADO CONTROL Y SALIDA DE ETIQUETAS
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| Cuando se usan bucles anidados, las etiquetas (<<nombre_etiqueta>>) son muy útiles, 
|| especialmente si necesitas usar la sentencia EXIT para salir de un bucle específico 
|| o referenciar un contador de bucle de una capa exterior.
*/

DECLARE 

BEGIN 
    -- SALIDA DE UN BUCLE ESPECÍFICO
    -- Por defecto, la sentencia EXIT sale del bucle más interno. Si quieres salir 
    -- de un bucle más externo desde el interior, debes usar su etiqueta:
    
    <<BUCLE_FILAS>>
    FOR fila IN 1..10 LOOP
        
        <<BUCLE_COLUMNAS>>
        FOR columna IN 1..10 LOOP
            -- Condición de afecta al bucle interior
            IF fila = 3 AND columna = 5 THEN 
                EXIT BUCLE_FILAS; -- ⬅️Sale del bucle exterior (BUCLE_FILAS)                
            END IF;
            
            -- Condición que solo afecta al bucle interior
            IF columna = 8 THEN  
                EXIT BUCLE_COLUMNAS; -- ⬅️Solo sale del bucle interior
            END IF;
        
        END LOOP BUCLE_COLUMNAS;
    
    END LOOP BUCLE_FILAS;

END;
/

/** ----------------------------------------
||          COMANDO CONTINUE
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| a sentencia CONTINUE se usa dentro de un bucle para saltar inmediatamente a la 
|| siguiente iteración del bucle, omitiendo cualquier código restante en el cuerpo del 
|| bucle para la iteración actual.
||
|| Esencialmente, le dice al programa: "Dejo de procesar el código aquí y voy directamente 
|| al principio de la siguiente repetición del bucle."
*/

DECLARE
    -- Este ejemplo usa CONTINUE para saltarse la impresión cuando el contador llega
    -- al número 3, pero sigue contando hasta 5.
    v_contador   NUMBER := 0;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando el bucle:');
    
    LOOP
        v_contador := v_contador + 1;
        
        -- Usamos CONTINUE para saltar la impresiṕn del número 3
        CONTINUE WHEN v_contador = 3;
        
        -- Si el contador NO es 3, se ejecuta esta linea
        DBMS_OUTPUT.PUT_LINE('Procesando Número: ' || v_contador);
        
        -- Condición para salir del bucle
        EXIT WHEN v_contador = 5; 
    
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Bucle terminado.');
    
    
    -- CONTINUE CON ETIQUETA DE ANIDAMEINTO
    DBMS_OUTPUT.PUT_LINE(' ======= CONTINUE CON ETIQUETA DE ANIDAMEINTO. =======');
    <<BUCLE_EXTERIOR>>
    FOR i IN 1..3 LOOP
    
        <<BUCLE_INTERIOR>>
        FOR j IN 1..3 LOOP
        
            IF j = 2 THEN
                CONTINUE BUCLE_EXTERIOR; -- ⬅️ Salta a la siguiente iteración de 'i'
            END IF;
            
            -- Esta línea solo se ejecuta si j es 1 o 3
            DBMS_OUTPUT.PUT_LINE('i=' || i || ', j=' || j);
        END LOOP BUCLE_INTERIOR;
        
    END LOOP BUCLE_EXTERIOR;
END;
/

/** ----------------------------------------
||          BUCLE FOR
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| Es la estructura de bucle más común y conveniente para iterar sobre un rango 
|| de valores enteros o sobre un conjunto de filas devueltas por una consulta (Cursor FOR-LOOP).
||
|| Es una forma simple y concisa de repetir un bloque de código un número predefinido de veces, 
|| ya que maneja automáticamente la inicialización, la condición de parada y el incremento/decremento.
||
|| 1. BUCLE FOR NÚMERICO (Iterando un Rango)
|| 2. BUCLE FOR  CON CURSOR (Procesando Datos) 
*/

DECLARE
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('1. BUCLE FOR NÚMERICO (Iterando un Rango)');
    -- Esta es la forma más básica y se usa para ejecutar un bloque de código un número fijo de veces.
    -- Bucle ascendente (de 1 a 5)
    FOR i IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE('Iteración Ascendente: ' || i);    
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('===================================');
    
    --Bucle descendente (de 5 a 1)
    FOR i IN REVERSE 1..5 LOOP        
        DBMS_OUTPUT.PUT_LINE('Iteración Descendente: ' || i);
    END LOOP;
    

     DBMS_OUTPUT.PUT_LINE(CHR(10) ||'2. BUCLE FOR  CON CURSOR (Procesando Datos) ');
     -- Esta es la forma más utilizada y eficiente para procesar conjuntos de filas (registros) en PL/SQL. 
     -- Permite iterar sobre el resultado de una consulta sin tener que declarar explícitamente un cursor, usar OPEN, FETCH o CLOSE.
    
     -- El bucle itera sobre cada fila devuelta por el SELECT
    FOR emp_rec IN (
        SELECT first_name, last_name, salary
        FROM employees
        WHERE department_id = 100
    ) LOOP
        
        -- Accedes a las columnas de la fila actual usando la variable 'emp_rec'
        IF emp_rec.salary >= 9000 AND emp_rec.salary < 13000 THEN
            DBMS_OUTPUT.PUT_LINE('ALTO SALARIO => Empleado: ' || emp_rec.first_name || ' ' || emp_rec.last_name || ' - Salario: ' || emp_rec.salary);
            
        ELSE
            DBMS_OUTPUT.PUT_LINE('BAJO SALARIO => Empleado: ' || emp_rec.first_name || ' ' || emp_rec.last_name || ' - Salario: ' || emp_rec.salary);
        END IF;        
    END LOOP;

END;
/

/** ----------------------------------------
||          BUCLE WHILE
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| es una estructura de control que ejecuta repetidamente un bloque de sentencias 
|| mientras una condición booleana específica sea verdadera (TRUE).
||
|| Es ideal cuando no sabes de antemano cuántas veces se debe repetir el bucle, 
|| ya que la ejecución depende de una condición que puede cambiar dentro del cuerpo del bucle.
*/

DECLARE 
    v_contador NUMBER := 5;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando el bucle WHILE:');
    
    WHILE v_contador >=1 LOOP
        DBMS_OUTPUT.PUT_LINE('Contando: ' || v_contador);
        
        -- 💡 Paso crucial: Modificar la variable para que el bucle pueda terminar
        v_contador := v_contador - 1;
        
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Bucle WHILE terminado.');
END;
/

/** ----------------------------------------
||          SELECT EN PL/SQL
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| Hacer una sentencia SELECT dentro de PL/SQL es fundamental, pero tiene una regla crucial: 
|| una sentencia SELECT que devuelve datos siempre debe incluir una cláusula INTO para almacenar 
|| esos datos en variables de PL/SQL. No puedes simplemente ejecutar una consulta como lo harías en SQL.
||
|| Hay tres escenarios principales para usar SELECT en PL/SQL:
|| ## 1. SELECT INTO (Una Sola Fila) ##
|| ## 2. Cursor FOR-LOOP (Múltiples Filas) ##
*/

DECLARE
    v_nombre_empleado   VARCHAR2(55);
    v_salario_empleado  employees.salary%TYPE;
    v_contador NUMBER := 0;

BEGIN
    DBMS_OUTPUT.PUT_LINE('1. SELECT INTO (Una Sola Fila)');
    SELECT first_name || ' ' || last_name AS nombre,
           salary
    INTO v_nombre_empleado, 
         v_salario_empleado
    FROM employees
    WHERE employee_id = 100;
    
    DBMS_OUTPUT.PUT_LINE('El salario de ' || v_nombre_empleado || ' es: ' || v_salario_empleado);
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    
    DBMS_OUTPUT.PUT_LINE('2. Cursor FOR-LOOP (Múltiples Filas)');
    
    FOR r_empleados IN (
        SELECT first_name, last_name
        FROM employees
    ) LOOP
        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE(v_contador || '. Empleado: ' || r_empleados.first_name || ' ' || r_empleados.last_name);
        EXIT WHEN v_contador = 10;
        
    END LOOP;
    
    
END;
/

/** ----------------------------------------
||          %ROWTYPE
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| Es un atributo esencial en PL/SQL (el lenguaje procedimental de Oracle) que 
|| se utiliza para declarar una variable de tipo registro (record) con la misma estructura 
|| (mismo número, nombre y tipo de dato) que una fila específica de una tabla, vista o cursor.
||
|| En esencia, te permite manejar una fila entera de datos como una sola variable 
|| compuesta, sin tener que declarar cada columna individualmente.
||
|| Uso y Ventajas de %ROWTYPE
|| ## 1. Basado en Tablas o Vistas ## Puedes declarar una variable para que coincida 
||    con la estructura de una fila de una tabla existente.
|| ## 2. Basado en Cursores (Implícitos y Explícitos) ## El uso más potente y común 
||    de %ROWTYPE es en los bucles FOR de cursor (Cursor FOR-LOOP), donde se utiliza implícitamente
*/

DECLARE
    -- v_emp_info tendrá todas las columnas de la tabla empleados
    v_emp_info employees%ROWTYPE;

BEGIN 
    DBMS_OUTPUT.PUT_LINE('Basado en Tablas o Vistas');
    -- Ahora puedes seleccionar toda la fila INTO esta única variable
    SELECT *
    INTO v_emp_info
    FROM employees
    WHERE employee_id = 100;

    -- Para acceder a una columna, usas la notación de punto (dot notation):
    DBMS_OUTPUT.PUT_LINE('✔️  Nombre: ' || v_emp_info.first_name);
    DBMS_OUTPUT.PUT_LINE('✔️  Salario: ' || v_emp_info.salary);
    DBMS_OUTPUT.PUT_LINE(CHR(10));

    DBMS_OUTPUT.PUT_LINE('Basado en Cursores (Implícitos y Explícitos)');
    FOR r_emp_rec IN (
        SELECT first_name || ' ' || last_name AS full_name, salary
        FROM employees
        WHERE department_id = 90
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('✔️  Nombre: ' || r_emp_rec.full_name || ' Salario: ' || r_emp_rec.salary);
   
    END LOOP;
END;
/

/** ----------------------------------------
||          INSERT PL/SQL
|| -----------------------------------------
|| DESCRIPCIÓN: 
|| Se utiliza en PL/SQL para añadir nuevas filas de datos a una tabla. A diferencia 
|| del SELECT en PL/SQL, el INSERT es una sentencia DML (Lenguaje de Manipulación de Datos) 
|| y no necesita una cláusula INTO, ya que no está intentando devolver datos a una variable de PL/SQL, 
|| sino enviarlos a la base de datos.
||
|| Aquí tienes las dos formas principales de usar INSERT dentro de un bloque PL/SQL:
|| ## 1. Insertar Valores Fijos o Variables de PL/SQL ## Esta forma es la más común y 
||    se utiliza para insertar una única fila, donde los valores provienen de variables 
||    declaradas en tu bloque PL/SQL o son valores literales fijos.
|| ## 2. INSERT INTO ... SELECT FROM ## Esta forma se usa para insertar múltiples filas 
||    en una tabla, donde los datos provienen de una consulta SELECT de otra tabla 
||    o conjunto de datos. El número y tipo de datos de las columnas en el SELECT 
||    deben coincidir con las columnas en el INSERT.
*/

DECLARE
    v_country_id        countries.country_id%TYPE   := 'CO';
    v_country_name      countries.country_name%TYPE := 'Colombia';
    v_region_id         countries.region_id%TYPE    := 2;
    
    v_filas_insertadas  NUMBER;
    
BEGIN 
    DBMS_OUTPUT.PUT_LINE('1. Insertar Valores Fijos o Variables de PL/SQL');
    -- 🚨 Sentencia INSERT
    INSERT INTO countries (country_id, country_name, region_id)
    VALUES(v_country_id, v_country_name, v_region_id);
    
    -- Confirma la transacción (necesario para hacer permanentes los cambios)
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('✔️ Nuevo País ' || v_country_name || ' insertado con ID: ' || v_country_id);
    DBMS_OUTPUT.PUT_LINE(CHR(10));

    DBMS_OUTPUT.PUT_LINE('2. INSERT INTO ... SELECT FROM');
    INSERT INTO countries (country_id, country_name, region_id)
    SELECT 'EC' AS country_id,
           'Ecuador' AS country_name,
           2 AS region_id
    FROM DUAL;
    
    -- La variable SQL%ROWCOUNT contiene el número de filas afectadas por la última DML
    v_filas_insertadas := SQL%ROWCOUNT; 
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('✔️ ' || v_filas_insertadas || ' filas transferidas al histórico.');

END;
/

/** ----------------------------------------
||          UPDATE PL/SQL
|| -----------------------------------------
|| DESCRIPCIÓN:
|| se utiliza para modificar los datos existentes en una o más filas de una tabla. 
|| Al igual que INSERT y DELETE, es una sentencia DML (Lenguaje de Manipulación de Datos) 
|| y no requiere la cláusula INTO.
||
|| El uso de UPDATE dentro de PL/SQL es idéntico a usarlo en SQL, pero a menudo 
|| incluye variables de PL/SQL para determinar qué filas se actualizan y con qué valores.
||
|| 1. Estructura y Sintaxis Básica
|| 2. Uso de Variables PL/SQL
|| 3. Uso de UPDATE con Subconsultas
*/

DECLARE
    v_country_id    countries.country_id%TYPE   := 'CO';
    v_country_name  countries.country_name%TYPE := 'Colombians';
    v_region_id     countries.region_id%TYPE    := 2;

BEGIN
    UPDATE countries 
    SET country_name = v_country_name
    WHERE country_id = v_country_id 
        AND region_id = v_region_id;
        
    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Dato actualizado');  
        DBMS_OUTPUT.PUT_LINE('Filas Afectadas: ' || SQL%ROWCOUNT); 
        COMMIT;
        
    ELSE
        DBMS_OUTPUT.PUT_LINE('✔️ No se encontró el país con ID ' || v_country_id || '. No se realizó el UPDATE.');
        ROLLBACK;
    
    END IF;
    
END;
/

/** ----------------------------------------
||          DELETE PL/SQL
|| -----------------------------------------
|| DESCRIPCIÓN:
|| La sentencia DELETE en PL/SQL (y en SQL) se usa para eliminar filas de datos 
|| existentes de una tabla. Es una sentencia DML (Lenguaje de Manipulación de Datos) y, 
|| al igual que INSERT y UPDATE, no requiere la cláusula INTO.
||
|| El uso de DELETE en PL/SQL es idéntico a usarlo en SQL, pero a menudo se utiliza 
|| en combinación con la lógica y las variables del código.
*/

DECLARE
    v_country_id    countries.country_id%TYPE   := 'CO';
    v_country_name  countries.country_name%TYPE := 'Colombians';
    v_region_id     countries.region_id%TYPE    := 2;
    
    v_filas_eliminadas NUMBER;

BEGIN
    -- 1. Ejecuta la sentencia DELETE
    DELETE FROM countries
    WHERE country_id = v_country_id
        AND region_id = v_region_id;
        
    -- 2. Captura el número de filas afectadas
    v_filas_eliminadas := SQL%ROWCOUNT;
    
    IF v_filas_eliminadas > 0 THEN 
        DBMS_OUTPUT.PUT_LINE('✔️ '  || v_filas_eliminadas || ' Países eliminados ' || v_country_name);
        COMMIT;
        
    ELSE 
        DBMS_OUTPUT.PUT_LINE('✔️ No se encontraron Países ' || v_country_name || ' para eliminar.');
        ROLLBACK;
    END IF;

END;
/

/** ----------------------------------------
||          EXCEPCIÓNES PL/SQL
|| -----------------------------------------
|| DESCRIPCIÓN:
|| Las Excepciones en PL/SQL son eventos que interrumpen el flujo normal de ejecución 
|| de un programa. Cuando ocurre un error (una excepción), el control se transfiere inmediatamente 
|| a una sección especial del bloque PL/SQL, llamada EXCEPTION, donde puedes manejar el error de forma controlada.
||
|| Manejar excepciones es crucial para crear código robusto y confiable, ya que evita que el programa termine abruptamente.
||
|| Tipos de Excepciones
|| 1. Predefinidas (Standard) => Son errores comunes de Oracle que tienen un nombre ya definido. No necesitas declararlas.
|| Excepción	        Código de Error     Se dispara cuando...
||                      Oracle	
|| NO_DATA_FOUND	    ORA-01403	        Un SELECT INTO no devuelve ninguna fila.
|| TOO_MANY_ROWS	    ORA-01422	        Un SELECT INTO devuelve más de una fila.
|| DUP_VAL_ON_INDEX	    ORA-00001	        Intentas insertar o actualizar un valor que viola una restricción de clave única o primaria.
|| ZERO_DIVIDE	        ORA-01476	        Intentas dividir por cero.
||
|| ## 2. No Predefinidas (Internas) ## Son errores de Oracle que no tienen un nombre 
||    estándar en PL/SQL. Se deben declarar explícitamente en la sección DECLARE y asociarles un número de error (ORA-nnnnn).
||
|| ## 3. Definidas por el Usuario (Custom) ##  Son excepciones creadas y nombradas por
||    el programador para imponer reglas de negocio específicas
*/

DECLARE
    -- 2. No Predefinidas (Internas)
    e_fk_violada EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_fk_violada, -2291); -- ORA-02291 (Restricción de FK violada)
    
    -- 3. Definidas por el Usuario (Custom)
    e_salario_invalido EXCEPTION;
    v_salario NUMBER := 20000;

BEGIN
    -- =======================================================
    -- PRUEBA 1: EXCEPCIÓN NO PREDEFINIDA (FOREIGN KEY)
    -- Se usa un sub-bloque para capturar este error y continuar
    -- =======================================================
    DBMS_OUTPUT.PUT_LINE('--- 2. No Predefinidas (Internas) ---');
    
    BEGIN
        -- Intentar un INSERT que viola una FK (asume que la region_id 5 no existe)
        INSERT INTO countries (country_id, country_name, region_id)
        SELECT 'RS' AS country_id,
               'RUSIA' AS country_name,
               5 AS region_id -- Asume que este ID de región viola la FK
        FROM DUAL;

        -- Si el INSERT tiene éxito (lo que no esperamos), hacemos ROLLBACK
        DBMS_OUTPUT.PUT_LINE('¡Advertencia! El INSERT tuvo éxito. Haciendo ROLLBACK.');
        ROLLBACK; 

    EXCEPTION 
        WHEN e_fk_violada THEN
            DBMS_OUTPUT.PUT_LINE('✔️ Capturado: Error: No existe la región referenciada.');
            ROLLBACK; -- Revierte el intento de INSERT
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error inesperado en Prueba 1: ' || SQLERRM);
            ROLLBACK;
    END; -- Fin del sub-bloque 1
    
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    
    -- =======================================================
    -- PRUEBA 2: EXCEPCIÓN DEFINIDA POR EL USUARIO (CUSTOM)
    -- =======================================================
    DBMS_OUTPUT.PUT_LINE('--- 3. Definidas por el Usuario (Custom) ---');

    BEGIN
        IF v_salario >= 18000 THEN
            -- Disparar (Raise) la excepción si la regla de negocio se viola
            RAISE e_salario_invalido;
        END IF;
        
        -- Si el salario es menor de 18000, esta línea se ejecuta
        DBMS_OUTPUT.PUT_LINE('Salario APROBADO: ' || v_salario);

    EXCEPTION 
        WHEN e_salario_invalido THEN
            -- Capturar la excepción de negocio
            DBMS_OUTPUT.PUT_LINE('✔️ Capturado: Error de Negocio: El salario (' || v_salario || ') excede el máximo de 18000 permitido. No se procede.');
        
        WHEN OTHERS THEN 
            -- Captura cualquier otro error en esta sección
            DBMS_OUTPUT.PUT_LINE('Ocurrió otro error inesperado en Prueba 2: ' || SQLERRM);
    END; -- Fin del sub-bloque 2
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Ejecución del bloque principal terminada.');
    
    -- =======================================================
    -- PRUEBA 3: INSERCIÓN CONDICIONAL CON MANEJO DE ERROR
    -- =======================================================
    /*
     * Este bloque de código realiza una operación de inserción condicional (INSERT IF NOT EXISTS)
     * en la tabla REGIONS. Utiliza un contador (COUNT(*)) para verificar la duplicidad antes de
     * intentar la inserción.
     *
     * Si el registro ya existe, lanza un error de aplicación (-20001) para comunicar
     * explícitamente a la aplicación externa que la regla de unicidad del negocio fue violada.
     * Este método es más robusto y claro que usar excepciones implícitas (como NO_DATA_FOUND).
     */
    DECLARE
        -- Declara una variable de tipo registro basada en la estructura de la tabla REGIONS
        reg          REGIONS%ROWTYPE;
        -- Variable contadora para verificar la existencia del registro (0 = No existe, 1 = Existe)
        v_existe     NUMBER(1);
        
    BEGIN
        -- 1. Prepara los datos a insertar
        reg.region_id    := 100;
        reg.region_name  := 'AFRICA';
        
        -- 2. Lógica de Verificación de Existencia
        -- Cuenta cuántos registros coinciden con el ID que se intenta insertar.
        SELECT COUNT(*) INTO v_existe
        FROM REGIONS
        WHERE region_id = reg.region_id;
        
        -- 3. Inserción Condicional y Manejo de Error
        IF v_existe > 0 THEN
            -- El registro existe: Lanza un error de negocio
            DBMS_OUTPUT.PUT_LINE('LA REGIÓN YA EXISTE');
            
            -- RAISE_APPLICATION_ERROR lanza un error ORA-20001 con el mensaje especificado.
            -- Esto es un error de negocio que debe ser capturado por la capa de aplicación.
            RAISE_APPLICATION_ERROR(-20001, 'La región con ID ' || reg.region_id || ' ya existe.');
        ELSE
            -- El registro no existe: Procede con la inserción
            
            -- 4. Insertar si no existe
            INSERT INTO REGIONS VALUES(reg.region_id, reg.region_name);
            
            -- Confirma la transacción para hacer el cambio permanente
            COMMIT;
            
            DBMS_OUTPUT.PUT_LINE('LA REGIÓN SE HA CREADO EXITOSAMENTE');
        END IF;
        
        -- Nota: No se necesita un bloque EXCEPTION aquí, ya que el error de duplicidad
        -- se maneja explícitamente con el IF/RAISE_APPLICATION_ERROR antes de la inserción.
    END;

END;
/

/** ----------------------------------------
||  COLECCIONES Y TIPOS COMPUESTOS PL/SQL
|| -----------------------------------------
|| DESCRIPCIÓN:
|| Las colecciones y los tipos compuestos son esenciales para manejar múltiples elementos 
|| o estructuras de datos complejas dentro de tu código, de forma similar a como se usaría un 
|| array o una clase en Java
||
|| ----------------------------------------
||  Tipos Compuestos (Records)
|| -----------------------------------------
|| Un Record (Registro) es un tipo compuesto que te permite agrupar elementos relacionados de 
|| diferentes tipos de datos bajo un único nombre. Son muy similares a las  clases sencillas 
|| en otros lenguajes o a la estructura de una fila de tabla.
||
|| ## 1.1 Record Basado en Tabla (%ROWTYPE) ## Este es el tipo más común y sencillo. Define la 
|| estructura del Record basándose directamente en las columnas de una tabla o una vista.
|| Uso: Ideal para almacenar una fila completa de una tabla o para declarar variables INTO en un cursor.
*/

DECLARE 
    -- Copia la estructura de la tabla EMPLOYEES
    v_empleado_registro employees%ROWTYPE;

BEGIN
    SELECT * 
    INTO v_empleado_registro
    FROM employees
    WHERE employee_id = 100;
    
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_empleado_registro.first_name);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('ERROR: El empleado con ID 100 no existe.');
    WHEN TOO_MANY_ROWS THEN
        -- Aunque improbable para una PK, es una buena práctica
        DBMS_OUTPUT.PUT_LINE('ERROR: Se encontraron varios empleados. Revise la condición WHERE.');
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('ERROR INESPERADO: ' || SQLERRM);
END;
/

/**
|| ----------------------------------------
||  1.2. Record Definido por el Usuario
|| -----------------------------------------
|| Te permite definir la estructura personalizada de tu Record, eligiendo solo los 
|| campos necesarios o creando campos que no existen en ninguna tabla.
||
|| Uso: Para pasar un conjunto específico de datos como un único argumento entre procedimientos o funciones.
*/

DECLARE

    v_email                     employees.email%TYPE; 
    v_employee_id               employees.employee_id%TYPE; 
    v_employee_id_consecutivo   employees.employee_id%TYPE; 
    
    -- Definición del Tipo Compuesto (el 'molde')
    TYPE t_registro_employee IS RECORD (
        first_name      VARCHAR2(20),
        last_name       VARCHAR2(25),
        email           VARCHAR2(100),
        job_id          VARCHAR2(10),
        salary          NUMBER(8,2),
        manager_id      NUMBER(6,0),
        department_id   NUMBER(4,0)
    );
    
    -- Declaración de la variable usando el nuevo tipo
    v_mi_employee  t_registro_employee;  

BEGIN
    v_mi_employee.first_name        := 'alexander'; 
    v_mi_employee.last_name         := 'lozano';
    v_mi_employee.email             := 'ALEXANDERLOZANO';
    v_mi_employee.job_id            := 'SA_REP';
    v_mi_employee.salary            := 9500;
    v_mi_employee.manager_id        := 145;
    v_mi_employee.department_id     := 80;

    SELECT email
    INTO v_email
    FROM employees
    WHERE email = v_mi_employee.email;
    
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
    
        SELECT NVL(MAX(employee_id), 0)
        INTO v_employee_id
        FROM employees;
        
        v_employee_id_consecutivo := v_employee_id + 1;
    
        INSERT INTO employees(employee_id, first_name, last_name, email, hire_date, job_id, salary, manager_id, department_id)
        VALUES (v_employee_id_consecutivo, 
            v_mi_employee.first_name, 
            v_mi_employee.last_name, 
            v_mi_employee.email, 
            SYSDATE,
            v_mi_employee.job_id,
            v_mi_employee.salary,
            v_mi_employee.manager_id,
            v_mi_employee.department_id);
        
        DBMS_OUTPUT.PUT_LINE('Employee con email ' || v_mi_employee.email || ' se ha creado con exito.');
 
END;
/

/**
|| ----------------------------------------
|| 2. Tipos de Colecciones
|| -----------------------------------------
|| Las colecciones son tipos de datos que almacenan múltiples instancias del mismo 
|| tipo de elemento (como un array). Los tres tipos principales son las tablas anidadas, 
|| las arrays variables (VARRAYs) y las arrays asociativas.
||
|| ----------------------------------------
|| 2.1. Array Asociativo (INDEX BY TABLE)
|| -----------------------------------------.
|| Este es el tipo de colección más flexible y común en PL/SQL. Permite indexar 
|| los elementos usando un NUMBER o un VARCHAR2 como índice (similar a un hash map o un diccionario).
||
|| Uso: Para almacenar y manipular grandes conjuntos de datos in-memory que se obtienen
|| de la base de datos (por ejemplo, para procesamiento por lotes).
*/

DECLARE
    -- Define un tipo de tabla indexada por NUMBER, que almacena VARCHAR2(50)
    TYPE t_nombres_por_id IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER;
    
    -- Declara una variable de ese tipo
    v_empleados t_nombres_por_id;

BEGIN 
    -- Asignación de valores
    v_empleados(101) := 'Ana Lopez';
    v_empleados(250) := 'Carlos Gomez';
    v_empleados(-5)  := 'Maria Elena'; -- Admite índices negativos
    
    -- Acceso
    DBMS_OUTPUT.PUT_LINE('El empleado 101 es: ' || v_empleados(101));

END;
/

/**
|| ----------------------------------------
||  2.2. Tablas Anidadas (Nested Tables)
|| -----------------------------------------
|| Las tablas anidadas son similares a los arrays unidimensionales, pero a diferencia 
|| de los arrays asociativos, pueden ser almacenadas como columnas dentro de tablas de base 
|| de datos (por eso se llaman anidadas).
||
|| Uso: Para modelar relaciones uno-a-muchos directamente dentro de una fila de una tabla principal (similar a un documento JSON incrustado).
||
|| Propiedades: Su índice es siempre un NUMBER secuencial. Requieren inicialización (NEW nombre_tipo()).
*/

DECLARE 

BEGIN
    /**
    || ----------------------------------------
    ||  EJEMPLO # 1
    || -----------------------------------------
    */
    DBMS_OUTPUT.PUT_LINE('=== EJEMPLO # 1 === ');
    DECLARE
        -- 1. Definición del Tipo (a nivel de esquema o en el bloque DECLARE)
        TYPE t_titulos_profesionales IS TABLE OF VARCHAR2(100);
    
        -- 2. Declaración de la variable de colección
        v_historial_titulos t_titulos_profesionales;
    BEGIN 
        -- 3. Inicialización de la Tabla Anidada (Obligatorio)
        v_historial_titulos := t_titulos_profesionales();
        
        -- 4. Extensión e inserción de datos
        v_historial_titulos.EXTEND;
        v_historial_titulos(1) := 'Ingeniero de Sistemas';
        
        v_historial_titulos.EXTEND;
        v_historial_titulos(2) := 'Maestría en Big Data';
        
        v_historial_titulos.EXTEND;
        v_historial_titulos(3) := 'Certificación en Seguridad';
        
        -- 5. Recorrido de la colección
        DBMS_OUTPUT.PUT_LINE('Historial de Títulos:');
        
        FOR i IN v_historial_titulos.FIRST ..v_historial_titulos.LAST LOOP
             DBMS_OUTPUT.PUT_LINE(' - Título ' || i || ': ' || v_historial_titulos(i));
        END LOOP;
        
        -- 6. Manipulación (Eliminar el último elemento)
        v_historial_titulos.TRIM;
        DBMS_OUTPUT.PUT_LINE('El historial ahora tiene ' || v_historial_titulos.COUNT || ' títulos.');
    
    END;
    
    /**
    || ----------------------------------------
    ||  EJEMPLO # 2
    || -----------------------------------------
    */
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== EJEMPLO # 2 === ');
    DECLARE
        -- 1. Definición del Tipo (a nivel de esquema o en el bloque DECLARE)
        TYPE t_departamentos IS TABLE OF departments.department_name%TYPE INDEX BY PLS_INTEGER;
        
        TYPE t_empledos IS TABLE OF employees%ROWTYPE INDEX BY PLS_INTEGER;
        
        v_departamentos t_departamentos;
        v_empledos      t_empledos;
        
    BEGIN
        -- Tipo simple
        DBMS_OUTPUT.PUT_LINE(' TIPO SIMPLE ');
        v_departamentos(1) := 'INFORMATICA';
        v_departamentos(2) := 'RRHH';
        DBMS_OUTPUT.PUT_LINE(v_departamentos.FIRST);
        DBMS_OUTPUT.PUT_LINE(v_departamentos.LAST);
        IF v_departamentos.EXISTS(3) THEN
            DBMS_OUTPUT.PUT_LINE(v_departamentos(3));
        ELSE
            DBMS_OUTPUT.PUT_LINE('Este valor no existe');
        END IF;
        
        -- Tipo Compuesto
        DBMS_OUTPUT.PUT_LINE(CHR(10)  || ' TIPO COMPUESTO ');
         
        SELECT * INTO v_empledos(1) FROM employees WHERE employee_id = 100;        
        DBMS_OUTPUT.PUT_LINE(v_empledos(1).first_name);
        SELECT * INTO v_empledos(2) FROM employees WHERE employee_id = 101;        
        DBMS_OUTPUT.PUT_LINE(v_empledos(2).first_name);
        SELECT * INTO v_empledos(3) FROM employees WHERE employee_id = 102;        
        DBMS_OUTPUT.PUT_LINE(v_empledos(3).first_name);
        SELECT * INTO v_empledos(4) FROM employees WHERE employee_id = 103;        
        DBMS_OUTPUT.PUT_LINE(v_empledos(4).first_name);
        
    END;
    
    /**
    || ----------------------------------------
    ||  EJEMPLO # 3 SELECT MULTIPLES CON ARRAYS ASOCIATIVOS
    || -----------------------------------------
    */
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== EJEMPLO # 3 SELECT MULTIPLES CON ARRAYS ASOCIATIVOS === ');
    DECLARE 
        TYPE t_departamentos IS TABLE OF departments%ROWTYPE INDEX BY PLS_INTEGER;
        
        v_departamentos t_departamentos;
    
    BEGIN 
        FOR i IN 1..10 LOOP
            SELECT * INTO v_departamentos(i) FROM departments WHERE department_id = i * 10;  
        END LOOP;
        
        FOR i IN v_departamentos.FIRST .. v_departamentos.LAST LOOP
            DBMS_OUTPUT.PUT_LINE(v_departamentos(i).department_name);
        END LOOP;
    
    END;
    
END;
/


/**
|| ----------------------------------------
||  2.3. Arrays Variables (VARRAYs)
|| -----------------------------------------
|| Son colecciones de tamaño fijo y predefinido (se debe especificar el tamaño máximo en la definición).
||
|| Uso: Para colecciones pequeñas donde se conoce el número máximo de elementos (ej., los 5 mejores resultados).
||
|| Propiedades: Su índice es siempre un NUMBER secuencial. También requieren inicialización y se pueden almacenar como columnas de tabla.
*/

DECLARE
    -- 1. Definición del Tipo (Se especifica el tamaño máximo: LIMIT 5)
    TYPE t_colores_favoritos IS VARRAY(5) OF VARCHAR2(30);
    
    -- 2. Declaración de la variable de colección
    v_mis_colores t_colores_favoritos;
    
BEGIN
     -- 3. Inicialización del VARRAY
    -- Se inicializa con los elementos que contendrá.
    v_mis_colores := t_colores_favoritos('Azul', 'Verde', 'Rojo');
    
    -- 4. Extensión e inserción de datos (Si no se inicializan con el tamaño final)
    -- En este caso, ya tiene 3 elementos.
    v_mis_colores.EXTEND;
    v_mis_colores(4) := 'Amarillo';
    
    -- Si intentáramos extender a 6, se generaría un error 'ORA-06532: Subscript outside limit'
    
    -- 5. Recorrido de la colección
    FOR i IN v_mis_colores.FIRST .. v_mis_colores.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('- Color ' || i || ': ' || v_mis_colores(i));
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'tamaño máximo del VARRAY: ' || v_mis_colores.LIMIT);
    DBMS_OUTPUT.PUT_LINE('Elementos actuales: ' || v_mis_colores.COUNT);

END;
/

/** ----------------------------------------
||        CURSORES PLSQL
|| -----------------------------------------
|| DESCRIPCIÓN:
|| SQL está diseñado para manejar conjuntos (múltiples filas) de datos, mientras 
|| que PL/SQL trabaja con variables escalares (una fila a la vez). Los cursores son 
|| el puente que permite a PL/SQL iterar sobre un conjunto de resultados fila por fila.
||
|| Existen dos tipos principales:
||
|| ## a) Cursores Implícitos (Implicit Cursors) ##
|| Son gestionados automáticamente por Oracle para cualquier sentencia DML (INSERT, UPDATE, DELETE) 
|| o cualquier SELECT INTO que devuelva una sola fila.
|| 
|| - No necesitas declararlos.
|| - Oracle usa un cursor especial llamado SQL para gestionar estas operaciones.
|| - Atributos Útiles: Puedes verificar el estado de la operación usando los atributos 
||   del cursor SQL, como SQL%ROWCOUNT (número de filas afectadas) o SQL%FOUND (si se encontró al menos una fila).
||
|| ===== Atributos de Cursores Implícitos (SQL Cursor) =====
||
|| Atributo	        Tipo de Valor	Sentencias      Descripción
||                                  que Afecta	
|| 
|| SQL%FOUND	    Booleano        DML y           Devuelve TRUE si la última DML afectó a una o más filas, 
||                 (TRUE/FALSE)	    SELECT          o si el SELECT INTO recuperó exactamente una fila.
||                                  INTO
||                                 	
|| SQL%NOTFOUND	    Booleano        DML y           Devuelve TRUE si la última DML afectó a cero filas, 
||                 (TRUE/FALSE)	    SELECT          o si el SELECT INTO no recuperó ninguna fila (lo que provoca NO_DATA_FOUND).
||                                  INTO 
||                                 	
|| SQL%ROWCOUNT	    Numérico	    DML	            Devuelve el número de filas afectadas por la última sentencia INSERT, UPDATE o DELETE.
||
||
|| ## b) Cursores Explícitos (Explicit Cursors) ##
|| Son declarados, nombrados y gestionados por el desarrollador para procesar sentencias 
|| SELECT que se espera devuelvan múltiples filas.
||
||
||  ## Ciclo de Vida del Cursor Explícito ##
||  El manejo de un cursor explícito sigue cuatro pasos obligatorios:
||  Paso 1: DECLARE (Declaración)
||  Paso 2: OPEN (Apertura)
||  Paso 3: FETCH (Lectura de Datos)
||  Paso 4: CLOSE (Cierre)
||
|| ===== Atributos de Cursores Explícitos y Bucle =====
||
|| Atributo	    Tipo de Valor	        Descripción
|| %ISOPEN	    Booleano (TRUE/FALSE)	Devuelve TRUE si el cursor está abierto (OPEN), y FALSE si está cerrado o nunca se ha abierto.
|| %FOUND	    Booleano (TRUE/FALSE)	Devuelve TRUE si la última sentencia FETCH recuperó una fila exitosamente.
|| %NOTFOUND	Booleano (TRUE/FALSE)	Devuelve TRUE si la última sentencia FETCH no recuperó ninguna fila (es decir, se llegó al final del conjunto de resultados). Es la condición más común para salir de un bucle LOOP.
|| %ROWCOUNT	Numérico	            Devuelve el número total de filas que han sido recuperadas del cursor hasta el momento.
*/

DECLARE
    

BEGIN

    DECLARE
        -- ----------------------------------------
        --    Paso 1: DECLARE (Declaración)
        -- -----------------------------------------
        -- Define el nombre y la consulta SQL que el cursor contendrá.
        CURSOR c_empleados IS
            SELECT first_name, last_name, salary
            FROM employees
            WHERE department_id = 90;
            
        -- Declara un RECORD para guardar la fila actual
        r_empleado c_empleados%ROWTYPE;
        
    BEGIN
        -- ----------------------------------------
        --    Paso 2: OPEN (Apertura)
        -- -----------------------------------------
        -- Ejecuta la sentencia SELECT y carga el conjunto de resultados en el área de memoria del cursor.
        DBMS_OUTPUT.PUT_LINE('OPEN (Apertura) del cursor');
        OPEN c_empleados;
        DBMS_OUTPUT.PUT_LINE(CHR(10));
        
        -- ----------------------------------------
        --    Paso 3: FETCH (Lectura de Datos)
        -- -----------------------------------------
        -- Recupera una fila del conjunto de resultados del cursor y la asigna a un 
        -- record o a variables PL/SQL. Este paso se repite para procesar todas las filas.
        DBMS_OUTPUT.PUT_LINE('FETCH (Lectura de Datos) del cursor');
        
        -- Su propósito es prevenir un error de ejecución al intentar abrir un cursor que ya está activo.
        IF NOT c_empleados%ISOPEN THEN
            OPEN c_empleados;
        END IF;
        
        LOOP
            FETCH c_empleados INTO r_empleado;
            
            -- Condición de salida: sale del loop cuando ya no hay más filas
            EXIT WHEN c_empleados%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE(r_empleado.first_name || ' gana ' || r_empleado.salary);
        END LOOP;
         DBMS_OUTPUT.PUT_LINE(CHR(10));
         
        -- ----------------------------------------
        --    Paso 4: CLOSE (Cierre)
        -- -----------------------------------------
        -- Libera los recursos de memoria asociados al cursor.
        DBMS_OUTPUT.PUT_LINE('CLOSE (Cierre) del cursor');
        CLOSE c_empleados;
    END;


    -- ----------------------------------------
    --  Simplificación: FOR Loops (Bucle Cursor)
    -- -----------------------------------------
    -- * La forma más simple, segura y recomendada de usar cursores explícitos es 
    --   mediante el bucle FOR, ya que Oracle gestiona automáticamente los pasos OPEN, FETCH, EXIT y CLOSE.
    -- * Con este método, no necesitas declarar variables de record ni usar OPEN/FETCH/CLOSE, lo que reduce la posibilidad de errores y mejora la legibilidad.
    DBMS_OUTPUT.PUT_LINE(CHR(10) ||  '=== Simplificación: FOR Loops (Bucle Cursor) ===');
    DECLARE
        -- La declaración del cursor es opcional si se usa un SELECT inline
    
    BEGIN
        -- El bucle crea un record implícito (r_emp) con la estructura del SELECT
        FOR r_emp IN (
            SELECT first_name, last_name, salary
            FROM employees
            WHERE department_id = 60
        )
        LOOP
            -- Se accede directamente a los campos del record implicito
            DBMS_OUTPUT.PUT_LINE(r_emp.first_name || ' ' || r_emp.last_name || ' tiene el salraio ' || r_emp.salary);
        END LOOP;
    END;   
    
    
    -- ----------------------------------------
    --   Cursor con parametros
    -- -----------------------------------------
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== Cursor con parametros ===' );
    DECLARE
        -- Cursor con Parámetro
        CURSOR c_empleados_por_departamento(cp_department_id NUMBER) IS 
            SELECT first_name, last_name, salary
            FROM employees
            WHERE department_id = cp_department_id;
            
        departamento_id                 NUMBER := 90;
        r_empleados_por_departamento    c_empleados_por_departamento%ROWTYPE;            
        
    BEGIN
        -- 1. Apertura Condicional: Abre el cursor solo si no está abierto
        IF NOT c_empleados_por_departamento%ISOPEN THEN
            OPEN c_empleados_por_departamento(departamento_id);
        END IF;
        
        -- 2. Procesamiento de Filas
        LOOP 
            FETCH c_empleados_por_departamento INTO r_empleados_por_departamento;
            
            EXIT WHEN c_empleados_por_departamento%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE(r_empleados_por_departamento.first_name || ' ' || r_empleados_por_departamento.last_name || ' tiene el salario ' || r_empleados_por_departamento.salary);
        END LOOP;
        
        -- 3. Reporte final (usando %ROWCOUNT)
        DBMS_OUTPUT.PUT_LINE('Ha encontrado ' || c_empleados_por_departamento%ROWCOUNT || ' empleado(s) en el departamento ' || departamento_id);
        
        -- 4. Cierre del Cursor
        CLOSE c_empleados_por_departamento;
    
    END;
END;
/

/** ----------------------------------------
||   ELIMINAR Y ACTUALIZAR  USANDO CURSORES PLSQL
|| -----------------------------------------
|| DESCRIPCIÓN:
|| a actualizar y eliminar filas dentro de un bucle de cursor, ya que esto requiere 
|| una cláusula especial en SQL: FOR UPDATE y la función WHERE CURRENT OF.
||
|| ## 1. Preparación: La Cláusula FOR UPDATE ##
|| Para actualizar o eliminar una fila dentro de un bucle de cursor, debes bloquear 
|| la fila cuando el cursor la selecciona inicialmente. Esto se hace añadiendo la cláusula FOR UPDATE a la declaración del cursor.
|| El bloqueo garantiza que otra sesión de base de datos no pueda modificar (o eliminar) 
|| esa fila específica entre el momento en que se ejecuta el OPEN y el momento en que tú ejecutas el UPDATE o DELETE.
||
|| ## 2. La Acción: WHERE CURRENT OF ##
|| Dentro del bucle FETCH, usamos la cláusula WHERE CURRENT OF para indicarle al motor 
|| SQL que la operación DML (UPDATE o DELETE) debe aplicarse exactamente a la fila que el cursor acaba de recuperar en el paso FETCH.
*/

DECLARE 
    

BEGIN 
    -- ----------------------------------------
    --   Ejemplo de Actualización (UPDATE)
    -- -----------------------------------------
    DBMS_OUTPUT.PUT_LINE('=== Ejemplo de Actualización (UPDATE) ===');
    DECLARE
        --Cursor con FOR UPDATE para bloquear las filas
        CURSOR c_empleados_a_bonificar IS
            SELECT *
            FROM employees
            WHERE commission_pct IS NULL
            FOR UPDATE OF salary NOWAIT; -- Bloquea la columna salary
            
        r_empleados_a_bonificar employees%ROWTYPE;
        
    BEGIN     
        -- Apertura Condicional: Abre el cursor solo si no está abierto
        IF NOT c_empleados_a_bonificar%ISOPEN THEN
            OPEN c_empleados_a_bonificar;
        END IF;
        
        LOOP 
            FETCH c_empleados_a_bonificar INTO r_empleados_a_bonificar;
            
            EXIT WHEN c_empleados_a_bonificar%NOTFOUND;
            
            -- Ejecuta la actualización sobre la fila actual
            UPDATE employees 
            SET commission_pct = 0.05 -- comision del 5%
            WHERE CURRENT OF c_empleados_a_bonificar;
        
        END LOOP;
        
        CLOSE c_empleados_a_bonificar;
        COMMIT;
    
    EXCEPTION
        --Manejo del error ORA-00054 si la fila esta bloqueada
        WHEN OTHERS THEN
            IF SQLCODE = -54 THEN
                DBMS_OUTPUT.PUT_LINE('Error: Una fila estaba bloqueada por otra sesión.');
            END IF;
            ROLLBACK;
    END;

    -- ----------------------------------------
    --   Ejemplo de Eliminación (DELETE)
    -- -----------------------------------------
    DBMS_OUTPUT.PUT_LINE('=== Ejemplo de Eliminación (DELETE) ===');
    DECLARE
        -- Cursor con FOR UPDATE para bloquear las filas
        CURSOR c_empleados_a_eliminar IS 
            SELECT employee_id
            FROM employees
            WHERE hire_date < ADD_MONTHS(SYSDATE, -36) -- Contratados hace más de 3 años
            FOR UPDATE; -- Bloqueo simple, sin NOWAIT
            
        r_empleados_a_eliminar c_empleados_a_eliminar%ROWTYPE;
    
    BEGIN
        IF NOT c_empleados_a_eliminar%ISOPEN THEN
            OPEN c_empleados_a_eliminar;
        END IF;
        
        LOOP
            FETCH c_empleados_a_eliminar INTO r_empleados_a_eliminar;
            EXIT WHEN c_empleados_a_eliminar%NOTFOUND;
            
            -- Ejecuta la eliminación en la fila actual
            DELETE FROM employees
            WHERE CURRENT OF c_empleados_a_eliminar;
            
            DBMS_OUTPUT.PUT_LINE('Eliminado empleado: ' || r_empleados_a_eliminar.employee_id);            
        END LOOP;
        
        CLOSE c_empleados_a_eliminar;
        COMMIT; -- Confirma la eliminación de todas las filas y libera bloqueos    
        
    EXCEPTION
        WHEN OTHERS THEN
            IF c_empleados_a_eliminar%ISOPEN THEN
                CLOSE c_empleados_a_eliminar; -- Asegura el cierre del cursor
            END IF;
            ROLLBACK; -- Deshace cualquier DELETE parcial y libera bloqueos
            DBMS_OUTPUT.PUT_LINE('ERROR EN PROCESO: ' || SQLERRM);
    END;  
    
END;
/

/** ----------------------------------------
||   PROCEDIMIENTOS Y FUNCIONES PLSQL
|| -----------------------------------------
|| DESCRIPCIÓN:
|| Son bloques de código PL/SQL nombrados, precompilados y almacenados en la base
|| de datos como objetos de esquema. Son la columna vertebral de la lógica de negocio 
|| a nivel de servidor en Oracle, permitiendo la modularidad, la reutilización y la seguridad.
||
|| ## Características ClaveCaracterísticas Clave ##
|| 1. Parámetros: A diferencia de las funciones, los procedimientos se centran en 
||    realizar una acción (ej. insertar, actualizar, auditar) y pueden tener parámetros 
||    de tipo IN, OUT, o IN OUT para interactuar con el entorno que los llama.
||
|| 2. Transacciones: Un procedimiento puede contener sentencias DML (INSERT, UPDATE, DELETE) 
||    y control de transacciones (COMMIT y ROLLBACK).
||
|| 3. Valor de Retorno: Los procedimientos no devuelven un valor directamente al
||    nombre del objeto (como lo hace una función). Si necesitan devolver datos, deben hacerlo
||    a través de un parámetro OUT o un REF CURSOR.
||
|| ==== Procedimiento vs. Función ===
|| 
|| Característica	    Procedimiento	                    Función
|| Valor de Retorno	    No, utiliza parámetros OUT.	        Sí, devuelve un único valor escalar.
|| 
|| Uso en SQL	        No se puede usar en sentencias  	Sí se puede usar en sentencias 
||                      SELECT, WHERE, o VALUES             SELECT y cláusulas WHERE.
|| 
|| Transacciones	    Puede contener COMMIT/ROLLBACK.	    No debe contener COMMIT/ROLLBACK (si se usa en SQL).
|| 
|| Propósito	        Ejecutar una acción                 Calcular y devolver un valor.
||                     (cambios de estado, ETL, etc.).  
*/

-- EJEMPLO PROCEDIMIENTO # 1
CREATE OR REPLACE PROCEDURE pr_registrar_region (
    p_region_name IN VARCHAR2  -- Parámetro de entrada
)
AS
    v_consecutivo regions.region_id%TYPE;

BEGIN
    
    -- 1. Obtener el siguiente valor de la secuencia (Seguro para concurrencia)
    SELECT regions_seq.NEXTVAL
    INTO v_consecutivo
    FROM dual;
    
    -- 2. Inserción usando el ID seguro
    INSERT INTO regions(region_id, region_name) 
    VALUES (v_consecutivo , p_region_name);
    
    COMMIT; -- Confirma la inserción inmediatamente
    
EXCEPTION
    WHEN OTHERS THEN 
        -- No se hace ROLLBACK aquí para no afectar la transacción padre.
        -- Simplemente se reporta que la inserción falló.
        DBMS_OUTPUT.PUT_LINE('Fallo al registrar la region: ' || SQLERRM);
    
END pr_registrar_region;
/

-- ----------------------------------------
--      Llamado al procedimiento
-- -----------------------------------------
BEGIN
    pr_registrar_region('Centro America');
    pr_registrar_region('Sur AMerica');
END;
/

/** ----------------------------------------
||   USER_OBJECTS PLSQL
|| -----------------------------------------
*/
SELECT * FROM USER_OBJECTS 
WHERE OBJECT_TYPE='PROCEDURE';

SELECT OBJECT_TYPE,COUNT(*) FROM USER_OBJECTS
GROUP BY OBJECT_TYPE;

SELECT * FROM USER_SOURCE
WHERE NAME='pr_registrar_region';

SELECT TEXT FROM USER_SOURCE
WHERE NAME='pr_registrar_region';


/** ----------------------------------------
||         PARAMETROS PLSQL
|| -----------------------------------------
|| DESCRIPCIÓN:
|| Los parámetros en PL/SQL son los mecanismos que permiten que los procedimientos 
|| y funciones almacenados se comuniquen con el mundo exterior, es decir, reciban 
|| datos de la aplicación que los llama o devuelvan datos a ella.
||
|| ## Modos de Parámetros ##
|| En PL/SQL, cada parámetro debe definirse con un modo que especifica cómo se utiliza 
|| la información. Hay tres modos principales:
||
|| 1. IN (Entrada)
|| - Propósito: El valor se pasa del programa que llama al subprograma (procedimiento o función).
|| - Comportamiento: El valor se trata como una constante dentro del subprograma. No puedes modificar el valor del parámetro IN dentro del cuerpo del procedimiento o función.
|| - Modo por defecto: Si omites el modo en la declaración, Git asume que el parámetro es IN
||
||   PROCEDURE pr_actualizar_salario (
||      p_empleado_id   IN NUMBER, -- Recibe el ID
||      p_aumento       IN NUMBER      -- Recibe el porcentaje de aumento
||   )
||
|| 2. OUT (Salida)
|| - Propósito: El subprograma utiliza el parámetro para devolver un valor al programa que lo llama.
|| - Comportamiento: La variable se inicializa a NULL al entrar al subprograma. Su valor se ignora al ser llamada. El subprograma debe asignar un valor al parámetro OUT para que sea visible fuera de él.
|| - Restricción: No se puede usar como parte de una expresión en una sentencia SQL.
||
||   PROCEDURE pr_obtener_datos_emp (
||      p_empleado_id       IN  NUMBER,
||      p_nombre_completo   OUT VARCHAR2, -- Devuelve el nombre
||      p_salario_actual    OUT NUMBER     -- Devuelve el salario
||  )
||
|| 3. IN OUT (Entrada y Salida)
|| - Propósito: La variable se pasa al subprograma (como IN) y luego su valor puede ser modificado y devuelto al programa que llama (como OUT).
|| - Comportamiento: Se utiliza típicamente para contadores o para modificar estructuras de datos (como colecciones) y devolver la estructura modificada.
|| 
||  PROCEDURE pr_ajustar_y_contar (
||      p_contador IN OUT NUMBER, -- Recibe un valor y lo devuelve modificado
||      p_ajuste IN NUMBER
||  )
||  AS
||  BEGIN
||      p_contador := p_contador + p_ajuste;
||     -- ... lógica que usa y modifica el contador
||  END;
*/

CREATE OR REPLACE PROCEDURE pr_ejemplo_parametros (
    p_id_entrada    IN      NUMBER,
    p_resultado     OUT     VARCHAR2,
    p_contador      IN OUT  NUMBER,
    p_opcional      IN      VARCHAR2    DEFAULT 'Ninguna' -- Parametro con valor por defecto
)
AS
    -- ..
BEGIN
    -- Lógica IN yOUT
    SELECT first_name 
    INTO p_resultado
    FROM employees
    WHERE employee_id = p_id_entrada;
    
    -- Lógica con IN OUT
    p_contador := p_contador + 1;
    
    DBMS_OUTPUT.PUT_LINE('Opcion: ' || p_opcional);   
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_resultado := 'ID No Encontrado'; -- Manejar el caso de que el SELECT no devuelva nada
        p_contador := p_contador; -- No modificar el contador en caso de fallo
    WHEN OTHERS THEN
        p_resultado := 'Error';
        RAISE;

END pr_ejemplo_parametros;
/

-- ----------------------------------------
--  Llamando al procedimiento
-- -----------------------------------------
DECLARE
    v_nombre    VARCHAR2(25) := 'Alexander';
    v_conteo    NUMBER := 1;
BEGIN
    pr_ejemplo_parametros(
        p_id_entrada => 100,
        p_resultado => v_nombre,
        p_contador => v_conteo
    );
    
     DBMS_OUTPUT.PUT_LINE('Respuesta del procedimiento: ' || v_conteo);   
END;

/** ----------------------------------------
||         FUNCIONES EN PLSQL
|| -----------------------------------------
|| DESCRIPCIÓN:
|| son subprogramas nombrados, precompilados y almacenados en la base de datos, 
|| diseñados para calcular y devolver un único valor al programa o sentencia SQL que las llama.
||
|| Son la herramienta principal para encapsular lógica de cálculo y reutilizarla en sentencias SQL.
||
|| ## Estructura Básica ##
|| La sintaxis de una función es muy similar a la de un procedimiento, con dos diferencias clave: 
|| el uso de la cláusula RETURN en la declaración y la necesidad de una sentencia RETURN dentro del bloque BEGIN.
||
|| CREATE OR REPLACE FUNCTION nombre_funcion (
||     parametro1 IN TIPO,
||     parametro2 IN TIPO DEFAULT valor_inicial
|| )
|| -- CLÁUSULA ESENCIAL: Define el tipo de dato que se devolverá
|| RETURN TIPO_DE_RETORNO
|| AS
||     -- Sección de Declaración: Variables locales
||     v_resultado TIPO_DE_RETORNO; 
|| BEGIN
||     -- Sección de Ejecución: Lógica de cálculo
||     v_resultado := parametro1 * 0.15; -- Ejemplo de cálculo
|| 
||     -- CLÁUSULA ESENCIAL: Devuelve el valor calculado
||     RETURN v_resultado; 
|| 
|| EXCEPTION
||     -- Manejo de errores
||     WHEN OTHERS THEN
||         RETURN NULL; -- Devolver NULL o un valor de error específico
|| END;
|| /
||
||  === Diferencias Clave con los Procedimientos ===
||
|| Característica	    Función	                                    Procedimiento
|| Valor de Retorno	    Obligatorio. Devuelve un único valor	    No devuelve valor; usa parámetros 
||                      escalar (NUMBER, VARCHAR2, DATE, etc.)      OUT para enviar datos.
||
|| Uso en SQL	        Se puede llamar directamente en 	        No se puede llamar en sentencias SQL; 
||                      sentencias SELECT, WHERE, VALUES, etc.      debe usarse en bloques PL/SQL.
||
|| Transacciones	    No debe contener COMMIT o ROLLBACK 	        Puede contener COMMIT o ROLLBACK.
||                      si se usa en sentencias SQL.
||
|| Propósito	        Responder una pregunta 	                    Ejecutar una acción (ej. Insertar 
||                      (ej. ¿Cuál es el salario neto?).            log, actualizar estado).
*/

CREATE OR REPLACE FUNCTION fn_calcular_impuesto(
    p_salario IN NUMBER
)
RETURN NUMBER -- La función devolerá un número
AS
    v_tasa_impuesto CONSTANT NUMBER := 0.10; -- 10% de impuesto

BEGIN
    -- Devolver el 10% del salario
    RETURN p_salario * v_tasa_impuesto;
    
EXCEPTION 
    -- En caso de que p_salario sea NULL o haya otro error
    WHEN OTHERS THEN
        RETURN 0; -- Devuelve 0 en caso de error

END;
/

-- ----------------------------------------
--  Uso de la Función en SQL
-- -----------------------------------------
-- SQL
SELECT 
    first_name,
    employee_id,
    salary,
    fn_calcular_impuesto(salary) AS monto_impuesto,
    (salary- fn_calcular_impuesto(salary)) AS salario_neto
FROM employees
WHERE department_id = 90;

--PLSQL
BEGIN
    FOR r_empleado_info IN (
        SELECT 
            first_name,
            employee_id,
            salary,
            fn_calcular_impuesto(salary) AS monto_impuesto,
            (salary- fn_calcular_impuesto(salary)) AS salario_neto
        FROM employees
        WHERE department_id = 90
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || r_empleado_info.first_name ||
                             ', Emp ID: ' || r_empleado_info.employee_id ||
                             ', Salario: ' || r_empleado_info.salary ||
                             ', Monto Impuesto: ' || r_empleado_info.monto_impuesto || 
                             ', Salario Neto: ' || r_empleado_info.salario_neto);
    END LOOP;
END;
/

/** ----------------------------------------
||         PAQUETES EN PLSQL
|| -----------------------------------------
|| DESCRIPCIÓN:
|| son contenedores que agrupan lógicamente procedimientos, funciones, variables, 
|| cursores, excepciones y tipos de datos relacionados en una sola unidad almacenada 
|| en la base de datos. 📦 Son fundamentales para la modularidad, la organización del código y la seguridad en Oracle.
||
||  ## Estructura de un Paquete ##
||  Un paquete consta de dos partes separadas pero interdependientes, cada una creada 
||  con su propio comando CREATE OR REPLACE:
||
||  1. Especificación o Cabecera (PACKAGE)
||  Define la interfaz pública del paquete. Es decir, declara qué objetos son visibles y accesibles desde fuera del paquete.
||  * Propósito: Actúa como un contrato. Indica lo que el paquete puede hacer.
||  * Contiene: Solo las declaraciones (cabeceras) de funciones y procedimientos públicos, la declaración de variables públicas (constantes), tipos de datos y cursores.
||
||*/

CREATE OR REPLACE PACKAGE pkg_gestion_empleados AS
    
    -- ----------------------------------------
    -- Cabecera de función pública
    -- -----------------------------------------
    FUNCTION fn_existe_empleado(p_email IN VARCHAR2)
    RETURN VARCHAR2;
    
    -- ----------------------------------------
    -- Cabecera de procedimiento público
    -- -----------------------------------------
    PROCEDURE pr_crear_empleado(
        p_first_name        IN employees.first_name     %TYPE,
        p_last_name         IN employees.last_name      %TYPE,
        p_email             IN employees.email          %TYPE,
        p_phone_number      IN employees.phone_number   %TYPE,
        p_job_id            IN employees.job_id         %TYPE,
        p_salary            IN employees.salary         %TYPE,
        p_manager_id        IN employees.manager_id     %TYPE,
        p_department_id     IN employees.department_id  %TYPE,
        p_empleado          OUT employees               %ROWTYPE
    );
    
END pkg_gestion_empleados;
/

/**
||  2. Cuerpo (PACKAGE BODY)
||  Contiene la implementación (el código PL/SQL real) de todos los subprogramas declarados en la especificación, además de cualquier objeto privado.
||  * Propósito: Contiene la lógica de negocio. Indica el cómo se hace.
||  * Contiene: El código completo de las funciones y procedimientos. Puede contener objetos privados (variables, cursores, subprogramas auxiliares) que solo son accesibles desde dentro del cuerpo del paquete.
||*/

CREATE OR REPLACE PACKAGE BODY pkg_gestion_empleados AS

    -- ----------------------------------------
    -- Implementación de la Función (obligatoria)
    -- -----------------------------------------
    FUNCTION fn_existe_empleado(p_email IN VARCHAR2) 
    RETURN VARCHAR2
    AS 
        v_count NUMBER;
        
    BEGIN    
        SELECT COUNT(*)
        INTO v_count
        FROM employees
        WHERE UPPER(email) = UPPER(p_email);
        
        RETURN CASE WHEN v_count > 0 THEN 'S' ELSE 'N' END;
        
    EXCEPTION
        WHEN OTHERS THEN 
           DBMS_OUTPUT.PUT_LINE('Error');
           RETURN 'E';
    
    END fn_existe_empleado;    


    -- ----------------------------------------
    -- Implementación del Procedimiento (obligatoria)
    -- -----------------------------------------
    PROCEDURE pr_crear_empleado(
        p_first_name        IN employees.first_name     %TYPE,
        p_last_name         IN employees.last_name      %TYPE,
        p_email             IN employees.email          %TYPE,
        p_phone_number      IN employees.phone_number   %TYPE,
        p_job_id            IN employees.job_id         %TYPE,
        p_salary            IN employees.salary         %TYPE,
        p_manager_id        IN employees.manager_id     %TYPE,
        p_department_id     IN employees.department_id  %TYPE,
        p_empleado          OUT employees               %ROWTYPE
    )
    AS
        v_consecutivo       employees.employee_id%TYPE;
        v_existe_empleado   VARCHAR2(1);
        
    BEGIN
    
        -- Verifica si el empleado ya esta registrado
        v_existe_empleado := fn_existe_empleado(p_email);
        IF v_existe_empleado =  'E' THEN     
            RAISE_APPLICATION_ERROR(-20002, ' Error al verificar existencia del empleado');
            
        ELSIF v_existe_empleado = 'S' THEN
            RAISE_APPLICATION_ERROR(-20001, ' El empleado con email ' || p_email || ' Ya existe');
            
        ELSE
            -- Obtener el siguiente valor de la secuencia (Seguro para concurrencia)
            SELECT employees_seq.NEXTVAL
            INTO v_consecutivo
            FROM dual;        
            
            -- Insertar el empleado
            INSERT INTO employees (employee_id, 
                first_name, 
                last_name, 
                email, 
                phone_number, 
                job_id, 
                salary, 
                manager_id, 
                department_id,
                hire_date)
            VALUES(v_consecutivo, 
                p_first_name, 
                p_last_name, 
                p_email, 
                p_phone_number, 
                p_job_id, 
                p_salary, 
                p_manager_id, 
                p_department_id,
                TO_CHAR(SYSDATE, 'DD/MM/YYYY'));
                
            COMMIT;
                
            -- Obtener el empleado creado
            SELECT * 
            INTO p_empleado
            FROM employees
            WHERE employee_id = v_consecutivo;
            
            DBMS_OUTPUT.PUT_LINE('Empleado creado exitosamente: ' || p_empleado.first_name);
            
        END IF;    
        
    EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE('Error ' || SQLERRM);
            ROLLBACK;
            RAISE;
            
    END pr_crear_empleado;
    

END pkg_gestion_empleados;
/

-- ----------------------------------------
--         🧪 PROBAR EL PACKAGE
-- -----------------------------------------

DECLARE
    v_empleado  employees%ROWTYPE;
    v_existe    VARCHAR2(1);  

BEGIN
    
    --Probar la función
    v_existe := pkg_gestion_empleados.fn_existe_empleado('');
    DBMS_OUTPUT.PUT_LINE('¿Existe empleado? ' || v_existe);

    -- Probar el procedimiento
    pkg_gestion_empleados.pr_crear_empleado(
        p_first_name        => 'Maria',
        p_last_name         => 'Gonzalez',
        p_email             => 'Maria@empresa.com',
        p_phone_number      => '5904245567',
        p_job_id            => 'ST_MAN',
        p_salary            => 6000,
        p_manager_id        => 100,
        p_department_id     => 50,
        p_empleado          => v_empleado
    );
    
     DBMS_OUTPUT.PUT_LINE('Empleado creado: ' || v_empleado.employee_id);
END;
/

/** ----------------------------------------
||      SOBRECARGA DE PROCEDIMINETOS
|| -----------------------------------------
|| DESCRIPCIÓN:
|| La sobrecarga de procedimientos (Procedure Overloading) en PL/SQL es la capacidad 
|| de definir múltiples procedimientos o funciones con el mismo nombre dentro del mismo ámbito 
|| (casi siempre, dentro de un paquete), siempre y cuando sus listas de parámetros sean diferentes.
||
|| ## Criterios de Sobrecarga ##
|| Para que un subprograma pueda sobrecargarse, el compilador de PL/SQL debe ser capaz 
|| de distinguirlo de todos los demás con el mismo nombre. La distinción se basa en la firma del subprograma, que incluye:
||
|| 1. Número de parámetros.
|| 2. Tipo de dato de los parámetros (ej., NUMBER vs. VARCHAR2).
|| 3. Orden de los parámetros si sus tipos son distintos.
||
|| ## Ejemplo de Sobrecarga en un Paquete ##
|| Un paquete de utilidades podría tener varias funciones para calcular un área, 
|| todas llamadas calcular_area, pero adaptadas a diferentes formas geométricas:
*/

-- PACKAGE
CREATE OR REPLACE PACKAGE pk_geometria AS

    -- Sobrecarga 1: Área de un cuadrado o rectángulo (Largo y Ancho)
    FUNCTION calcular_area(
        p_largo IN NUMBER,
        p_ancho IN NUMBER
    ) RETURN NUMBER;
    
    -- Sobrecarga 2: Área de un círculo (Solo Radio)
    FUNCTION calcular_area(
        p_radio IN NUMBER
    ) RETURN NUMBER;
END pk_geometria;
/

-- PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY pk_geometria AS

    -- Constante de Pi (necesaria para el círculo)
    PI CONSTANT NUMBER := 3.14159265359;
    
    -- 1. SOBRECARGA: Área de un Rectángulo/Cuadrado (Largo y Ancho)
    -- Fórmula: Largo * Ancho
    FUNCTION calcular_area(
        p_largo IN NUMBER,
        p_ancho IN NUMBER
    ) RETURN NUMBER
    AS 
    BEGIN
        -- Validación básica
        IF p_largo IS NULL OR p_ancho IS NULL THEN
            RETURN NULL;
        END IF;

        RETURN p_largo * p_ancho;
        
    END calcular_area;
    
    ---
    
    -- 2. SOBRECARGA: Área de un Círculo (Radio)
    -- Fórmula: Pi * Radio^2
    FUNCTION calcular_area(
        p_radio IN NUMBER
    ) RETURN NUMBER
    AS 
    BEGIN
        IF p_radio IS NULL THEN
            RETURN NULL;
        END IF;
        
        -- Utilizando la constante PI
        RETURN PI * (p_radio * p_radio);
        
    END calcular_area;
    
END pk_geometria;
/

-- USO
DECLARE
    v_alto_rectangulo   NUMBER  := 5;
    v_ancho_rectangulo  NUMBER  := 10;
    v_area_rectangulo   NUMBER  := 0;
    
    v_radio             NUMBER  := 3;
    v_area_circulo      NUMBER  := 0;
    
BEGIN
    -- 1. Llama a la función del Rectángulo/Cuadrado (NUMBER, NUMBER)
    v_area_rectangulo := pk_geometria.calcular_area(
        TO_NUMBER(v_alto_rectangulo),
         TO_NUMBER(v_ancho_rectangulo));
    DBMS_OUTPUT.PUT_LINE('Area del Rectángulo ('|| v_alto_rectangulo ||'x'|| v_ancho_rectangulo ||'): ' || v_area_rectangulo);

    -- 2. Llama a la función del Círculo (NUMBER)
    v_area_circulo := pk_geometria.calcular_area(v_radio);
    DBMS_OUTPUT.PUT_LINE('Area del Círculo (Radio ' || v_radio || '): ' || v_area_circulo);
END;
/

/** ----------------------------------------
||      PAQUETES PREDEFINIDOS EN ORACLE
|| -----------------------------------------
|| DESCRIPCIÓN:
|| Oracle Database incluye una extensa colección de paquetes predefinidos (o paquetes incorporados) 
|| que proporcionan una interfaz PL/SQL para acceder a la funcionalidad del sistema y realizar tareas 
|| de administración de bases de datos, desarrollo y debugging.
||
|| Estos paquetes actúan como librerías, permitiendo a los desarrolladores y administradores 
|| interactuar con el kernel de la base de datos sin escribir SQL complejo.
||
|| === PAQUETES ESENCIALES PARA DESARROLLO DE CONSOLA ===
|| Estos paquetes son cruciales para el desarrollo diario, la salida de mensajes y el manejo básico de datos.
||
|| Paquete	  |     Propósito Principal	 |   Función/Uso Común
|| ___________|__________________________|________________________________________________________________________
|| DBMS_OUTPUT|	    Depuración y 	     |  Muestra información en la consola PL/SQL (PUT_LINE). 
||            |     mensajería.          |  Requiere SET SERVEROUTPUT ON.
||            |                          |
|| UTL_FILE	  |     Entrada/Salida 	     |  Permite leer y escribir archivos del sistema operativo en el 
||            |     de archivos.         |  servidor. Muy utilizado para generación de reportes y carga de datos          
||            |                          |
|| DBMS_SQL	  |     SQL dinámico 	     |  Permite cosntruir y ejecutar sentencias SQL donde la estructura 
||            |     avanzado.            |  (el SELECT o WHERE) no se conoce hasta el tiempo de ejecución.
||            |                          |
|| DBMS_LOB	  |     Manejo de tipos de 	 |  Proporciona procedimientos y funciones para manipular datos grandes 
||            |     datos LOB.           |  (como imágenes, documentos, etc.) almacenados en columnas BLOB, CLOB, o BFILE.
||____________|__________________________|_________________________________________________________________________
*/
-- DBMS_OUTPUT (Depuración y Mensajería)
BEGIN
    -- Muestra el valor de una variable o un mensaje de estado
    DBMS_OUTPUT.PUT_LINE('--- INICIO DE PROCESO ---');
    DBMS_OUTPUT.PUT_LINE('La fecha actual es: ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD'));
END;
--
--
-- UTL_FILE (Entrada/Salida de Archivos)
-- -- DDL Requerido (Ejecutar por un DBA): CREATE DIRECTORY data_dir AS '/ruta/del/servidor/';
DECLARE
    v_file_handle UTL_FILE.FILE_TYPE;
BEGIN
    -- Abrir el archivo en modo escritura ('w') en el directorio lógico 'DATA_DIR'
    v_file_handle := UTL_FILE.FOPEN('DATA_DIR', 'log_error.txt', 'w');
    --
    -- Escribir una línea de texto
    UTL_FILE.PUT_LINE(v_file_handle, 'ERROR [2025-10-31]: Fallo en el procedimiento de nómina.');
    --
    -- Cerrar el archivo
    UTL_FILE.FCLOSE(v_file_handle);
EXCEPTION
    WHEN UTL_FILE.INVALID_PATH THEN
        DBMS_OUTPUT.PUT_LINE('Error: Ruta de directorio no válida.');
END;
--
--
-- DBMS_SQL (SQL Dinámico Avanzado)
DECLARE
    v_cursor_id    INTEGER       := DBMS_SQL.OPEN_CURSOR;
    v_sentencia    VARCHAR2(200) := 'SELECT COUNT(*) FROM regions WHERE region_id = :id_param';
    v_resultado    NUMBER;
    v_dummy        INTEGER;   
BEGIN
    -- 1. Parsear la sentencia con un parámetro de enlace
    DBMS_SQL.PARSE(v_cursor_id, v_sentencia, DBMS_SQL.NATIVE); 
    --
    -- 2. Enlazar el valor al parámetro
    DBMS_SQL.BIND_VARIABLE(v_cursor_id, ':id_param', 3);
    --
    -- 3. Ejecutar la sentencia
    v_dummy := DBMS_SQL.EXECUTE(v_cursor_id);
    --
    -- 4. Recuperar el resultado
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 1, v_resultado);
   -- 
    if DBMS_SQL.FETCH_ROWS(v_cursor_id) > 0 then
        DBMS_SQL.COLUMN_VALUE(v_cursor_id, 1, v_resultado);
    end if;
    --
    DBMS_OUTPUT.PUT_LINE('Conteo de regiones: ' || v_resultado);
    DBMS_SQL.CLOSE_CURSOR(v_cursor_id);
END;
--
/**
||  === PAQUETES PARA TAREAS DE ADMINISTRACIÓN Y SISTEMAS ===
||  Estos paquetes son utilizados frecuentemente por los administradores de bases de datos (DBAs) o para tareas de mantenimiento y seguridad.
||
|| Paquete         |   Propósito Principal	  |   Función/Uso Común
|| ________________|__________________________|____________________________________________________________________
|| DBMS_SCHEDULER  |   Programación           |   Reemplazo moderno de DBMS_JOB. Permite crear, 
||                 |   de trabajos (Jobs).    |   gestionar y ejecutar tareas planificadas (jobs) dentro de la base de datos (ej., respaldos nocturnos).
||                 |                          |
|| DBMS_STATS      |   Gestión de             |   Recopila, modifica, restaura y elimina estadísticas sobre objetos de la base de datos para asegurar 
||                 |   estadísticas del       |   un rendimiento óptimo de las consultas.
||                 |   optimizador.           |
||                 |                          |
|| DBMS_METADATA   |  Extracción de DDL       |  Permite obtener las sentencias CREATE (DDL) de cualquier objeto de la base de datos 
||                 | (Código).                |  (tablas, índices, procedimientos, etc.).
||                 |                          |
||                 |                          |
|| DBMS_RANDOM     | Generación de números    |  Útil para pruebas, generación de datos de muestra o claves aleatorias.
||                 | aleatorios.              |
|| ________________|__________________________|____________________________________________________________________
||
*/
-- DBMS_SCHEDULER (Programación de Trabajos)
BEGIN
    -- Crear un job que llama al procedimiento 'pr_limpiar_logs' cada 24 horas
    DBMS_SCHEDULER.CREATE_JOB (
       job_name        => 'JOB_LIMPIEZA_DIARIA_LOGS',
       job_type        => 'STORED_PROCEDURE',
       job_action      => 'PR_LIMPIAR_LOGS', -- Debe existir el procedimiento
       start_date      => SYSDATE,
       repeat_interval => 'FREQ=DAILY; INTERVAL=1',
       enabled         => TRUE,
       comments        => 'Limpia la tabla de logs diariamente.'
    );
END;
/
--
--
-- DBMS_STATS (Gestión de Estadísticas del Optimizador)
BEGIN
    -- Recopila estadísticas para la tabla EMPLOYEES
    DBMS_STATS.GATHER_TABLE_STATS (
        ownname => 'HR',
        tabname => 'EMPLOYEES',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, -- Muestreo automático
        degree => DBMS_STATS.DEFAULT_DEGREE
    );
    DBMS_OUTPUT.PUT_LINE('Estadísticas recopiladas para EMPLOYEES.');
END;
/
--
--
-- DBMS_RANDOM (Generación de Números Aleatorios)
DECLARE
    v_numero_aleatorio NUMBER;
BEGIN
    -- Generar un número entero aleatorio entre 100 y 999
    v_numero_aleatorio := DBMS_RANDOM.VALUE(100, 999); 
    
    DBMS_OUTPUT.PUT_LINE('ID aleatorio generado: ' || TRUNC(v_numero_aleatorio));
END;
/
--
/**
||  === PAQUETES PARA CONECTIVIDAD Y WEB
||
|| Paquete   |  Propósito Principal	    |   Función/Uso Común
|| __________|__________________________|__________________________________________________________________________
|| UTL_HTTP  |  Solicitudes HTTP (Web). |   Permite a PL/SQL enviar solicitudes HTTP (GET, POST) y recibir respuestas desde servidores web, 
||           |                          |   facilitando la integración con servicios externos (APIs REST).
||           |                          |
|| UTL_SMTP  |  Envío de correo         |   Permite que la base de datos envíe correos electrónicos a través de un servidor SMTP.
||           |  electrónico.            |
||___________|__________________________|__________________________________________________________________________
*/
-- UTL_HTTP (Solicitudes HTTP)
-- DDL Requerido (Ejecutar por DBA): ACL (Access Control List) para permitir la conexión saliente
DECLARE
    v_response_clob CLOB;
BEGIN
    -- Hacer una solicitud GET simple
    v_response_clob := UTL_HTTP.REQUEST('http://www.example.com'); 
    --
    -- Mostrar las primeras 500 letras de la respuesta (HTML)
    DBMS_OUTPUT.PUT_LINE('Respuesta del servidor: ' || DBMS_LOB.SUBSTR(v_response_clob, 500, 1));
END;
/
--
--
-- UTL_SMTP (Envío de Correo Electrónico)
-- DDL Requerido: Configuración del servidor SMTP y ACL.
DECLARE
    v_connection UTL_SMTP.CONNECTION;
BEGIN
    -- 1. Abrir la conexión al servidor SMTP (reemplazar con datos reales)
    v_connection := UTL_SMTP.OPEN_CONNECTION('smtp.tuservidor.com', 25);
    UTL_SMTP.HELO(v_connection, 'localhost');
    --
    -- 2. Configurar emisor y receptor
    UTL_SMTP.MAIL(v_connection, 'sistema@oracle.com');
    UTL_SMTP.RCPT(v_connection, 'usuario@dominio.com');
    --
    -- 3. Enviar el contenido
    UTL_SMTP.DATA(v_connection, 
        'Subject: Reporte Diario' || UTL_TCP.CRLF || 
        'Contenido: El proceso diario ha finalizado con éxito.');
    --   
    -- 4. Cerrar la conexión
    UTL_SMTP.QUIT(v_connection);
    --
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Fallo el envío de correo: ' || SQLERRM);
END;
/
/**
||  === PAUQETES PARA SEGURIDAD Y SESIÓN ===
||
|| Paquete         |   Propósito Principal	  |   Función/Uso Común
|| ________________|__________________________|____________________________________________________________________
|| DBMS_SESSION    |   Gestión de la sesión   |   Permite modificar parámetros de la sesión actual (ej., 
||                 |   actual.                |   establecer roles, cambiar el NLS_DATE_FORMAT).
||                 |                          |
|| DBMS_CRYPTO     |   Cifrado y              |   Proporciona algoritmos de cifrado, hashing y firma de datos.
||                 |   descifrado.            | 
||_________________|__________________________|____________________________________________________________________
*/
-- BMS_SESSION (Gestión de la Sesión Actual)
BEGIN
    -- Cambiar el formato de fecha para la sesión actual
    DBMS_SESSION.SET_NLS('NLS_DATE_FORMAT', '''DD-MON-RR''');
    
    DBMS_OUTPUT.PUT_LINE('Fecha actual con nuevo formato: ' || SYSDATE);
    
    -- Restablecer el formato predeterminado
    -- DBMS_SESSION.SET_NLS('NLS_DATE_FORMAT', '''DD/MM/RR'''); 
END;
/
--
--
-- DBMS_CRYPTO (Cifrado y Descifrado)
DECLARE
    v_entrada     VARCHAR2(100) := 'MiContrasenaSecreta';
    v_clave       RAW(128) := UTL_I18N.STRING_TO_RAW('clave_secreta', 'AL32UTF8');
    v_cifrado     RAW(2048);
    v_descifrado  VARCHAR2(100);
    --
    -- Algoritmo: AES de 256 bits, modo CBC, y PKCS#5 padding
    v_modo_cifrado CONSTANT INTEGER := DBMS_CRYPTO.ENCRYPT_AES256 + DBMS_CRYPTO.CHAIN_CBC + DBMS_CRYPTO.PAD_PKCS5;
BEGIN
    -- Cifrar el valor
    v_cifrado := DBMS_CRYPTO.ENCRYPT(
        src => UTL_I18N.STRING_TO_RAW(v_entrada, 'AL32UTF8'),
        typ => v_modo_cifrado,
        key => v_clave
    );
    --
    DBMS_OUTPUT.PUT_LINE('Cadena cifrada (RAW): ' || v_cifrado);
    --
    -- Descifrar el valor
    v_descifrado := UTL_I18N.RAW_TO_STRING(
        DBMS_CRYPTO.DECRYPT(
            src => v_cifrado,
            typ => v_modo_cifrado,
            key => v_clave
        ), 'AL32UTF8'
    );
    --
    DBMS_OUTPUT.PUT_LINE('Cadena descifrada: ' || v_descifrado);
END;
/
--
/** ----------------------------------------
||  TIPO Y EVENTOS DE LOS TRIGGER EN PLSQL
|| -----------------------------------------
|| DESCRIPCIÓN:
|| Los Triggers (Disparadores) en PL/SQL son procedimientos almacenados que se ejecutan de forma automática e implícita 
|| en la base de datos cuando ocurre un evento específico.
|| 
|| Se clasifican según cuándo se ejecutan (Tipo) y qué evento los dispara (Evento).
||
|| 1. Tipos de Triggers (Nivel de Ejecución)
|| Los Triggers se clasifican según el nivel de granularidad o cuántas veces se disparan por cada sentencia SQL:
*/
-- -----------------------------------------
-- A. Trigger a Nivel de Sentencia (Statement Level)
-- * Definición: El trigger se ejecuta una sola vez por la sentencia SQL, independientemente de cuántas filas afecte.
-- * Uso: Ideal para tareas administrativas o de registro que no dependen de los valores individuales de las filas. No tiene acceso a los pseudoregistros :OLD ni :NEW.
-- * Ejemplo: Registrar quién y cuándo se ejecutó un DELETE en la tabla EMPLOYEES.
-- -----------------------------------------
CREATE OR REPLACE TRIGGER trg_log_delete_statement
-- Evento: Después de cualquier DELETE
AFTER DELETE ON employees
BEGIN
    -- Se dispara solo una vez
    insert into audit_log (user_name, action_type, table_name, action_time)
    values (USER, 'DELETE', 'EMPLOYEES', SYSDATE);
END;
/
--PROBAR TRIGGER
BEGIN
   delete from employees
   where employee_id = 106;
   COMMIT;
END;
/
--
-- -----------------------------------------
-- B. Trigger a Nivel de Fila (FOR EACH ROW)
-- * Definición: El trigger se ejecuta una vez por cada fila afectada por la sentencia SQL.
-- * Uso: Crucial para aplicar lógica de negocio, validaciones y auditorías de datos fila por fila. Permite acceder a los valores antiguos y nuevos.
-- * Ejemplo: Auditar los cambios de salario en la tabla EMPLOYEES.
-- -----------------------------------------
CREATE OR REPLACE TRIGGER trg_auditoria_salario
-- Evento: Antes de actualizar la columna salary
BEFORE UPDATE OF salary ON employees 
-- Tipo: A nivel de Fila
FOR EACH ROW
BEGIN
    -- Accede al valor antiguo (:OLD) y al nuevo (:NEW)
    if :NEW.salary < :OLD.salary * 1.05 then 
        -- Si el nuevo salario es menor al 5% del anterior, forzar un mensaje de error
        RAISE_APPLICATION_ERROR(-20005, 'El aumento de salario debe ser al menos del 5%.');
    end if;
END;
/
--PROBAR TRIGGER
BEGIN
   update employees
   set salary = 9000
   where employee_id = 110;
END;
/
--
-- -----------------------------------------
-- 2. Eventos de los Triggers (Clasificación)
-- El evento define la acción que dispara la ejecución del trigger. 
-- -----------------------------------------
-- I. Eventos DML (Data Manipulation Language)
-- Se disparan por cambios en los datos de una tabla. Se debe especificar el momento de ejecución (BEFORE o AFTER).
-- 
-- Evento  |   Descripción	     |  Ejemplo
-- ________|_____________________|____________________________________________________________________
-- INSERT  |   Al agregar nuevas |  Asignar automáticamente un ID secuencial antes de la inserción.
--         |   filas.            |   
--         |                     |
-- UPDATE  |   Al modificar filas|  Registrar el valor anterior de una columna en un historial.
--         |   existentes.       |   
--         |                     |
-- DELETE  |   Al eliminar filas |  Borrar registros relacionados en una tabla hija.
--_________|_____________________|____________________________________________________________________
-- Ejemplo DML (INSERT): Asignar ID Automático
CREATE OR REPLACE TRIGGER tr_auto_id_regions
-- Antes de insertar en la tabla regions
BEFORE INSERT ON regions
FOR EACH ROW
BEGIN
    -- Si el ID no se proporciona, asigna el siguiente valor de la secuencia
    if :NEW.region_id IS NULL then
        select regions_seq.NEXTVAL into :NEW.region_id FROM dual;
    end if;
END;
/ 
--
-- -----------------------------------------
-- II. Eventos DDL (Data Definition Language)
-- Se disparan por cambios en la estructura de la base de datos (Ej. CREATE, ALTER, DROP). Se definen a nivel de esquema (ON SCHEMA) o a nivel de base de datos (ON DATABASE).
-- Ejemplo DDL (CREATE): Evitar la creación de tablas por un usuario
-- -----------------------------------------
CREATE OR REPLACE TRIGGER trg_evitar_creacion_tablas
-- Antes de que se cree cualquier objeto DDL en este esquema
BEFORE CREATE ON SCHEMA
BEGIN
    -- Si el usuario no es 'SYSADMIN', lanzar un error
    if USER != 'SYSADMIN' then
        RAISE_APPLICATION_ERROR(-20006, 'No tienes permiso para crear objetos DDL en este esquema.');
    end if;
END;
/
--
-- -----------------------------------------
-- III. Eventos de Base de Datos y Sistema
-- Se disparan por eventos relacionados con la gestión de sesiones o la instancia de la base de datos.
-- -----------------------------------------
-- Evento    |  Descripción
-- __________|______________________________
-- LOGON     |  Cuando un usuario se conecta.
-- LOGOFF    |  Cuando un usuario se desconecta.
-- STARTUP   |  Cuando la base de datos se inicia.
-- SHUTDOWN  |  Cuando la base de datos se apaga.
-- __________|______________________________
-- Ejemplo de Sistema (LOGON): Limitar el acceso por horario
CREATE OR REPLACE TRIGGER trg_limite_horario_login
-- Después de que un usuario se conecte a este esquema
AFTER LOGON ON SCHEMA
BEGIN
    -- Si la hora actual está fuera del horario laboral (ej. 8 AM a 5 PM)
    if TO_CHAR(SYSDATE, 'HH24') NOT BETWEEN '08' AND '17' then
        -- Desconectar al usuario inmediatamente
        RAISE_APPLICATION_ERROR(-20007, 'Acceso restringido fuera del horario laboral (8:00 AM - 5:00 PM).');
    end if;
END;
/
--
-- ----------------------------------------
--  HABILITAR Y DESHABILITAR UN TRIGGER
-- -----------------------------------------
ALTER TRIGGER trg_evitar_creacion_tablas ENABLE;
ALTER TRIGGER trg_evitar_creacion_tablas DISABLE;
-- ----------------------------------------
--  ELIMINAR UN TRIGGER
-- -----------------------------------------
DROP TRIGGER trg_log_delete_statement;
DROP TRIGGER trg_evitar_creacion_tablas;
DROP TRIGGER trg_auditoria_salario;
DROP TRIGGER tr_auto_id_regions;
--
/** ----------------------------------------
||  RANGO DE ERRORES EN ORACLE
|| -----------------------------------------
|| ____________________________________________________________________________________________________________
|| La distinción clave es quién genera el error: la Base de Datos (Oracle) o la Aplicación (Tú).
|| 
|| 1. Errores de la Base de Datos (Negativos y Positivos)
|| Estos son los errores estándar que lanza el motor de Oracle. Son siempre positivos en los manuales, 
|| pero se representan como negativos en el código PL/SQL.
|| 
||_____________________________________________________________________________________________________________
|| Rango de Error       |  Descripción         |  Ejemplo                     | Uso en Código
||______________________|______________________|______________________________|________________________________
|| -00001 a -00999      | Errores de sintaxis  | ORA-00904:                   | WHEN OTHERS THEN 
||                      | SQL.                 | Identificador no             | DBMS_OUTPUT.PUT_LINE(SQLERRM);
||                      |                      | válido (ya lo viste antes).  |
||                      |                      |                              | 
|| -01000 a -01999      | Errores de DML,      | ORA-01400: No se             | WHEN NO_DATA_FOUND THEN ...
||                      | integridad de        | puede insertar               |
||                      | datos y conexión     | NULL en columna requerida.   |
||                      |                      |                              | 
|| -02000 a -02999      | Errores de recursos  | ORA-02000:                   |
||                      | del sistema o de la  | Palabra clave o              |
||                      | sesión.              | identificador inválido.      | Se maneja con WHEN OTHERS.
||______________________|______________________|______________________________|________________________________
||
||
|| 2. Errores Personalizados de Aplicación (Negativos, Tu Rango)
|| Este es el rango que tú, como desarrollador, puedes utilizar para lanzar tus propias excepciones con mensajes descriptivos. Se generan usando la función RAISE_APPLICATION_ERROR.
||
|| Rango de Error       |  Descripción         |  Ejemplo                     
||______________________|______________________|_______________________________________________________________
|| -20000 a -20999      | Errores definidos    | RAISE_APPLICATION_ERROR
||                      | por el usuario.      | 
||______________________|______________________|_______________________________________________________________
*/
--
--
--
/** ----------------------------------------
||  CONTROLAR DE TIPOS DE EVEN EN LOS TRIGGER
|| -----------------------------------------
|| DESCRIPCIÓN:
|| Para controlar la ejecución de código PL/SQL basándose en tipos de eventos dentro de la base de datos, utilizamos principalmente 
|| Triggers (Disparadores) con las cláusulas WHEN y la detección explícita de eventos dentro de la lógica del trigger.
||
|| Existen dos mecanismos principales para lograr un control fino sobre los eventos:
||
|| 1. Controlar Múltiples Eventos DML en un Solo Trigger
|| Si un trigger se dispara por múltiples eventos DML (INSERT, UPDATE, DELETE), puedes controlar qué lógica se ejecuta usando
|| funciones booleanas que Oracle proporciona dentro del trigger (IF INSERTING, IF UPDATING, IF DELETING).
||
|| Ejemplo: Un Trigger para Crear, Actualizar y Eliminar
|| Este trigger a nivel de fila registra la acción específica realizada sobre la tabla REGIONS en una tabla de auditoría.
*/
--
CREATE OR REPLACE TRIGGER trg_regions_audit_log
-- Múltiples eventos
AFTER INSERT OR UPDATE OR DELETE ON regions
FOR EACH ROW
BEGIN
    if INSERTING then
        -- Controlar el evento de Inserción        
        :NEW.region_name := UPPER(NEW.region_name);
        insert into audit_log (user_name, action_type, table_name, action_time)
        values (USER, 'INSERT', 'REGIONS', SYSDATE);
        --
    elsif UPDATING then
        -- Controlar el evento de Actualización        
        :NEW.region_name := UPPER(NEW.region_name);
        insert into audit_log (user_name, action_type, table_name, action_time)
        values (USER, 'UPDATE', 'REGIONS', SYSDATE);
        --
    elsif DELETING then
        -- Controlar el evento de Borrado
        insert into audit_log (user_name, action_type, table_name, action_time)
        values (USER, 'DELETE', 'REGIONS', SYSDATE);
        --
    end if;
END;
/
-- TEST TRIGGER
BEGIN
    insert into regions (region_id, region_name) 
    values (101, 'Sur America2');
    COMMIT;
    --
    update regions
    set region_name = 'Sur America3'
    where region_id = 101;
    COMMIT;
    --
    delete from regions
    where region_id = 101;
    COMMIT;
END;
/
--
-- ----------------------------------------
-- 2. Controlar Eventos DML para Columnas Específicas
--
-- Puedes refinar aún más el control en los eventos de UPDATE para que la lógica se ejecute solo si una columna en particular fue afectada.
-- 
-- Ejemplo: Controlar por Columna 
-- Se utiliza la cláusula OF column_name en la declaración y la función UPDATING ('column_name') dentro del cuerpo.
-- ----------------------------------------
--
CREATE OR REPLACE TRIGGER trg_salario_log
AFTER UPDATE OF salary, commission_pct ON employees
FOR EACH ROW
BEGIN
    -- Ejecuta la lógica solo si la columna SALARY realmente fue modificada en esta sentencia
    if UPDATING('salary') then
        -- Registra el cambio
        insert into audit_log (user_name, action_type, table_name, action_time)
        values (USER, 'UPDATE DE salary para el empleado ' || :OLD.employee_id, 'REGIONS', SYSDATE);
        DBMS_OUTPUT.PUT_LINE('Se detectó un cambio de salario para el empleado ' || :OLD.employee_id);
    end if;
    --
    if UPDATING('commission_pct') then
        -- Registra el cambio
        insert into audit_log (user_name, action_type, table_name, action_time)
        values (USER, 'UPDATE DE commission_pct para el empleado ' || :OLD.employee_id, 'REGIONS', SYSDATE);
        DBMS_OUTPUT.PUT_LINE('Se detectó un cambio de commission_pct para el empleado ' || :OLD.employee_id);
    end if;
END;
/
-- TEST TRIGGER
BEGIN
    update employees
    set salary = 11000, commission_pct = 0.1
    where region_id = 101;
    where employee_id = 100;
    COMMIT;
END;
/
--
-- ----------------------------------------
-- 3. Cláusula Condicional WHEN
--
-- La cláusula WHEN permite establecer una condición previa que debe ser verdadera para que el trigger se ejecute. 
-- Esto proporciona un control de eventos muy eficiente antes de que comience el bloque BEGIN.
-- 
-- Ejemplo: Ejecutar solo para Ciertos Valores
-- ----------------------------------------
--
CREATE OR REPLACE TRIGGER trg_control_dept_90
BEFORE INSERT OR UPDATE ON employees
FOR EACH ROW
-- Cláusula WHEN: el trigger solo se dispara si el departamento NO es 90
WHEN (NEW.department_id != 90)
BEGIN
    DBMS_OUTPUT.PUT_LINE('Esta lógica solo se ejecuta para empleados de otros departamentos');
    DBMS_OUTPUT.PUT_LINE('Los empleados del departamento 90 son ignorados por el trigger');
END;
/
--
/** ----------------------------------------
||  COMPROBAR E ESTADO DE LOS TRIGGER
|| -----------------------------------------
|| DESCRIPCIÓN:
|| Para comprobar el estado (habilitado o deshabilitado) de los triggers en Oracle, puedes consultar las vistas del diccionario de datos
||
|| 1. Comprobar el Estado de Todos los Triggers del Esquema Actual
|| Usa la vista USER_TRIGGERS para ver el estado de los triggers que posees en tu esquema:
*/
BEGIN
   for r_trigger in (
        select 
            trigger_name,
            trigger_type,   -- AFTER, BEFORE
            triggering_event, -- INSERT, UPDATE, DELETE
            status          -- Muestra 'ENABLED' o 'DISABLED'
        from user_triggers
        order by trigger_name
    )
    loop
        -- Usar r_trigger.column_name para acceder a los datos de cada fila
        DBMS_OUTPUT.PUT_LINE('Trigger: ' || r_trigger.trigger_name || 
                             ' | Tipo: ' || r_trigger.trigger_type || 
                             ' | Evento: ' || r_trigger.triggering_event || 
                             ' | Estado: ' || r_trigger.status);
    end loop;
END;
/
--
-- ----------------------------------------
-- 2. Comprobar el Estado de los Triggers en una Tabla Específica
--
-- Si quieres verificar solo los triggers asociados a una tabla, por ejemplo, EMPLOYEES:
-- ----------------------------------------
--
    where region_id = 101;
BEGIN
   for r_trigger in (
        select 
            trigger_name,
            status          -- Muestra 'ENABLED' o 'DISABLED'
        from user_triggers
        where table_name = 'EMPLOYEES'
        order by trigger_name
   )
   loop
        -- Usar r_trigger.column_name para acceder a los datos de cada fila
        DBMS_OUTPUT.PUT_LINE('Trigger: ' || r_trigger.trigger_name ||  
                             ' | Estado: ' || r_trigger.status);
   end loop;
END;
    where region_id = 101;
/
--
-- ----------------------------------------
-- 3. Comprobar el Estado de Triggers en Toda la Base de Datos (Requiere Privilegios de DBA)
--
-- Si tienes privilegios de administrador, puedes usar la vista ALL_TRIGGERS o DBA_TRIGGERS para ver triggers en otros esquemas.
-- ----------------------------------------
--
BEGIN
   for r_trigger in (
        select
            owner,          -- Propietario del trigger
            trigger_name,
            table_name,
            status
        from
            all_triggers
        where
            table_name = 'REGIONS' and owner = 'HR' -- Reemplaza con el nombre de esquema y tabla deseado
   )
   loop
        -- Usar r_trigger.column_name para acceder a los datos de cada fila
        DBMS_OUTPUT.PUT_LINE('Trigger: ' || r_trigger.owner ||
                             ' | Nombre:.' || r_trigger.trigger_name || 
                             ' | Tabla: ' || r_trigger.table_name ||
                             ' | Estado: ' || r_trigger.status);
   end loop;
END;
/
--
/** ----------------------------------------
||  ORIENTADO A OBJECTOS PLSQL
|| -----------------------------------------
|| DESCRIPCIÓN:
|| Oracle PL/SQL soporta programación Orientada a Objetos (OO) a través de Tipos de Objeto de Esquema (Schema Object Types). 
|| Esto permite modelar entidades del mundo real, definir estructuras de datos complejas y encapsular lógica (métodos) directamente en el esquema de la base de datos.
||
|| Conceptos Clave de OO en Oracle PL/SQL
|| Los Tipos de Objeto de Esquema son los bloques de construcción para la orientación a objetos en Oracle y cumplen con los cuatro pilares principales de la OO:
||
|| 1. Encapsulamiento (Defining the Structure)
|| Un Tipo de Objeto combina datos y la lógica (métodos) que opera sobre esos datos en una sola unidad.
|| * Definición: Se crea usando CREATE TYPE. Contiene los atributos (datos) y la Especificación del Cuerpo (cabeceras de métodos).
|| 
|| Ejemplo: Para aplicar la OO, definiremos un objeto para representar un Empleado. Usaremos atributos de las 
||          tablas de employees, departments y jobs para construir Tipos de Objeto relacionados.
|| ----------------------------------------
*/
-- A. Tipo de Objeto: T_JOB (Estructura Simple)
-- Representa la información del puesto de trabajo, tomada de la tabla JOBS.
CREATE OR REPLACE TYPE T_JOB AS OBJECT (
    job_id      VARCHAR2(10),
    job_title   VARCHAR2(35),
    --
    -- Constructor (Método que crea el objeto)
    -- Este constructor existe sin que lo escribas
    -- Si definiste un constructor explícito para T_JOB, debes compilar el cuerpo
    CONSTRUCTOR FUNCTION T_JOB (
        p_job_id      VARCHAR2,
        p_job_title   VARCHAR2
    ) RETURN SELF AS RESULT
);
/
--
-- TYPE BODY T_JOB 
-- Si definiste un constructor explícito para T_JOB, debes compilar el cuerpo:
CREATE OR REPLACE TYPE BODY T_JOB AS
    --
    CONSTRUCTOR FUNCTION T_JOB (
        p_job_id    VARCHAR2,
        p_job_title VARCHAR2
    ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_id     := p_job_id;
        SELF.job_title  := p_job_title;
        RETURN;
    END T_JOB;
END T_JOB;
/
--
--
-- B. Tipo de Objeto: T_DEPARTAMENTO (Estructura Simple)
-- Representa la información del departamento, tomada de la tabla DEPARTMENTS.
CREATE OR REPLACE TYPE T_DEPARTAMENTO AS OBJECT (
    department_id   NUMBER(4),
    department_name VARCHAR2(30),
    --
    -- Constructor (Método que crea el objeto)
    -- Este constructor existe sin que lo escribas
    -- Si definiste un constructor explícito para T_DEPARTAMENTO, debes compilar el cuerpo
    CONSTRUCTOR FUNCTION T_DEPARTAMENTO (
        p_department_id   NUMBER,
        p_department_name VARCHAR2
    ) RETURN SELF AS RESULT
);
/
-- TYPE BODY T_DEPARTAMENTO 
-- Si definiste un constructor explícito para T_DEPARTAMENTO, debes compilar el cuerpo:
CREATE OR REPLACE TYPE BODY T_DEPARTAMENTO AS
    --
    CONSTRUCTOR FUNCTION T_DEPARTAMENTO(
        p_department_id   NUMBER,
        p_department_name VARCHAR2
    ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.department_id   := p_department_id;
        SELF.department_name := p_department_name;
        RETURN;
    END T_DEPARTAMENTO;
END T_DEPARTAMENTO;
/
--
-- C. Tipo de Objeto: T_EMPLEADO (Objeto con Métodos)
-- Este es el objeto principal. Utiliza los tipos T_JOB y T_DEPARTAMENTO como atributos, demostrando la composición de objetos. 
-- Además, encapsulamos lógica de negocio (Métodos).
CREATE OR REPLACE TYPE T_EMPLEADO AS OBJECT (
    -- Atributos básicos de EMPLOYEES
    employee_id     VARCHAR2(10),
    first_name      VARCHAR2(20),
    last_name       VARCHAR2(25),
    salary          NUMBER(6),
    --
    -- Atributos que son otros objetos (Composición)
    puesto      T_JOB,
    ubicacion   T_DEPARTAMENTO,
    --
    -- Constructor (Método que crea el objeto)
    CONSTRUCTOR FUNCTION T_EMPLEADO(p_id NUMBER)
        RETURN SELF AS RESULT,
    --
    -- Método que calcula el salario anual
    MEMBER FUNCTION fn_salario_anual RETURN NUMBER,
    --
    -- Método que muestra los datos del empleado
    MEMBER PROCEDURE pr_mostrar_info,
    --
    -- Metodo Static
    STATIC PROCEDURE pr_auditoria_log(p_employee_id NUMBER)
) NOT FINAL;
/
--
-- 2. mplementación de Métodos y Lógica
-- La lógica para los métodos declarados en la Especificación (fn_salario_anual, pr_mostrar_info y el CONSTRUCTOR) se define en el Cuerpo del Tipo.
-- Cuerpo del Tipo de Objeto: T_EMPLEADO
CREATE OR REPLACE TYPE BODY T_EMPLEADO AS
    --
    -- 2.1. CONSTRUCTOR
    -- Inicializa un objeto T_EMPLEADO buscando los datos por ID
    CONSTRUCTOR FUNCTION T_EMPLEADO(p_id NUMBER)
        RETURN SELF AS RESULT
    IS
        -- Variables intermedias para la consulta y creación de objetos anidados
        v_employee_id   employees.employee_id%TYPE;
        v_first_name    employees.first_name%TYPE;
        v_last_name     employees.last_name%TYPE;
        v_salary        employees.salary%TYPE;
        v_job_id        jobs.job_id%TYPE;
        v_job_title     jobs.job_title%TYPE;
        v_dept_id       departments.department_id%TYPE;
        v_dept_name     departments.department_name%TYPE;
    BEGIN
        -- 1. Buscar todos los datos necesarios en una sola SELECT
        -- Usamos SELF para referirnos a la instancia del objeto que se está creando
        select 
            e.employee_id, e.first_name, e.last_name, e.salary,
            j.job_id, j.job_title,
            d.department_id, d.department_name
        into
            v_employee_id, v_first_name, v_last_name, v_salary,
            --SELF.employee_id, SELF.first_name, SELF.last_name, SELF.salary, -- -- Asignar directamente a SELF o a variables
            v_job_id, v_job_title,
            v_dept_id, v_dept_name
        from employees e, jobs j, departments d
        where e.employee_id = p_id
            and e.department_id = d.department_id
            and e.job_id = j.job_id;
        --
        -- 2. Asignar atributos directos
        SELF.employee_id    := v_employee_id;
        SELF.first_name     := v_first_name;
        SELF.last_name      := v_last_name;
        SELF.salary         := v_salary;
        --
        -- 3. Crear las instancias de objetos anidados usando PL/SQL
        SELF.puesto     := T_JOB(v_job_id, v_job_title);
        SELF.ubicacion  := T_DEPARTAMENTO(v_dept_id, v_dept_name);
        --
        return;
    END T_EMPLEADO;
    --
    -- 2.2. MÉTODO: Cálculo del Salario Anual
    MEMBER FUNCTION fn_salario_anual RETURN NUMBER
    IS
    BEGIN
        -- La lógica usa el atributo de la instancia (SELF.salary)
        return SELF.salary * 12;
    END fn_salario_anual;
    --
    --- 2.3. MÉTODO: Mostrar Información
    MEMBER PROCEDURE pr_mostrar_info
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('------------------------------------');
        DBMS_OUTPUT.PUT_LINE('ID Empleado: ' || SELF.employee_id);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || SELF.first_name || ' ' || SELF.last_name);
        DBMS_OUTPUT.PUT_LINE('Salario Mensual: ' || TO_CHAR(SELF.salary, '$99,999.00'));
        --
        -- Acceder a los atributos del objeto compuesto (puesto y ubicacion)
        DBMS_OUTPUT.PUT_LINE('Puesto: ' || SELF.puesto.job_title);
        DBMS_OUTPUT.PUT_LINE('Departamento: ' || SELF.ubicacion.department_name);
        DBMS_OUTPUT.PUT_LINE('Salario Anual Calculado: ' || TO_CHAR(SELF.fn_salario_anual, '$999,999.00'));
        DBMS_OUTPUT.PUT_LINE('------------------------------------');
    END pr_mostrar_info;
    --
    -- Método Statico
    STATIC PROCEDURE pr_auditoria_log(p_employee_id NUMBER) 
    IS 
    BEGIN
        insert into audit_log (user_name, action_type, table_name, action_time)
        values (USER, 'SELECT DATA EMPLOYEE ID ' || p_employee_id, 'EMPLOYEES', SYSDATE);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Se detectó y audito una busqueda del empleado con ID ' || p_employee_id);
    END pr_auditoria_log;
    --
END T_EMPLEADO;
/
-- 
--3. Uso del Objeto en PL/SQL
SET SERVEROUT ON;
DECLARE
    -- Declarar una variable cuyo tipo de dato es nuestro Tipo de Objeto
    v_empleado      T_EMPLEADO; 
    v_employee_id   NUMBER := 100;
BEGIN
    -- 1. Instanciar el objeto usando el Constructor
    -- Asumimos que el empleado 100 existe
    v_empleado := T_EMPLEADO(v_employee_id); 
    --
    -- 2. Llamar al método del objeto (lógica encapsulada)
    v_empleado.pr_mostrar_info();
    --
    -- 3. Acceder a los atributos directamente
    DBMS_OUTPUT.PUT_LINE('Verificación rápida del puesto: ' || v_empleado.puesto.job_title);
    --
    -- 4. Llamar a la función
    DBMS_OUTPUT.PUT_LINE('El salario anual por fuera es: ' || TO_CHAR(v_empleado.fn_salario_anual, '$999,999.00'));
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    --
   -- 5. Llamar al procedimineto static
    T_EMPLEADO.pr_auditoria_log(v_employee_id);
END;
/
--
/** ----------------------------------------
||  HERENCIA DE TIPOS DE OBJETO PLSQL
|| -----------------------------------------
|| DESCRIPCIÓN:
|| La herencia en la Programación Orientada a Objetos (OO) en Oracle PL/SQL se implementa mediante 
|| los Tipos de Objeto de Esquema (Schema Object Types) utilizando las cláusulas UNDER y NOT FINAL.
||  Permite crear una jerarquía de tipos, donde un subtipo hereda las características (atributos y métodos) de un supertipo.
|| 
|| 1. Conceptos Clave de la Herencia en PL/SQL
||
|| A. Supertipo (Tipo Padre)
|| Es la base de la jerarquía. Para que un tipo pueda ser heredado, debe ser definido como NOT FINAL (por defecto).
||
|| B. Subtipo (Tipo Hijo)
|| Es el tipo que hereda. Utiliza la cláusula UNDER Supertype_Name y adquiere automáticamente todos los atributos y
|| métodos del supertipo. Puede añadir nuevos atributos o sobrescribir (OVERRIDING) métodos heredados (polimorfismo).
||
||_________________________|______________________________________________________________________
|| Cláusula                |  Propósito
||_________________________|______________________________________________________________________
|| FINAL / NOT FINAL       |  Controla si el tipo puede ser heredado. FINAL (por defecto) 
||                         |  significa que no puede tener subtipos. NOT FINAL permite la herencia.
||                         |  
|| INSTANTIABLE /          |  Controla si se pueden crear instancias directas del tipo. 
|| NOT INSTANTIABLE        |  NOT INSTANTIABLE convierte el tipo en abstracto (como una interfaz o una clase abstracta).
||_________________________|______________________________________________________________________
||
||
|| 2. Ejemplo de Herencia Basado en T_EMPLEADO_HERENCIA
|| Tomaremos tu objeto T_EMPLEADO como base y crearemos un subtipo para un gerente.
||
|| Paso 1: Definir el Supertipo (T_EMPLEADO_HERENCIA)
|| Para permitir la herencia, debemos asegurarnos de que el tipo no sea FINAL (en este ejemplo, lo declararemos explícitamente 
|| para mayor claridad, aunque suele ser el predeterminado si no se especifica).
|| 
|| CREATE OR REPLACE TYPE T_EMPLEADO_HERENCIA AS OBJECT (
||     employee_id     NUMBER(6),
||     first_name      VARCHAR2(20),
||     last_name       VARCHAR2(25),
||     salary          NUMBER(6),
||     puesto          T_JOB,
||     ubicacion       T_DEPARTAMENTO,
|| ) NOT FINAL; -- <<-- CLÁUSULA CLAVE PARA PERMITIR HERENCIA
|| /
*/

--
-- Paso 2: Crear el Subtipo (T_GERENTE)
-- El gerente es un empleado, pero tiene un atributo adicional (bonus) y un método de salario anual diferente.
CREATE OR REPLACE TYPE T_GERENTE UNDER T_EMPLEADO (
    -- Atributo nuevo, solo para gerentes
    bonus NUMBER(8,2),
    --
    --
    CONSTRUCTOR FUNCTION T_GERENTE(p_id NUMBER, p_bonus NUMBER)
        RETURN SELF AS RESULT,
    --
    -- Sobreescribimos el método heredado para incluir el bono
    OVERRIDING MEMBER FUNCTION fn_salario_anual RETURN NUMBER
    -- Resultado: T_GERENTE hereda employee_id, first_name, salary, etc., y añade bonus.
);
/
--
-- Paso 3: Implementar el Polimorfismo (Cuerpo del Subtipo)
-- Ahora definimos el cuerpo para el gerente, sobrescribiendo la función de salario.
CREATE OR REPLACE TYPE BODY T_GERENTE AS
    --
    CONSTRUCTOR FUNCTION T_GERENTE(p_id NUMBER, p_bonus NUMBER)
        RETURN SELF AS RESULT
    IS
        v_empleado T_EMPLEADO;
    BEGIN
        -- 1. Crear el objeto padre (llama al constructor de T_EMPLEADO)
        v_empleado := T_EMPLEADO(p_id); 
        --
        -- 2. Copiar los atributos del padre al hijo (SELF)
        SELF := TREAT(v_empleado AS T_GERENTE);
        --
        -- 3. Asignar el atributo propio del subtipo
        SELF.bonus := p_bonus;
        --
        return;
    END T_GERENTE;
    --
    -- Sobrescribimos la función heredada
    OVERRIDING MEMBER FUNCTION fn_salario_anual RETURN NUMBER
    IS
        v_salario_empleado NUMBER;
    BEGIN
        -- Llamada al método del supertipo (empleado) para obtener el salario base.
        -- Se usa SELF.fn_salario_anual para acceder al método del SUPERTYPE (T_EMPLEADO)
        -- Si fn_salario_anual fuera un método final en el supertipo, no se podría sobrescribir.
        v_salario_empleado := (SELF AS T_EMPLEADO).fn_salario_anual();
        --
        -- Añadir el bono al cálculo
        return v_salario_empleado + SELF.bonus;
    END fn_salario_anual;
    --
    -- El resto de los métodos y el constructor (si es necesario) también deben definirse.
    -- Si el constructor no se define explícitamente, se hereda.
END T_GERENTE;
/
--
-- 3. Uso y Polimorfismo en la Práctica
-- El valor real de la herencia y el polimorfismo se ve cuando utilizas una variable del supertipo (T_EMPLEADO)
-- para referenciar un objeto del subtipo (T_GERENTE).
DECLARE
    -- Variable del Supertipo (para probar polimorfismo)
    v_persona T_EMPLEADO; 
    --
    -- Variables para almacenar valores esperados
    v_salario_base    NUMBER := 60000;
    v_bonus           NUMBER := 10000;
    v_id_empleado     CONSTANT NUMBER := 100; -- Asegúrate de que este ID exista en EMPLOYEES
    v_id_gerente      CONSTANT NUMBER := 101; -- Asegúrate de que este ID exista en EMPLOYEES (usado para la instancia del gerente)
    --
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- INICIO DEL TEST DE OBJETOS OO ---');
    --
    --------------------------------------------------
    -- TEST 1: EMPLEADO REGULAR (Composición y Método Base)
    --------------------------------------------------
    --
    -- Instanciar T_EMPLEADO (llama al constructor que consulta las 3 tablas)
    v_persona := T_EMPLEADO(v_id_empleado);
    --
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '>> TEST 1: EMPLEADO REGULAR (' || v_id_empleado || ')');
    --
    -- 1.1. Prueba de Composición (Acceso a atributos anidados)
    IF v_persona.puesto.job_title IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('   [OK] Composición: Puesto de trabajo encontrado: ' || v_persona.puesto.job_title);
    ELSE
        DBMS_OUTPUT.PUT_LINE('   [FALLO] Composición: Puesto de trabajo es NULL. Constructor fallido.');
    END IF;
    --
    -- 1.2. Prueba de Método Miembro (Lógica Base)
    -- El salario anual esperado es: v_persona.salary * 12
    DBMS_OUTPUT.PUT_LINE('   Salario Anual (Base): ' || v_persona.fn_salario_anual);
    v_persona.pr_mostrar_info();
    --
    --
    --------------------------------------------------
    -- TEST 2: GERENTE (Herencia y Polimorfismo)
    --------------------------------------------------
    --
    -- Asignamos un nuevo objeto a la misma variable del supertipo (v_persona).
    -- NOTA: T_GERENTE debería usar un constructor que acepte el ID y el BONUS.
    -- (Asumiendo que el constructor de T_GERENTE llama internamente al constructor de T_EMPLEADO y luego asigna el bono).
    -- Para este ejemplo, simplificaremos creando un T_EMPLEADO y luego haciendo CAST.
    --
    -- Crear una instancia de T_GERENTE (necesitas un constructor explícito para Gerente)
    -- Si tu constructor de T_GERENTE acepta (ID, BONUS): v_persona := T_GERENTE(v_id_gerente, v_bonus);
    --
    -- SIMULACIÓN con CAST (Si T_GERENTE no tiene un constructor completo):
    --
    -- 1. Instanciar empleado base
    v_persona := T_EMPLEADO(v_id_gerente); 
    --
    -- 2. Convertir y asignar el bono.
    -- La instancia debe ser del tipo T_GERENTE para asignar el 'bonus'.
    -- Asumiremos que el empleado 101 es un gerente y le damos un bono:
    v_persona := T_GERENTE(v_persona.employee_id, v_persona.first_name, v_persona.last_name, v_persona.salary, v_persona.puesto, v_persona.ubicacion, v_bonus);
    --
    -- La forma más limpia si T_GERENTE tiene su propio constructor (asumiendo que acepta todos los datos de T_EMPLEADO + bonus):
    -- v_persona := T_GERENTE(v_id_gerente); -- LLamada al constructor de T_GERENTE (que internamente llama al de T_EMPLEADO y asigna un bonus)
    --
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '>> TEST 2: GERENTE (Polimorfismo)');
    --
    -- 2.1. Prueba de Polimorfismo (Llamada al método sobrescrito)
    -- El mismo método fn_salario_anual ahora debe incluir el bono.
    DBMS_OUTPUT.PUT_LINE('   Salario Anual (Gerente - Polimórfico): ' || v_persona.fn_salario_anual);
    --
    -- 2.2. Uso del método del Supertipo (pr_mostrar_info)
    -- El gerente usa el procedimiento del empleado base, pero el cálculo del salario será el sobrescrito.
    v_persona.pr_mostrar_info(); 
    --
    --------------------------------------------------
    -- TEST 3: Método Estático (Auditoría)
    --------------------------------------------------
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '>> TEST 3: MÉTODO ESTÁTICO');
    --
    -- Los métodos estáticos se invocan directamente desde el Tipo, no desde la instancia.
    T_EMPLEADO.pr_auditoria_log(v_id_empleado); 
    --
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- FIN DEL TEST ---');
    --
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: No se encontró el empleado con ID ' || v_id_empleado || ' o ' || v_id_gerente || '. Asegúrate de que existan en la tabla EMPLOYEES.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR INESPERADO: ' || SQLERRM);
END;
/
/** ----------------------------------------
||  JSON EN ORACLE versión 12c R2
|| -----------------------------------------
|| DESCRIPCIÓN:
|| El soporte para JSON en Oracle Database es muy completo y se ha mejorado significativamente desde 
|| la versión 12c R2, permitiendo almacenar, consultar, indexar y manipular datos JSON de forma nativa 
|| dentro de columnas de tipo VARCHAR2, CLOB o BLOB.
||
|| 1.Almacenamiento y Validación
||   No existe un tipo de dato JSON dedicado en Oracle (como en PostgreSQL o MySQL). En su lugar, 
||   se utilizan tipos estándar con una restricción de validación:
||
||   Almacenamiento: Los documentos JSON se almacenan comúnmente en columnas de tipo VARCHAR2 
||   (para documentos pequeños), CLOB (para documentos grandes, hasta 4 GB) o BLOB.
||
||   Validación: Para asegurar que el contenido de la columna es un JSON válido, se utiliza una 
||   restricción de verificación (CHECK constraint):
*/
--
CREATE TABLE my_data_oracle_12cR2(
    id NUMBER,
    data_json VARCHAR2(4000)
        CONSTRAINT check_json CHECK(data_json IS JSON) -- << Esta es la clave
);
--
BEGIN
   INSERT INTO my_data_oracle_12cR2 (id, data_json) VALUES (
        1,
        '{
            "recipe_name": "Bandeja Paisa",
            "servings": 2,
            "ingredients": [
                {"item": "Arroz", "qty": 200, "unit": "g"},
                {"item": "Frijoles", "qty": 300, "unit": "g"},
                {"item": "Carne Molida", "qty": 250, "unit": "g"},
                {"item": "Huevo", "qty": 2, "unit": "unidades"}
            ],
            "steps_count": 8
        }'
    );
    --
    INSERT INTO my_data_oracle_12cR2 (id, data_json) VALUES (
        2,
        '{
            "recipe_name": "Sancocho de Gallina",
            "servings": 6,
            "ingredients": [
                {"item": "Gallina", "qty": 1, "unit": "entera"},
                {"item": "Yuca", "qty": 400, "unit": "g"},
                {"item": "Plátano Verde", "qty": 2, "unit": "unidades"},
                {"item": "Mazorca", "qty": 3, "unit": "unidades"}
            ],
            "steps_count": 6
        }'
    );
    --
    INSERT INTO my_data_oracle_12cR2 (id, data_json) VALUES (
        3,
        '{
            "recipe_name": "Arepas de Queso",
            "servings": 4,
            "ingredients": [
                {"item": "Harina de Maíz", "qty": 500, "unit": "g"},
                {"item": "Queso Campesino", "qty": 200, "unit": "g"},
                {"item": "Mantequilla", "qty": 50, "unit": "g"},
                {"item": "Leche", "qty": 250, "unit": "ml"}
            ],
            "steps_count": 4
        }'
    );
    --
    INSERT INTO my_data_oracle_12cR2 (id, data_json) VALUES (
        4,
        '{
            "recipe_name": "Lechona Tolimense",
            "servings": 10,
            "ingredients": [
                {"item": "Cerdo", "qty": 5, "unit": "kg"},
                {"item": "Arveja", "qty": 1000, "unit": "g"},
                {"item": "Arroz", "qty": 500, "unit": "g"},
                {"item": "Cebolla", "qty": 4, "unit": "unidades"}
            ],
            "steps_count": 12
        }'
    );
    --
    INSERT INTO my_data_oracle_12cR2 (id, data_json) VALUES (
        5,
        '{
            "recipe_name": "Postre de Natas",
            "servings": 6,
            "ingredients": [
                {"item": "Leche", "qty": 1000, "unit": "ml"},
                {"item": "Azúcar", "qty": 300, "unit": "g"},
                {"item": "Huevos", "qty": 6, "unit": "unidades"},
                {"item": "Canela", "qty": 1, "unit": "rama"}
            ],
            "steps_count": 5
        }'
    );
    COMMIT;
END;
--
--------------------------------------------------
-- 2. Consultas JSON (SQL/JSON Functions)
--    Oracle ofrece funciones SQL/JSON estándar para consultar y extraer datos 
--    de documentos JSON sin necesidad de convertir el texto a objetos PL/SQL.
--
--  A. Extracción de Valores (JSON_VALUE)
--     Se utiliza para extraer un valor escalar (número, cadena, booleano) de un documento.
--------------------------------------------------
--
-- Extraer el nombre del cliente de un documento JSON
SELECT JSON_VALUE(data_json, '$.recipe_name') AS colombian_dish
FROM my_data_oracle_12cR2
WHERE JSON_VALUE(data_json, '$.servings') = 6;
--
--------------------------------------------------
-- B. Consulta de Documentos (JSON_QUERY)
--   Se utiliza para extraer un fragmento del JSON (un objeto o un array).
--------------------------------------------------
-- Extraer el array completo de ítems del pedido
SELECT JSON_QUERY(data_json, '$.ingredients') AS order_items_array
FROM my_data_oracle_12cR2
WHERE id = 5;
--
--------------------------------------------------
-- C. Consulta Avanzada y Tablas Virtuales (JSON_TABLE)
--   JSON_TABLE es la función más potente. Permite transformar arrays o estructuras 
--   complejas dentro del JSON en filas y columnas relacionales temporales (una tabla virtual), facilitando las uniones y el procesamiento masivo.
--------------------------------------------------
--
-- Convertir el array de ítems en filas relacionales
SELECT 
    jt.item,
    jt.qty,
    jt.unit
FROM my_data_oracle_12cR2 d,
    JSON_TABLE(
        d.data_json, '$.ingredients[*]'
        COLUMNS(
            item VARCHAR2(100) PATH '$.item',
            qty  NUMBER PATH '$.qty',
            unit VARCHAR2(50) PATH '$.unit'
        )
    ) AS jt
WHERE id = 5;
--
--
--------------------------------------------------
-- 3. Manipulación (Creación y Modificación)
--   Oracle proporciona funciones para construir nuevos documentos JSON y modificar documentos existentes
--
--  A. Creación (JSON_OBJECT, JSON_ARRAY)
--    Estas funciones construyen JSON a partir de datos relacionales:
--------------------------------------------------
--
-- Crear un objeto JSON a partir de datos relacionales
SELECT 
    JSON_OBJECT(
        'id'        : employee_id,
        'full_name' : first_name || ' ' || last_name,
        'salary'    : salary,
        'email'     : email,
        'job_id'    : job_id
    ) AS json_employee
FROM employees
WHERE employee_id = 100;
--
--------------------------------------------------
-- B. Modificación (JSON_MERGEPATCH, JSON_TRANSFORM)
--    JSON_MERGEPATCH: Aplica un "parche" JSON para actualizar, insertar o eliminar valores. Es simple para cambios directos.
--
--  JSON_TRANSFORM (Recomendado): Permite realizar múltiples operaciones de inserción, actualización y eliminación de forma segura.
--------------------------------------------------
--
UPDATE my_data_oracle_12cR2
SET data_json = JSON_TRANSFORM(
    data_json,
    SET '$.recipe_name' = 'Postre de Natas2',   -- Modificar valor existente
    INSERT '$.audit_date' = SYSDATE   -- Insertar nuevo campo
)
WHERE id = 5;
--
--
SELECT JSON_VALUE(data_json, '$.recipe_name') AS colombian_dish,
       JSON_VALUE(data_json, '$.audit_date') AS new_campo 
FROM my_data_oracle_12cR2
WHERE JSON_VALUE(data_json, '$.servings') = 6;
--
/** ----------------------------------------
||  JSON EN ORACLE versión 21c y posteriores
|| -----------------------------------------
|| DESCRIPCIÓN:
|| Oracle ha añadido un tipo de dato dedicado para JSON en sus versiones más recientes. 
|| Sin embargo, su soporte para JSON ha evolucionado a lo largo de varias versiones.
||
|| El soporte nativo recomendado es el tipo de dato JSON, que debutó en Oracle Database 
|| 21c (aunque parte de la funcionalidad binaria estaba disponible experimentalmente en versiones anteriores).
||
|| === Evolución del Almacenamiento JSON en Oracle ===
||
||_____________________|___________________________|____________________________________________________________
|| Versión             |  Tipo de Almacenamiento   |  Característica Clave
||                     |  Principal                |
||_____________________|___________________________|_____________________________________________________________
|| 12c R2              |  VARCHAR2, CLOB, o BLOB   |  JSON se almacena como texto. La validación se f
|| (y anteriores)      |                           |  uerza mediante la restricción CHECK (columna IS JSON).
||_____________________|___________________________|_____________________________________________________________
||                     |                           |
|| Oracle Database 21c |  JSON (Tipo de Dato SQL)  | Almacenamiento en formato binario optimizado llamado
|| y Posteriores       |                           | OSON (Oracle's Optimized JSON format). Esto evita el 
||                     |                           | costoso parsing repetido y mejora el rendimiento.
||_____________________|___________________________|_____________________________________________________________
*/
--
CREATE TABLE my_orders(
    order_id    NUMBER,
    order_data  JSON-- << Tipo de dato nativo JSON
);
--
-- ----------------------------------------
-- VENTAJAS DE USAR EL TIPO JSON:
--
-- 1. Rendimiento: 
--    - Utiliza el formato binario OSON, diseñado para una consulta y actualización más rápidas.
--
-- 2. Garantía de Validez:
--    - El dato siempre está garantizado como JSON bien formado (no se necesita una restricción CHECK explícita).
--
-- 3. Transparencia:
--    - Internamente, Oracle maneja la complejidad, permitiéndote usar las funciones SQL/JSON 
--      (JSON_VALUE, JSON_TABLE, etc.) de la misma manera que antes, pero con mayor eficiencia.
--
-- SOPORTE UNIVERSAL (FUNCIONALIDADES SQL/JSON):
--
-- Independientemente de si usas JSON, VARCHAR2 o CLOB para el almacenamiento, las funcionalidades 
-- de Oracle para manejar datos JSON son universales y se basan en las funciones SQL/JSON:
--
-- 1. Consulta:
--    - Usa el operador de punto (.) o JSON_VALUE para extraer valores escalares.
--    - Usa JSON_QUERY para extraer fragmentos de objeto o array.
--
-- 2. Filtrado:
--    - Usa JSON_EXISTS para verificar la existencia de un nodo.
--
-- 3. Conversión:
--    - Usa JSON_TABLE para "aplanar" estructuras JSON complejas (especialmente arrays) 
--      en filas y columnas relacionales temporales.
--
-- 4. Modificación:
--    - Usa JSON_TRANSFORM para realizar inserciones, actualizaciones y eliminaciones 
--      seguras dentro del documento.
--
-- NOTA: En Oracle 12c R2, aunque no existe el tipo de dato JSON nativo, todas las funciones
-- SQL/JSON están disponibles y son completamente funcionales con tipos VARCHAR2 y CLOB.
--
-- Ejemplo de creación de tabla en 12c R2:
--   CREATE TABLE mi_tabla_json (
--       id NUMBER PRIMARY KEY,
--       datos_json CLOB CHECK (datos_json IS JSON)
--   );
-- ---------------------------------------- 
--
--
--
/** ----------------------------------------
||  OBJETOS JSON, Constructores y Metodos
|| -----------------------------------------
|| DESCRIPCIÓN:
|| Aunque Oracle maneja JSON principalmente a través de funciones SQL/JSON, puedes encapsular la manipulación 
|| de JSON dentro de tus Tipos de Objeto de PL/SQL usando métodos y constructores.
||
|| Aquí te muestro cómo fusionar ambos conceptos.
||
|| 1. Modelado del Objeto (T_JSON_HANDLER)
||    Definiremos un Tipo de Objeto que encapsula un documento JSON y proporciona métodos para interactuar con él.
*/
--
CREATE OR REPLACE TYPE T_JSON_HANDLER AS OBJECT(
    -- Atributo que almacena el documento JSON
    json_data CLOB,
    --
    -- Constructor para inicializar el objecto
    CONSTRUCTOR FUNCTION T_JSON_HANDLER(p_json_string IN CLOB)
        RETURN SELF AS RESULT,
    --
    -- Metodo para extraer un valor (Wrapper para JSON_VALUE)
    MEMBER FUNCTION fn_get_value(p_path IN VARCHAR2)
        RETURN VARCHAR2
);
/
--
-- ----------------------------------------
-- 2. Implementación de Métodos y Constructor
--     El cuerpo del tipo implementa la lógica usando las funciones SQL/JSON estándar de Oracle.
-- -----------------------------------------
--
CREATE OR REPLACE TYPE BODY T_JSON_HANDLER AS 
    --
    -- CONSTRUCTOR: Inicializa el objecto con el string JSON
    CONSTRUCTOR FUNCTION T_JSON_HANDLER(p_json_string IN CLOB)
        RETURN SELF AS RESULT
    IS
    BEGIN
        -- Puedes añadir una verificación de validez aquí si la columna no fuera JSON type
        if p_json_string IS JSON then
            SELF.json_data := p_json_string;
        else
            RAISE_APPLICATION_ERROR(-20001, 'El string proporcionado no es JSON válido.');
        end if;
        --
        return;
    END T_JSON_HANDLER;
    --
    -- Metodo: Extraer un valor
    MEMBER FUNCTION fn_get_value(p_path IN VARCHAR2)
        RETURN VARCHAR2
    IS
    BEGIN
        -- Usa JSON_VALUE para consultar el dato encapsulado (SELF.json_data)
        return JSON_VALUE(SELF.json_data, p_path);
        --
    EXCEPTION
        when OTHERS then
            return null;
            --
    END fn_get_value;
    --
END T_JSON_HANDLER;
/
--
-- ----------------------------------------
-- 3. Bloque de Prueba (Uso en PL/SQL)
--    Este bloque demuestra cómo usar el constructor para crear el objeto y los métodos para 
--    interactuar con el JSON sin exponer las funciones SQL/JSON directamente al usuario.
-- -----------------------------------------
--
DECLARE
    -- Instancia de nuestro objeto manejador de JSON
    v_handler       T_JSON_HANDLER;
    v_data_inicial  CLOB;
    v_estado_actual VARCHAR2(50);
BEGIN
    -- 1. Definir en JSON inicial
    v_data_inicial := '{"order_id": 105, "status": "Pending", "client": {"name": "Alex"}, "amount": 450.50}';
    --
    -- 2. Instanciar el objeto usando el Constructor
    v_handler := T_JSON_HANDLER(v_data_inicial);
    --
    -- 3. Usar el método para leer un valor
    v_estado_actual := v_handler.fn_get_value('$.status');
    DBMS_OUTPUT.PUT_LINE('Estado inicial: ' || v_estado_actual);
    --
    -- Opcional: Mostrar el JSON completo después de la actualización
    DBMS_OUTPUT.PUT_LINE('JSON final: ' || v_handler.json_data);
    --
END;
/
--
/** ----------------------------------------
||  JSON_OBJECT_T
|| -----------------------------------------
|| DESCRIPCIÓN:
|| El tipo JSON_OBJECT_T es un tipo de objeto de PL/SQL que forma parte del paquete APEX_JSON o del paquete 
|| DBMS_JSON (disponible en versiones recientes de Oracle, 18c en adelante). Es fundamental para trabajar con 
|| JSON en el contexto de PL/SQL, ya que permite analizar (parsear) y manipular documentos JSON completos en 
|| memoria como si fueran objetos PL/SQL, en lugar de solo consultar valores con funciones SQL/JSON.
||
|| ----------------------------------
|| ¿Qué es JSON_OBJECT_T?
|| ----------------------------------
|| JSON_OBJECT_T es la representación en PL/SQL de un Objeto JSON (delimitado por llaves {}), y es el tipo base 
|| para trabajar con la librería nativa de manipulación JSON dentro de los bloques de código PL/SQL.
||
||_____________________________|______________________________________________________
|| Tipo de Dato JSON	       | Tipo de Objeto PL/SQL
||_____________________________|______________________________________________________
|| Objeto JSON ({...})         | JSON_OBJECT_T
||                             |
|| Array JSON ([...])          | JSON_ARRAY_T
||                             |
|| ualquier valor JSON         | JSON_ELEMENT_T (Superclase para todos los tipos JSON)
||_____________________________|_______________________________________________________
||
||
|| Uso y Métodos Clave
|| Para usar JSON_OBJECT_T, primero debes convertir un string JSON (VARCHAR2 o CLOB) en el objeto de PL/SQL.
||
|| 1. Constructor
||    Se utiliza el contructor para crear o convertir el objecto
*/
DECLARE
    v_json_text VARCHAR(100) := '{"name": "Client A", "id": 101}';
    v_object    JSON_OBJECT_T;
BEGIN
    -- Crear una instancia del objeto a partir de la cadena de texto
    v_object := JSON_OBJECT_T(v_json_text);
    -- ...
END;
/
--
-- ----------------------------------------
-- 2. Métodos Comunes
--    Una vez que tienes el objeto JSON_OBJECT_T, puedes usar sus métodos para inspeccionar, 
--    agregar, modificar o eliminar pares clave-valor.
-- -----------------------------------------
--
--______________________|_______________________________________|________________________________________________
-- Método               |  Propoosito                           |  Ejemplo (en un objeto v_object)
--______________________|_______________________________________|________________________________________________
--                      |                                       |
-- .get_string('key')   | Obtiene el valor de una clave         | v_name := v_object.get_string('name');
--                      | como cadena.                          |
--                      |                                       |
-- .get_number('key')   | Obtiene el valor de una clave         | v_id := v_object.get_number('id');
--                      | como número.                          |
--                      |                                       |
-- .put('key', value)   | Inserta un nuevo par o actualiza      | v_object.put('status', 'Active');
--                      | uno existente.                        |
--                      |                                       |
-- .remove('key')       | Elimina un par clave-valor del        | v_object.remove('id');
--                      | objeto.                               |
--                      |                                       |
-- .has('key')          | Devuelve TRUE si la clave existe      | IF v_object.has('status') THEN ...
--                      | en el objeto.                         |
--                      |                                       |
-- .to_string           | Convierte el objeto de vuelta a       | DBMS_OUTPUT.PUT_LINE(v_object.to_string);
--                      | una cadena JSON.                      |                                
--______________________|_______________________________________|________________________________________________
--
--
-- Ventaja Principal: Manipulación Detallada
-- La gran ventaja de JSON_OBJECT_T sobre las funciones SQL/JSON es cuando necesitas manipulación iterativa o 
-- condicional compleja dentro de bloques PL/SQL.
-- 
-- Ejemplo: Recorrer dinámicamente todas las claves de un objeto JSON y aplicar una lógica basada en el valor.
--
DECLARE
    v_object JSON_OBJECT_T := JSON_OBJECT_T('{"A": 10, "B": 20, "C": 30}');
    v_keys   JSON_KEY_LIST;
BEGIN
    -- Obtener lalista de todas las claves
    v_keys := v_object.get_keys;
    --
    for i in 1..v_keys.COUNT loop
        DBMS_OUTPUT.PUT_LINE('Key: ' || v_keys(i) || ', Value: ' || v_object.get_number(v_keys(i)));
        --
        -- Lógica condicional: si el valor es 0, cambiarlo a 200
        if v_object.get_number(v_keys(i)) = 20 then 
            v_object.put(v_keys(i), 200);
            DBMS_OUTPUT.PUT_LINE('  --> Valor de ' || v_keys(i) || ' cambiado a 200.');
        end if;
    end loop;
    --
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Final JSON: ' || v_object.to_string);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    --
END;