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
--
-- -------------------------------------------------------------------------
-- 4. Ejercicio: Requerimiento: Pre-facturación Dinámica y Auditoría JSON
-- -------------------------------------------------------------------------
-- Contexto: La empresa necesita generar un borrador de factura para un cliente. El detalle del
--pedido (items) se envía como un arreglo JSON. Queremos procesar este JSON, validar los productos 
-- contra la tabla T_PRODUCTOS, calcular el subtotal y generar un nuevo objeto JSON de "Auditoría de Pedido" que incluya el cálculo.
--
DECLARE
    v_pedido_entrada CLOB := 
        '[
            {"id_producto": 101, "cantidad": 1},
            {"id_producto": 102, "cantidad": 2}
            -- El producto 103 (Mouse) tiene precio 25.00
        ]';
    
    v_json_salida CLOB;
    v_total_salida NUMBER;
BEGIN
    -- Ejecutar el requerimiento
    PR_GENERAR_BORRADOR(
        p_cliente_id => 99,
        p_orden_items_json => v_pedido_entrada,
        p_auditoria_json => v_json_salida,
        p_total_a_pagar => v_total_salida
    );
    
    -- Mostrar resultados
    DBMS_OUTPUT.PUT_LINE('=== RESULTADO DE LA PRE-FACTURA ===');
    DBMS_OUTPUT.PUT_LINE('Total Calculado: ' || TO_CHAR(v_total_salida, 'FM99,999.00'));
    DBMS_OUTPUT.PUT_LINE('JSON de Auditoría:');
    -- Usar DBMS_LOB.SUBSTR para imprimir el CLOB grande
    DBMS_OUTPUT.PUT_LINE(DBMS_LOB.SUBSTR(v_json_salida, 1000, 1)); 

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/
--
-- Crear el Procedimiento PR_GENERAR_BORRADOR
CREATE OR REPLACE PROCEDURE PR_GENERAR_BORRADOR (
    p_cliente_id IN NUMBER,
    p_orden_items_json IN CLOB, -- Array de objetos JSON (lo que el cliente pide)
    p_auditoria_json OUT CLOB,  -- JSON resultante con cálculos
    p_total_a_pagar OUT NUMBER  -- Total final
)
IS 
    -- Variables para manejo de JSON
    v_array_pedidos         JSON_ARRAY_T;          -- Array de entrada (items del cliente)
    v_detalles_auditoria    JSON_ARRAY_T := JSON_ARRAY_T(); -- Array de salida (items con precios y subtotales)
    v_item_entrada          JSON_OBJECT_T;         -- Objeto dentro del array de entrada
    v_item_auditado         JSON_OBJECT_T;         -- Nuevo objeto para el array de auditoría
    v_json_final            JSON_OBJECT_T;         -- Objeto raíz final
    --
    -- Variables para cálculos y consulta relacional
    v_id_producto       NUMBER;
    v_cantidad          NUMBER;
    v_nombre_producto   T_PRODUCTOS.nombre%TYPE;
    v_precio_unitario   T_PRODUCTOS.precio_unitario%TYPE;
    v_subtotal_item     NUMBER(10, 2);
    --
    -- Excepción para manejar productos no encontrados
    e_producto_no_encontrado EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_producto_no_encontrado, -20002);
BEGIN
    -- 0. Inicializar el total
    p_total_a_pagar := 0;
    -- 1. Parsear el JSON de entrada a JSON_ARRAY_T
    v_array_pedidos := JSON_ARRAY_T(p_orden_items_json);
    --
    -- 4. Iterar sobre el p_orden_items_json
    FOR i IN 0..v_array_pedidos.get_size() -1 LOOP
        --
        -- A. Obtener el objeto de pedido y extraer cantidad/id
        v_item_entrada  := TREAT(v_array_pedidos.get(i) AS JSON_OBJECT_T);
        v_id_producto   := v_item_entrada.get_number('id_producto');
        v_cantidad      := v_item_entrada.get_number('cantidad');
        --
        BEGIN   
            -- B. Consultar la tabla T_PRODUCTOS para obtener el precio y nombre
            SELECT nombre, precio_unitario
            INTO v_nombre_producto, v_precio_unitario
            FROM T_PRODUCTOS
            WHERE id_producto = v_id_producto;
            --
            -- C. Calcular el subtotal
            v_subtotal_item := v_precio_unitario * v_cantidad;
            --
            -- D. Sumar al total general
            p_total_a_pagar := p_total_a_pagar + v_subtotal_item;
            --
            -- E. Crear el nuevo JSON_OBJECT_T auditado
            v_item_auditado := JSON_OBJECT_T();
            v_item_auditado.put('id_producto', v_id_producto);
            v_item_auditado.put('nombre', v_nombre_producto);
            v_item_auditado.put('cantidad', v_cantidad);
            v_item_auditado.put('precio_unitario', v_precio_unitario);
            v_item_auditado.put('subtotal', v_subtotal_item);
            --
            -- F. Añadir al array de auditoría
            v_detalles_auditoria.append(v_detalles_auditoria);
        --
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Manejar productos que no existen en la base de datos
                DBMS_OUTPUT.PUT_LINE('ADVERTENCIA: Producto ID ' || v_id_producto || ' no encontrado en T_PRODUCTOS. Ítem omitido.');
        END;
    --
    END LOOP;
    --
    -- 5. Construir el JSON de salida (p_auditoria_json)
    v_json_final := JSON_OBJECT_T();
    v_json_final.put('cliente_id', p_cliente_id);
    v_json_final.put('fecha_proceso', SYSDATE);
    v_json_final.put('total_factura', p_total_a_pagar);
    -- Añadir el array de detalles como un atributo del objeto raíz
    v_json_final.put('items_auditados', v_detalles_auditoria); 
    
    -- Asignar el JSON final a la variable de salida CLOB
    p_auditoria_json := v_json_final.to_string;
END;
/
--
--
-- Bloque de Prueba (Verificación)
DECLARE
    v_pedido_entrada CLOB := 
        '[
            {"id_producto": 101, "cantidad": 1},
            {"id_producto": 102, "cantidad": 2}
        ]';
    
    v_json_salida CLOB;
    v_total_salida NUMBER;
BEGIN
    PR_GENERAR_BORRADOR(
        p_cliente_id => 99,
        p_orden_items_json => v_pedido_entrada,
        p_auditoria_json => v_json_salida,
        p_total_a_pagar => v_total_salida
    );
    --
    -- Mostrar resultados
    DBMS_OUTPUT.PUT_LINE('=== RESULTADO DE LA PRE-FACTURA ===');
    DBMS_OUTPUT.PUT_LINE('Total Calculado: ' || TO_CHAR(v_total_salida, 'FM99,999.00'));
    DBMS_OUTPUT.PUT_LINE('JSON de Auditoría:');
    -- Usar DBMS_LOB.SUBSTR para imprimir el CLOB grande
    DBMS_OUTPUT.PUT_LINE(DBMS_LOB.SUBSTR(v_json_salida, 1000, 1)); 

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/
