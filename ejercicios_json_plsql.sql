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