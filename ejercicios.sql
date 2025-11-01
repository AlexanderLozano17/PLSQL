/**
|| ------------------------------------------------
||             PRACTICA DE PAQUETES # 1
|| ------------------------------------------------
|| 1. Crear un paquete denominado REGIONES que tenga los
|| siguientes componentes:
||  • PROCEDIMIENTOS:
||  • CREAR_REGION, con parámetro de código y nombre Región.
||    Debe devolver un error si la región ya existe. Inserta una nueva
||    región en la tabla. Debe llamar a la función EXISTE_REGION
||    para controlarlo.
||
|| •  ELIMINAR_REGION, con parámetro de código de región y que
||    debe borrar una región. Debe generar un error si la región no
||    existe, Debe llamar a la función EXISTE_REGION para
||    controlarlo
||
||  • ACTUALIZAR_REGION: se le pasa un código y el nuevo nombre de la
||    región Debe modificar el nombre de una región ya existente.
||    Debe generar un error si la región no existe, Debe llamar a la
||    función EXISTE_REGION para controlarlo
||
||  • FUNCIONES
||  • OBTENER_NOMBRE_REGION. Se le pasa un código de región y devuelve el nombre
||    
||  • EXISTE_REGION. Devuelve verdadero si la región existe. Se
||    usa en los procedimientos y por tanto es PRIVADA, no debe
||    aparecer en la especificación del paquete
*/
CREATE OR REPLACE PACKAGE pk_regiones AS
    --
    /** 
    ||-----------------------------------
    || FUNCION OBTENER_NOMBRE_REGION
    || -----------------------------------
    */
    FUNCTION fn_obtener_nombre_region(p_codigo IN NUMBER) RETURN VARCHAR2;
    --
    /** 
    ||-----------------------------------
    || PROCEDIMIENTO CREAR_REGION
    || -----------------------------------
    */
    PROCEDURE pr_crear_region(
        p_codigo IN NUMBER,
        p_nombre IN VARCHAR2,
        p_mensaje OUT VARCHAR2
    );
    --
    /** 
    ||-----------------------------------
    || PROCEDIMIENTO ELIMINAR_REGION
    || -----------------------------------
    */
    PROCEDURE pr_eliminar_region(
        p_codigo IN NUMBER,
        p_mensaje OUT VARCHAR2
    );
    --
    /** 
    ||-----------------------------------
    || PROCEDIMIENTO ACTUALIZAR_REGION
    || -----------------------------------
    */
    PROCEDURE pr_actualizar_region(
        p_codigo IN NUMBER,
        p_nombre IN VARCHAR2,
        p_mensaje OUT VARCHAR2
    );
    --
END pk_regiones;
/

CREATE OR REPLACE PACKAGE BODY pk_regiones AS
    --
    /** 
    ||-----------------------------------
    || FUNCION EXITE_REGION
    || -----------------------------------
    */
    FUNCTION fn_existe_region(
        p_codigo IN NUMBER
    ) RETURN VARCHAR2
    IS 
        v_count NUMBER;
    BEGIN
        select count(*)
        into v_count
        from regions
        where region_id = p_codigo;
        --
        return case when (v_count>0) then 'TRUE' else 'FALSE' end;      
    END fn_existe_region;
    --
    /** 
    ||-----------------------------------
    || FUNCION OBTENER_NOMBRE_REGION
    || -----------------------------------
    */
    FUNCTION fn_obtener_nombre_region(
        p_codigo IN NUMBER
    ) RETURN VARCHAR2
    IS
        v_region_name regions.region_name%TYPE;
        v_existe_region VARCHAR2(5);
    BEGIN
        v_existe_region := fn_existe_region(p_codigo);
        --
        if v_existe_region = 'FALSE' then
            RAISE_APPLICATION_ERROR(-20001, 'El codigo de la region no existe');
        else
            select region_name
            into v_region_name
            from regions
            where region_id = p_codigo;

            return v_region_name;
        end if;
        --
    EXCEPTION
        when OTHERS then
            DBMS_OUTPUT.PUT_LINE('Error al obtener el nombre de la region' || SQLERRM);
            return null;
            --
    END fn_obtener_nombre_region;
    --
    /** 
    ||-----------------------------------
    || PROCEDIMIENTO CREAR_REGION
    || -----------------------------------
    */
    PROCEDURE pr_crear_region(
        p_codigo IN NUMBER,
        p_nombre IN VARCHAR2,
        p_mensaje OUT VARCHAR2
    )
    IS
        v_existe_region VARCHAR2(5);
    BEGIN
        v_existe_region := fn_existe_region(p_codigo);
        --
        if v_existe_region = 'TRUE' then 
            p_mensaje := 'La region ya existe';
            RAISE_APPLICATION_ERROR(-20001, p_mensaje);
        else
            insert into regions (region_id, region_name) values (p_codigo, p_nombre);
            COMMIT;

            p_mensaje := 'La region se ha creado correctamente';
            DBMS_OUTPUT.PUT_LINE(p_mensaje);            
        end if;
        --
    EXCEPTION 
        when OTHERS then
            p_mensaje := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Error crear la region' || p_mensaje);
            ROLLBACK;
            --
    END pr_crear_region;
    --
    /** 
    ||-----------------------------------
    || PROCEDIMIENTO ELIMINAR_REGION
    || -----------------------------------
    */
    PROCEDURE pr_eliminar_region(
        p_codigo IN NUMBER,
        p_mensaje OUT VARCHAR2
    ) IS  
        v_existe_region VARCHAR2(5);
    BEGIN
        v_existe_region := fn_existe_region(p_codigo);
        --
        if v_existe_region = 'FALSE' then 
            p_mensaje := 'La region no existe';
            RAISE_APPLICATION_ERROR(-20001, p_mensaje);
        else 
            delete regions where region_id = p_codigo;
            COMMIT;

            p_mensaje := 'La region se ha eliminado correctamente';
            DBMS_OUTPUT.PUT_LINE(p_mensaje);
        end if; 
        --
    EXCEPTION
        when OTHERS then  
            DBMS_OUTPUT.PUT_LINE('Error eliminar la region' || SQLERRM);
            ROLLBACK;
            --
    END pr_eliminar_region;
    --
    /** 
    ||-----------------------------------
    || PROCEDIMIENTO ACTUALIZAR_REGION
    || -----------------------------------
    */
    PROCEDURE pr_actualizar_region(
        p_codigo IN NUMBER,
        p_nombre IN VARCHAR2,
        p_mensaje OUT VARCHAR2
    ) IS 
        v_existe_region VARCHAR2(5);
    BEGIN
        v_existe_region := fn_existe_region(p_codigo);
        --
        if v_existe_region = 'FALSE' then
            RAISE_APPLICATION_ERROR(-20001, 'El codigo de la region no existe');
        else
            update regions set region_name = p_nombre where region_id = p_codigo;
            COMMIT;

            p_mensaje := 'La region se ha actualizado correctamente';
            DBMS_OUTPUT.PUT_LINE(p_mensaje);
        end if;
        --
    EXCEPTION
        when OTHERS then
            DBMS_OUTPUT.PUT_LINE('Error al actualizar la region ' || SQLERRM);
            ROLLBACK;
            --
    END pr_actualizar_region; 
    --
END pk_regiones;
/
--
--
--
/** 
||-----------------------------------
|| TEST DEL PACKACGE PK_REGIONES
|| -----------------------------------
*/
SET SERVEROUTPUT ON;
DECLARE
    v_region_name_obtenida      regions.region_name%TYPE;
    v_region_codigo_buscar      regions.region_id%TYPE      := 6;
    --
    v_codigo_region_crear       regions.region_id%TYPE      := 89;
    v_nombre_region_crear       regions.region_name%TYPE    := 'Oceania';
    v_mensaje_crear             VARCHAR2(100);
    --
    v_codigo_region_actualizar  regions.region_id%TYPE      := 89;
    v_nombre_region_actualizar  regions.region_name%TYPE    := 'Oceania2';
    v_mensaje_actualizar        VARCHAR2(100);
    --
    v_codigo_region_eliminar    regions.region_id%TYPE      := 89;
    v_mensaje_eliminar          VARCHAR2(100);
BEGIN
    v_region_name_obtenida := pk_regiones.fn_obtener_nombre_region(v_region_codigo_buscar);
    DBMS_OUTPUT.PUT_LINE('El nombre de la region es: ' || v_region_name_obtenida);
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    --
    --
    --
    pk_regiones.pr_crear_region(
        p_codigo => v_codigo_region_crear,
        p_nombre => v_nombre_region_crear,
        p_mensaje => v_mensaje_crear
    );
    --
    DBMS_OUTPUT.PUT_LINE('Esta es la variable que guarda la respuesta del procedimiento pr_crear_region: ' || v_mensaje_crear);
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    --
    --
    --
    pk_regiones.pr_actualizar_region(
        p_codigo => v_codigo_region_actualizar,
        p_nombre => v_nombre_region_actualizar,
        p_mensaje => v_mensaje_actualizar
    );
    --
    DBMS_OUTPUT.PUT_LINE('Esta es la variable que guarda la respuesta del procedimiento pr_actualizar_region: ' || v_mensaje_actualizar);
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    --
    --
    --
    pk_regiones.pr_eliminar_region(
        p_codigo => v_codigo_region_eliminar,
        p_mensaje => v_mensaje_eliminar
    );
    --
    DBMS_OUTPUT.PUT_LINE('Esta es la variable que guarda la respuesta del procedimiento pr_eliminar_region: ' || v_mensaje_eliminar);
    --
END;
/
--
/**
|| ------------------------------------------------
||             PRACTICA DE PAQUETES # 2
|| ------------------------------------------------
|| 2. Crear un paquete denominado NOMINA que tenga sobrecargado
||     la función CALCULAR_NOMINA de la siguiente forma:
||  • CALCULAR_NOMINA(NUMBER): se calcula el salario del
||    empleado restando un 15% de IRPF.
||
||  • CALCULAR_NOMINA(NUMBER,NUMBER): el segundo
||    parámetro es el porcentaje a aplicar. Se calcula el salario del
||    empleado restando ese porcentaje al salario
*/
--
CREATE OR REPLACE PACKAGE pk_nomina AS
    --
    /** 
    ||-----------------------------------
    || PROCEDIMIENTO CALCULAR_NOMINA
    || -----------------------------------
    */
    FUNCTION fn_calcular_nomina(
        p_salario IN NUMBER
    ) RETURN NUMBER;
    --
    /** 
    ||-----------------------------------
    || PROCEDIMIENTO CALCULAR_NOMINA
    || -----------------------------------
    */
    FUNCTION fn_calcular_nomina(
        p_salario IN NUMBER,
        p_porcentaje IN NUMBER
    ) RETURN NUMBER;
    --
END pk_nomina;
/
--
CREATE OR REPLACE PACKAGE BODY pk_nomina AS
    --
    /** 
    ||-----------------------------------
    || DECLARACION DE CONTSNATES
    || -----------------------------------
    */
    IRPF NUMBER := 0.15;
    --
    /** 
    ||-----------------------------------
    || FUNCTION CALCULAR_NOMINA
    || -----------------------------------
    */
    FUNCTION fn_calcular_nomina(
        p_salario IN NUMBER
    ) RETURN NUMBER
    IS 
    BEGIN 
        if p_salario is null then
            RAISE_APPLICATION_ERROR(-20001, 'El salario no puede ser nulo');
            return 0;
        end if;
        --
        return p_salario - (p_salario * IRPF);
        --
     END fn_calcular_nomina;
    --
    /** 
    ||-----------------------------------
    || FUNCTION CALCULAR_NOMINA
    || -----------------------------------
    */
    FUNCTION fn_calcular_nomina(
        p_salario IN NUMBER,
        p_porcentaje IN NUMBER
    ) RETURN NUMBER
    IS 
    BEGIN 
        if p_salario is null then
            RAISE_APPLICATION_ERROR(-20001, 'El salario no puede ser nulo');
            return 0;
        end if;
        --
        return p_salario - (p_salario * p_porcentaje);
        --
    END fn_calcular_nomina;
    --
END pk_nomina;
/
--
/** 
||-----------------------------------
|| TEST DEL PACKACGE PK_NOMINA
|| -----------------------------------
*/
DECLARE
    v_nomina        NUMBER := 1000;
    v_porcentaje    NUMBER := 0.1;
    --
    v_nomina1       NUMBER := 0;
    v_nomina2       NUMBER := 0;
BEGIN
    v_nomina1 := pk_nomina.fn_calcular_nomina(v_nomina);
    DBMS_OUTPUT.PUT_LINE('Nomina #1: $' || v_nomina1);
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    --
    --
    v_nomina2 := pk_nomina.fn_calcular_nomina(v_nomina, v_porcentaje);
    DBMS_OUTPUT.PUT_LINE('Nomina #2: $' || v_nomina2);
    --
END;
/