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
    v_person_object JSON_OBJECT_T := JSON_OBJECT_T('{"id_user":45,"is_active":true,"email":"test@example.com","rating":4.75}');
BEGIN

END;