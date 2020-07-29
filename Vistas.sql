
 create table empleado(
  id_emp number (10),  
  nombre varchar2(50),
  nivel_salarial number(1),
  profesion varchar2(30)
 );

create table cargo(
  codigo number(38),
  nombre varchar2(10),
  sueldo number(12),
  id_empleado number(10)
 );

Drop table cargo cascade constraint;
---Sin registro. Inserte registros superiores a los 10.000.000 de pesos

INSERT INTO empleado VALUES (1,'JUAN',1,'INGENIERO');



INSERT INTO empleado VALUES (2,'LUIS',3,'ADMINISTRADOR');

INSERT INTO empleado VALUES (3,'PABLO',2,'AUXILIAR');

INSERT INTO empleado VALUES (4,'CAMILO',2,'TECNICO');

INSERT INTO empleado VALUES (5,'DAVID',1,'VIGILANTE');

INSERT INTO empleado VALUES (6,'NATALIA',2,'PSICOLOGA');

INSERT INTO empleado VALUES (7,'PAULA',2,'VENDEDORA');

INSERT INTO empleado VALUES (8,'ANGUIE',1,'CONDUCTORA');

INSERT INTO empleado VALUES (9,'SARA',3,'GERENTE');

INSERT INTO empleado VALUES (10,'LORENZ',5,'PPRESIDENTA');

INSERT INTO empleado VALUES (11,'LAURA',5,'VICEPRECIDENTA');

INSERT INTO empleado VALUES (12,'OSCAR',4,'ABOGADO');

INSERT INTO empleado VALUES (13,'ANDRES',2,'PUBLICISTA');

INSERT INTO empleado VALUES (14,'LUZ',2,'ASESORA');

INSERT INTO empleado VALUES (15,'LILIANA',2,'TESTER');

SELECT * from empleado;



INSERT INTO cargo VALUES (1,'JUAN',280000,1);

INSERT INTO cargo VALUES (2,'LUIS',400000,2);

INSERT INTO cargo VALUES (3,'PABLO',300000,3);

INSERT INTO cargo VALUES (4,'CAMILO',330000,4);

INSERT INTO cargo VALUES (5,'DAVID',210000,5);

INSERT INTO cargo VALUES (6,'NATALIA',350000,6);

INSERT INTO cargo VALUES (7,'PAULA',350000,7);

INSERT INTO cargo VALUES (8,'ANGUIE',200000,8);

INSERT INTO cargo VALUES (9,'SARA',450000,9);

INSERT INTO cargo VALUES (10,'LORENZ',650000,10);

INSERT INTO cargo VALUES (11,'LAURA',600000,11);

INSERT INTO cargo VALUES (12,'OSCAR',500000,12);

INSERT INTO cargo VALUES (13,'ANDRES',320000,13);

INSERT INTO cargo VALUES (14,'LUZ',300000,14);

INSERT INTO cargo VALUES (15,'LILIANA',340000,15);

SELECT * from cargo;



/*PUNTO 1*/
/*Muestre la suma de todos los sueldos haciendo uso de un bloque
nominal*/
set serveroutput on;
<<Sumador>>
DECLARE
var1 number;
BEGIN
select SUM(sueldo) into var1
from cargo  ;

DBMS_OUTPUT.PUT_LINE('la suma  de los  precios es: ' || var1 );

END;
/


/*PUNTO 2*/
/*Para los salarios de los empleados se realiza un incremento
dependiendo del cargo ocupado. El incremento es del 20%. Realice la
suma de los salarios ya incrementados y si esta supera los 20.000.000
millones de pesos, muestre un mensaje que diga “nomina supera los
20.000.000*/

set serveroutput on;

declare
bonificacionsalario number;
antiguosalario number;
bonificacionneta number;
var1 number;
begin 

FOR i IN 1..15 LOOP
select sueldo into antiguosalario
from cargo where codigo = i ;



bonificacionneta:=antiguosalario*0.2;    

bonificacionsalario:=antiguosalario+(antiguosalario*0.2);

DBMS_OUTPUT.PUT_LINE('el codigo es: ' || i ||'el salario antiguo es: ' || antiguosalario ||'la cantidad a incrementar es: ' || bonificacionneta ||'salario nuevo con bonificacion: ' || bonificacionsalario );

UPDATE cargo SET sueldo = bonificacionsalario WHERE codigo = i;
END LOOP;

select SUM(sueldo) into var1
from cargo  ;

if var1 > 20000000 then
DBMS_OUTPUT.PUT_LINE('nomina supera los
20.000.000');
end if;

end;
/

select sueldo from cargo;


/*PUNTO 3*/
/*Se necesita incrementar los sueldos en forma proporcional, en un 5%
cada vez y controlar que el sueldo máximo alcance o supere los
$1.000.000, al llegar o superarlo, el bucle debe finalizar. Incluya una
variable contador que cuente cuántas veces se repite el bucle (sentencia
exit when)*/


set serveroutput on;

declare
bonificacionsalario number;
antiguosalario number;
bonificacionneta number;
var1 number :=0;
begin 

LOOP
var1:=var1+1;

FOR i IN 1..15 LOOP
select sueldo into antiguosalario
from cargo where codigo = i ;



bonificacionneta:=antiguosalario*0.05;    

bonificacionsalario:=antiguosalario+(antiguosalario*0.05);



DBMS_OUTPUT.PUT_LINE('el codigo es: ' || i ||'el salario antiguo es: ' || antiguosalario ||'la cantidad a incrementar es: ' || bonificacionneta ||'salario nuevo con incremento: ' || bonificacionsalario );

UPDATE cargo SET sueldo = bonificacionsalario WHERE codigo = i;
if bonificacionsalario >1000000 then
exit;
end if;

END LOOP;

if bonificacionsalario >1000000 then
DBMS_OUTPUT.PUT_LINE('numero de iteraciones'|| var1);
exit;
end if;
END LOOP;
end;
/
select sueldo from cargo;

/*PUNTO 4*/

/*Imprima los resultados de los empleados y de los cargos con sus
respectivos salarios actualizados. Si la suma de estos salarios es inferior
a 15.000.000 muestre aquellos que cumplan con esta condición y
descuente el 3% del salario*/

SELECT DISTINCT cargo.codigo ,cargo.nombre, cargo.sueldo, cargo.id_empleado, empleado.nivel_salarial , empleado.profesion
FROM cargo
INNER JOIN empleado ON cargo.codigo=empleado.id_emp
ORDER BY cargo.codigo ASC;


set serveroutput on;

declare
viejosalario number;
salariodescontar number;
nuevosalario number;
var1 number;
begin 


select SUM(sueldo) into var1
from cargo  ;
DBMS_OUTPUT.PUT_LINE('Los sueldos sumados  dan un total de: ' || var1 );




if var1 < 6000000 then

FOR i IN 1..15 LOOP
select sueldo into viejosalario
from cargo where codigo = i ;


salariodescontar:=viejosalario*0.03;    

nuevosalario:=viejosalario-(viejosalario*0.03);



DBMS_OUTPUT.PUT_LINE('el codigo es: ' || i ||'el salario antiguo es: ' || viejosalario ||'la cantidad a incrementar es: ' || salariodescontar ||'salario nuevo con descuento: ' || nuevosalario);
UPDATE cargo SET sueldo = nuevosalario WHERE codigo = i;
END LOOP;
end if;


end;
/

select sueldo from cargo;

/*PUNTO 5*/

/*Muestre resultados nuevamente.*/

SELECT DISTINCT cargo.codigo ,cargo.nombre, cargo.sueldo, cargo.id_empleado, empleado.nivel_salarial , empleado.profesion
FROM cargo
INNER JOIN empleado ON cargo.codigo=empleado.id_emp
ORDER BY cargo.codigo ASC;

