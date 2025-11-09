SET SERVEROUTPUT ON;
-- -------------------------------------------------------------------------
-- Ejercicio 1: Creación de Objeto con Diversos Tipos (JSON_OBJECT_T)
-- -------------------------------------------------------------------------
--
-- Objetivo: Construir un objeto JSON completo desde cero en PL/SQL, demostrando 
-- cómo añadir strings, números y booleanos usando el método .put().
--
-- Tarea a Realizar:
-- 1. Declara una variable v_profile de tipo JSON_OBJECT_T e inicialízala vacía (JSON_OBJECT_T()).
-- 
-- 2. Usa el método .put() para añadir los siguientes pares clave-valor:
--
-- "id_user": NUMBER (ej. 45)
-- "is_active": BOOLEAN (ej. TRUE)
-- "email": VARCHAR2 (ej. 'test@example.com')
-- "rating": NUMBER (ej. 4.75)
--
-- 3. Utiliza el método .to_string() para imprimir el JSON final resultante.
--  Resultado Esperado (en DBMS_OUTPUT):
--
--  {"id_user":45,"is_active":true,"email":"test@example.com","rating":4.75}
--
DECLARE
    v_json_esperado VARCHAR2(100) := '{"id_user":45,"is_active":true,"email":"test@example.com","rating":4.75}';
    v_profile JSON_OBJECT_T;
BEGIN
    v_profile := JSON_OBJECT_T();
    --
    v_profile.put('id_user',45);
    v_profile.put('is_active',true);
    v_profile.put('email','test@example.com');
    v_profile.put('rating', 4.75);
    --
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Resultado JSON esperado: ' || v_json_esperado);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Resultado JSON  final: ' || v_profile.to_string);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
END;
/
--
-- -------------------------------------------------------------------------
-- Ejercicio 2: Iteración y Extracción de Array (JSON_ARRAY_T)
-- -------------------------------------------------------------------------
-- Objetivo: Recorrer un array de objetos y extraer datos específicos de cada elemento.
--
DECLARE
    v_json_text CLOB := 
        '[
            {"sensor_id": "T-10", "value": 25.5, "status": "OK"},
            {"sensor_id": "T-11", "value": 30.1, "status": "ALERT"},
            {"sensor_id": "T-12", "value": 22.0, "status": "OK"}
        ]';
    --
    v_array     JSON_ARRAY_T;
    v_object    JSON_OBJECT_T;
    v_list_key  JSON_KEY_LIST;
BEGIN
    v_array     := JSON_ARRAY_T(v_json_text);
    --
    for i in 0..v_array.get_size() -1 loop
        v_object := TREAT(v_array.get(i) AS JSON_OBJECT_T);
        --
        DBMS_OUTPUT.PUT_LINE('Sensor: ' || v_object.get_string('sensor_id'));
        DBMS_OUTPUT.PUT_LINE('Valor:  ' || TO_CHAR(v_object.get_number('value')));
        DBMS_OUTPUT.PUT_LINE('Estado: ' || v_object.get_string('status'));
        DBMS_OUTPUT.PUT_LINE('-------------------');
    end loop;
    --
END;
/
-- -------------------------------------------------------------------------
-- Ejercicio 3: Verificación de Tipos (JSON_ELEMENT_T)
-- -------------------------------------------------------------------------
-- Objetivo: Usar el tipo genérico JSON_ELEMENT_T para manejar un valor que puede 
-- ser un objeto o un valor simple, y usar is_object() o is_array() para la lógica condicional.
DECLARE 
    v_json_text     VARCHAR2(100) := 
        '{
            "config": {"id": 1}, 
            "data": [10, 20]
        }';
    v_root_object   JSON_OBJECT_T := JSON_OBJECT_T(v_json_text);
    v_element       JSON_ELEMENT_T;
    v_keys          JSON_KEY_LIST;
    v_array_temp    JSON_ARRAY_T;
BEGIN
    v_keys := v_root_object.get_keys;
    --
    FOR i IN 1..v_keys.COUNT LOOP
        --
        DECLARE
            v_current_key VARCHAR2(30) := v_keys(i);
        BEGIN
            v_element := v_root_object.get(v_current_key);
            --
            IF v_element.is_object THEN 
                DBMS_OUTPUT.PUT_LINE('Procesando la clave ' || v_current_key || '... El nodo es un Objeto JSON.');
                --
            ELSIF v_element.is_array THEN
                v_array_temp := TREAT(v_element AS JSON_ARRAY_T);
                DBMS_OUTPUT.PUT_LINE('Procesando la clave ' || v_current_key || '... El nodo es un Array JSON. Tamaño: ' || v_array_temp.get_size());
            END IF;
        END;
    END LOOP;
   --
END;
--
-- -------------------------------------------------------------------------
-- 4. Ejercicio: Requerimiento: Pre-facturación Dinámica y Auditoría JSON
-- -------------------------------------------------------------------------
-- Contexto: La empresa necesita generar un borrador de factura para un cliente. El detalle del
--pedido (items) se envía como un arreglo JSON. Queremos procesar este JSON, validar los productos 
-- contra la tabla T_PRODUCTOS, calcular el subtotal y generar un nuevo objeto JSON de "Auditoría de Pedido" que incluya el cálculo.
--
BEGIN
    -- Ejecución Dinámica de la DDL (CREATE TABLE)
    BEGIN
        EXECUTE IMMEDIATE 'CREATE TABLE T_PRODUCTOS (
            id_producto       NUMBER PRIMARY KEY,
            nombre            VARCHAR2(100) NOT NULL,
            precio_unitario   NUMBER(8, 2) NOT NULL
        )';
        DBMS_OUTPUT.PUT_LINE('Tabla T_PRODUCTOS creada.');
    EXCEPTION
        WHEN OTHERS THEN
            -- Manejar el error si la tabla ya existe (ej. ORA-00955)
            IF SQLCODE = -955 THEN
                DBMS_OUTPUT.PUT_LINE('La tabla T_PRODUCTOS ya existe. Continuando.');
            ELSE
                RAISE;
            END IF;
    END;

    -- DML (INSERT) puede ir directamente, pero es más limpio usar SQL puro
    -- o también puedes usar EXECUTE IMMEDIATE si el contexto lo requiere:
    INSERT INTO T_PRODUCTOS VALUES (101, 'Laptop Gaming', 1200.00);
    INSERT INTO T_PRODUCTOS VALUES (102, 'Monitor 4K', 450.00);
    INSERT INTO T_PRODUCTOS VALUES (103, 'Mouse Inalámbrico', 25.00);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Datos insertados y confirmados.');
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
--
-- -------------------------------------------------------------------------
-- Ejercicio 5: Requerimiento: Auditoría de Acceso y Registro de Intentos
-- -------------------------------------------------------------------------
-- Contexto: 
-- Necesitamos un procedimiento que reciba una lista JSON de intentos de inicio de sesión. 
-- El procedimiento debe validar si el user_id existe en una tabla de usuarios (que crearemos) y, 
-- además, debe generar un reporte JSON que registre si el intento fue exitoso o fallido, y por qué.
--
-- Creación de la Tabla T_USUARIOS 
CREATE TABLE T_USUARIOS (
            user_id           NUMBER PRIMARY KEY,
            username          VARCHAR2(50) NOT NULL,
            password_hash     VARCHAR2(64) NOT NULL
        );
        
INSERT INTO T_USUARIOS VALUES (10, 'ADMIN', 'hash_A_correct_1234');
INSERT INTO T_USUARIOS VALUES (20, 'GUEST', 'hash_B_correct_5678');
--
-- Tarea a Realizar: Crear el Procedimiento PR_AUDITAR_ACCESO
--
CREATE OR REPLACE PROCEDURE PR_AUDITAR_ACCESO (
    p_intentos_json IN CLOB,    
    p_reporte_json OUT CLOB,    
    p_intentos_fallidos OUT NUMBER
)
IS
    v_existe_usuario    NUMBER;
    v_array_intentos    JSON_ARRAY_T;
    v_object_intento    JSON_OBJECT_T;
    --
    v_user_id   T_USUARIOS.user_id%TYPE;
    v_password  T_USUARIOS.password_hash%TYPE;
    --
    v_reporte_intentos JSON_OBJECT_T;
BEGIN
    v_array_intentos    := JSON_ARRAY_T(p_intentos_json);
    v_object_intento    := JSON_OBJECT_T();
    v_reporte_intentos  := JSON_OBJECT_T();
    --
    FOR i IN 0..v_array_intentos.get-size() - 1 LOOP
        --
        v_object_intento := TREAT(v_array_intentos.get(i) AS JSON_OBJECT_T);
        --
        SELECT user_id, password_hash
        INTO v_user_id, v_password
        FROM T_USUARIOS
        WHERE user_id = v_object_intento(i).get('user_id');
        --
        IF v_user_id != null THEN
            -- valida si el intento es correcto
            IF v_password = v_object_intento(i).get('password_hash') THEN
                
                --
                v_reporte_intentos.put('user_id', v_object_intento(i).get('user_id'));
                v_reporte_intentos.put('username', v_object_intento(i).get('username'));
                v_reporte_intentos.put('password_hash', v_password);
                v_reporte_intentos.put('password_hash_correct', v_object_intento(i).get('password_hash'));
            
            ELSE 
            
            END IF;            
            --
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'El usuario con ID: ' || v_object_intento(i).get('user_id') || ' No existe');
        END IF;
        --
    END LOOP;
END;
/


















