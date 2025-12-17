-- ------------------------------------ --
-- Parte 1 --
-- ------------------------------------ --

CREATE DATABASE campamento;

USE campamento;

CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    fecha_nacimiento DATE,
    direccion VARCHAR(100),
    telefono VARCHAR(15)
);

CREATE TABLE pago_campamento (
    pago_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    fecha_pago DATE,
    monto DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

create user 'PP_GRILLO'@'localhost' identified by 'pp123';

create user 'Dolores_de_Barriga'@'localhost' identified by 'dolores123';
create user 'Paco_Mer'@'Localhost' identified by 'paco123';

grant select,insert,update on campamento.clientes to 'Dolores_de_Barriga'@'localhost';
grant select on campamento.pago_campamento to 'Dolores_de_Barriga'@'localhost';

grant select,insert,delete on campamento.pago_campamento to 'Paco_Mer'@'localhost';
grant select on campamento.clientes to 'Paco_Mer'@'localhost';

grant select,insert on campamento.* to 'PP_GRILLO'@'localhost';

select * from mysql.user;

show grants for 'PP_GRILLO'@'localhost';

revoke insert on campamento.* from 'PP_GRILLO'@'localhost';

alter user 'PP_GRILLO'@'localhost' identified by '5012';

grant update on campamento.* to 'PP_GRILLO'@'localhost';

create user 'super_admin'@'localhost' identified by 'Sadmin';
grant all privileges on *.* to 'super_admin'@'localhost';
show grants for 'super_admin'@'localhost';

grant insert,select,update,delete on campamento.clientes to 'PP_GRILLO'@'localhost';

grant select on campamento.pago_campamneto to 'PP_GRILLO'@'localhost';

-- ------------------------------------ --
-- Parte 2 --
-- ------------------------------------ --
