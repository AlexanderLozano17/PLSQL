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
|| ___________|__________________________|___________________________________________________________________
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
||____________|__________________________|____________________________________________________________________
||
||  === PAQUETES PARA TAREAS DE ADMINISTRACIÓN Y SISTEMAS ===
||  Estos paquetes son utilizados frecuentemente por los administradores de bases de datos (DBAs) o para tareas de mantenimiento y seguridad.
||
|| Paquete         |   Propósito Principal	  |   Función/Uso Común
|| ________________|__________________________|___________________________________________________________________
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
*/






