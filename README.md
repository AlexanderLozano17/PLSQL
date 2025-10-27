# 📚 Curso Práctico de PL/SQL (Oracle Database)

Este repositorio contiene una colección organizada de scripts, ejercicios y ejemplos de código PL/SQL enfocados en el aprendizaje y la aplicación de la programación a nivel de base de datos Oracle.

El objetivo es dominar los conceptos esenciales, desde la sintaxis básica hasta el manejo avanzado de transacciones, cursores y colecciones.

## 🌈 Contenido y Estructura del Repositorio

Los scripts están organizados por tema, siguiendo una progresión lógica de aprendizaje.

| Carpeta | Descripción | Nivel de Dificultad |
|---------|-------------|---------------------|
| `01_Basicos` | Bloques anónimos, variables, tipos de datos y DBMS_OUTPUT. | Básico |
| `02_Estructuras_Control` | Ejemplos de sentencias IF/ELSE, CASE, LOOP, WHILE y FOR. | Básico |
| `03_Procedimientos_Funciones` | Creación y manejo de objetos almacenados (STORED PROCEDURES y FUNCTIONS) con parámetros IN y OUT. | Intermedio |
| `04_Cursores_Manejo_Datos` | Cursores explícitos, bucles FOR, WHERE CURRENT OF, y manejo de excepciones DML. | Intermedio |
| `05_Colecciones_Avanzado` | Tablas anidadas, VARRAYs, y técnicas de rendimiento como BULK COLLECT y FORALL. | Avanzado |
| `06_Triggers_Excepciones` | Creación de triggers de auditoría y manejo personalizado de errores (EXCEPTION). | Intermedio/Avanzado |
| `data_setup` | Scripts DDL para crear tablas de prueba (ej. employees, departments) necesarias para los ejercicios. **Ejecutar primero.** | Básico |

## ⚙️ Requisitos

Para seguir este curso y ejecutar los ejercicios, necesitarás los siguientes elementos configurados en tu entorno:

- **Oracle Database**: Acceso a cualquier edición reciente de Oracle (12c, 19c, o 23c Free).
- **Esquema HR (Recomendado)**: Muchos ejercicios asumen que la estructura de la base de datos es similar a la del esquema de ejemplo HR (Human Resources).
- **Cliente SQL**: Se recomienda utilizar Oracle SQL Developer o SQLcl para trabajar con PL/SQL de manera más eficiente.

## 🚀 Cómo Empezar y Ejecutar los Scripts

Para comenzar a practicar, sigue estos sencillos pasos:

### 1. Clonar el Repositorio:

```bash
git clone https://github.com/AlexanderLozano17/PLSQL.git
cd PLSQL