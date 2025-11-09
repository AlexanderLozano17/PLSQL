SET SERVEROUTPUT ON;
--
-- -------------------------------------------------------------------------
-- 1. Ejercicio: Gestión de Inventario (Tablas Asociativas / INDEX BY)
-- -------------------------------------------------------------------------
-- Las Tablas Asociativas son flexibles, no tienen un límite de tamaño predefinido y 
-- usan una clave (STRING o NUMBER) para acceder a los elementos, ideal para mapeo de datos.
--
-- Tarea a Realizar:
--
-- 1. Declara un tipo de tabla asociativa llamado T_INVENTARIO donde la clave sea VARCHAR2 (el nombre del producto) y el valor sea NUMBER (el stock).
-- 2. Declara una variable v_stock de ese tipo.
-- 3. Asigna tres productos a la variable, usando sus nombres como claves (ej., 'LAPTOP' con stock 50).
-- 4. Modifica el stock de uno de los productos (ej., 'LAPTOP' a 45).
-- 5. Usa un bucle FOR con v_stock.FIRST y v_stock.NEXT para iterar sobre todos los elementos e imprimir el par Clave-Valor.
--
DECLARE
    -- 1. Declarar el tipo de tabla asociativa
    TYPE T_INVENTARIO IS TABLE OF NUMBER INDEX BY VARCHAR2(50);
    --
    -- 2. Declarar la variable
    v_stock T_INVENTARIO;
    v_key   VARCHAR2(50);
BEGIN
    -- 3. Asignar valores
    v_stock('TECLADO') := 120;
    v_stock('MONITOR') := 85;
    v_stock('LAPTOP') := 100;
    --
    -- 4. Modificar un valor
    v_stock('LAPTOP') := 45;
    --
    DBMS_OUTPUT.PUT_LINE('--- Inventario Actualizado ---');
    --
    -- 5. Iterar sobre la colección
    v_key := v_stock.FIRST;
    --
    WHILE v_key IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE('Producto: ' || v_key || ', Stock: ' || v_stock(v_key));
        v_key := v_stock.NEXT(v_key); -- Pasa a la siguiente clave
    END LOOP;
END;
/
--
-- -------------------------------------------------------------------------
-- 2. Ejercicio: Lista de Puntuaciones (VARRAY)
-- -------------------------------------------------------------------------
-- Los VARRAYs son colecciones de tamaño fijo o límite máximo predefinido y son densos 
-- (no pueden tener huecos). Son ideales para listas ordenadas donde el tamaño es conocido.
--
-- Tarea a Realizar:
-- 1. Declara un tipo T_SCORES como VARRAY(5) de NUMBER.
-- 2. Declara una variable v_scores de ese tipo.
-- 3. Inicializa la variable con 5 puntuaciones.
-- 4. Usa un bucle FOR i IN 1 .. v_scores.LIMIT para iterar sobre los elementos e imprimir solo las puntuaciones que sean mayores o iguales a 80.
--
DECLARE
    -- 1. Declarar el tipo VARRAY con límite máximo de 5
    TYPE T_SCORES IS VARRAY(5) OF NUMBER;
    --
    -- 2. Declarar y 3. Inicializar la variable
    v_scores T_SCORES := T_SCORES(95, 78, 82, 65, 90);
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Puntuaciones Aprobadas (>= 80) ---');
    --
    -- 4. Iterar sobre el VARRAY (los índices de VARRAY comienzan en 1)
    FOR i IN 1..v_scores.LIMIT LOOP
        IF v_scores(i) >= 80 THEN
            DBMS_OUTPUT.PUT_LINE('Puntuación: ' || i || ': ' || v_scores(i));
        END IF;
    END LOOP;
END;
/
--
-- -------------------------------------------------------------------------
-- 3. Ejercicio: Registro de Fechas (Tablas Anidadas / NESTED TABLE)
-- -------------------------------------------------------------------------
-- Las Tablas Anidadas (NESTED TABLE) son colecciones flexibles en tamaño y pueden tener huecos, 
-- pero sus índices siempre se normalizan. Son las más cercanas a los arrays de otros lenguajes.
--
-- Tarea a Realizar:
-- 1. Declara un tipo T_FECHAS como TABLE OF DATE.
-- 2. Declara una variable v_fechas de ese tipo.
-- 3. Inicializa la variable usando el constructor (T_FECHAS()).
-- 4. Usa el método .EXTEND para añadir espacio e inserta 3 fechas.
-- 5. Usa un bucle FOR i IN v_fechas.FIRST .. v_fechas.LAST para iterar y mostrar las fechas en formato DD-MON-YYYY.
--
DECLARE
    -- 1. Declara un tipo T_FECHAS como TABLE OF DATE.
    TYPE T_FECHAS IS TABLE OF DATE;
    --
    -- 2. Declara una variable v_fechas de ese tipo.
    v_fechas T_FECHAS;
BEGIN
    -- 3. Inicializa la variable usando el constructor (T_FECHAS()).
    v_fechas := T_FECHAS();
    --
    -- 4. Usar EXTEND para añadir espacio e insertar datos (los índices empiezan en 1)
    v_fechas.EXTEND(3);
    v_fechas(1) := DATE '2025-10-01';
    v_fechas(2) := DATE '2025-10-15';
    v_fechas(3) := SYSDATE;
    --
    DBMS_OUTPUT.PUT_LINE('--- Fechas de Registro ---');
    ---
    -- 5. Iterar sobre la colección (usando FIRST y LAST)
    FOR i IN v_fechas.FIRST..v_fechas.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('Registro ' || i || ': ' || TO_CHAR(v_fechas(i), 'DD-MON-YYYY'));
    END LOOP;
END;
/

