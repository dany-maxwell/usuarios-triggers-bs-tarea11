-- Creación de Base de Datos con sus Tablas

create database negocios_extranjeros;

use negocios_extranjeros;

create table clientes (
    id_cliente int auto_increment primary key,
    nombre varchar(100) not null,
    pais varchar(50),
    correo varchar(100) unique
);

create table inversionistas (
    id_inversionista int auto_increment primary key,
    nombre varchar(100) not null,
    empresa varchar(100),
    pais varchar(50)
);

create table ventas (
    id_venta int auto_increment primary key,
    id_cliente int not null,
    id_inversionista int not null,
    fecha date not null,
    monto decimal(12,2) not null,
    foreign key (id_cliente) references clientes(id_cliente),
    foreign key (id_inversionista) references inversionistas(id_inversionista)
);

-- Creacion de Usuarios y Asignación de Privilegios

create user 'analista_user'@'localhost' identified by 'alist123';
create user 'visor_user'@'localhost' identified by 'vis1234';

grant insert, select, update, delete on negocios_extranjeros.clientes to 'analista_user'@'localhost';
grant insert, select, update, delete on negocios_extranjeros.inversionistas to 'analista_user'@'localhost';
grant insert, select, update, delete on  negocios_extranjeros.ventas to 'analista_user'@'localhost';
grant select on negocios_extranjeros.auditoria_ventas to 'analista_user'@'localhost';
grant select on negocios_extranjeros.* to 'visor_user'@'localhost';
flush privileges;
select * from mysql.user;
show grants for 'analista_user'@'localhost';
show grants for 'visor_user'@'localhost';

-- Creacion de tabla de auditoria para los triggers

create table auditoria_ventas (
    id_auditoria int auto_increment primary key,
    accion varchar(10),              
    usuario varchar(100),            
    fecha timestamp default current_timestamp,
    datos_previos text,             
    datos_nuevos text              
);

-- Creacion de triggers
-- Insert

delimiter //

create trigger ventas_insert_auditoria
after insert on ventas
for each row
begin
    insert into auditoria_ventas (accion, usuario, datos_previos, datos_nuevos)
    values (
        'insert',
        user(),
        null,
        concat('id_venta=', new.id_venta, ', monto=', new.monto)
    );
end;
//

delimiter ;


-- Update

delimiter // 
create trigger ventas_update_auditoria
after update on ventas
for each row
begin
	insert into auditoria_ventas (accion, usuario, datos_previos, datos_nuevos)
    values(
		'update',
        user(),
        concat('id_venta=',old.id_venta,', monto=',old.monto),
        concat('id_venta=',new.id_venta,', monto=',new.monto)
    );
end;
//
delimiter ;

-- Delete

delimiter // 
create trigger ventas_delete_auditoria
after delete on ventas
for each row
begin
	insert into auditoria_ventas (accion, usuario, datos_previos, datos_nuevos)
    values(
		'update',
        user(),
        concat('id_venta=',old.id_venta,', monto=',old.monto),
        null
    );
end;
//
delimiter ;

-- Datos para las tablas
insert into clientes (nombre, pais, correo)
values 
('juan perez', 'mexico', 'juan.perez@mail.com'),
('maria lopez', 'chile', 'maria.lopez@mail.com'),
('carlos ramirez', 'argentina', 'carlos.ramirez@mail.com');

insert into inversionistas (nombre, empresa, pais)
values 
('ana gomez', 'global capital', 'españa'),
('roberto diaz', 'andes inversiones', 'peru'),
('sofia torres', 'latam ventures', 'colombia');

insert into ventas (id_cliente, id_inversionista, fecha, monto)
values 
(1, 1, '2025-12-01', 15000.00),
(2, 2, '2025-12-05', 22000.00),
(3, 3, '2025-12-10', 18000.00);
