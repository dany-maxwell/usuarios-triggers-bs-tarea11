Parte 1:
Practica de creacion y gestion de usuarios
-	Se crearon usuarios
-	Se les otorgo diferentes permisos sobre la base de datos
-	Se les revoco permisos
-	Se verificaron los permisos asignados.
-	Se probaron los roles de usuario
Parte 2:
•	BEFORE vs AFTER 
o	BEFORE: ejecuta antes de la operación; útil para validar o modificar datos. 
o	AFTER: ejecuta después; útil para registrar acciones, notificar o generar registros dependientes. 
•	ROW vs STATEMENT 
o	FOR EACH ROW (row-level): se ejecuta por cada fila afectada; ideal para guardar old/new en auditoría. 
o	FOR EACH STATEMENT (statement-level): se ejecuta una vez por la instrucción; útil para resúmenes o limitaciones globales. 
•	Cuando aplicarlos 
o	Auditoría: usar AFTER INSERT/UPDATE/DELETE FOR EACH ROW para capturar OLD/NEW.
o	Validaciones complejas: BEFORE para bloquear la operación si no cumple reglas. 
o	Mantenimiento: AFTER para tareas post-procesamiento (ej. enviar notificaciones).
