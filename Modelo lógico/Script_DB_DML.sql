
INSERT INTO TIPO_EVENTO (desc_tipo_evento) VALUES ("CASO"); --este es id_tipo_evento = 1;---
INSERT INTO TIPO_EVENTO (desc_tipo_evento) VALUES ("VISITA");  --este es id_tipo_evento = 2;---

---------------------VISTAS------------------------
CREATE OR REPLACE VIEW consultaCasosxVeterinaria AS 
	SELECT 	nombre_usuario AS nombre_veterinaria, 
			desc_evento AS tipo_caso, 
			nombre AS nombre_mascota
	FROM "EVENTO", "USUARIO", "MASCOTA", "EVENTO_MASCOTA"
	WHERE "EVENTO_MASCOTA".id_mascota = "MASCOTA".id_mascota AND
		  "EVENTO_MASCOTA".id_evento = "EVENTO".id_evento AND
		  "EVENTO".id_tipo_evento = 1;
		  
		  
CREATE OR REPLACE VIEW consultarVisitasxVeterinaria AS
	SELECT 	nombre_usuario AS nombre_veterinaria, 
			desc_evento AS tipo_caso, 
			nombre AS nombre_mascota
	FROM "EVENTO", "USUARIO", "MASCOTA", "EVENTO_MASCOTA"
	WHERE "EVENTO_MASCOTA".id_mascota = "MASCOTA".id_mascota AND
		  "EVENTO_MASCOTA".id_evento = "EVENTO".id_evento AND
		  "EVENTO".id_tipo_evento = 2;
		  
create trigger AUDITORIA_MASCOTA
after insert or update or delete on "MASCOTA"
for each row EXECUTE PROCEDURE mascota_trig();


CREATE FUNCTION mascota_trig() RETURNS trigger AS $mas_tr$
    BEGIN
IF UPDATING then
insert into MASCOTA_AU values(old.id_mascota, old.nombre, old.edad, old.especie, old.tamaño, old.sexo, old.potencialmente_peligroso, old.fotografia_medica, old.microchip,  'Actualizar', sysdate);

END IF;

if deleting then

insert into MASCOTA_AU values(old.id_mascota, old.nombre, old.edad, old.especie, old.tamaño, old.sexo, old.potencialmente_peligroso, old.fotografia_medica, old.microchip,  'Actualizar', sysdate);


END IF;

if inserting then

insert into MASCOTA_AU values(new.id_mascota, new.nombre, new.edad, new.especie, new.tamaño, new.sexo, new.potencialmente_peligroso, new.fotografia_medica, new.microchip,  'Actualizar', sysdate);

END IF;
END;
$mas_tr$ LANGUAGE plpgsql;

create trigger CHIP_MASCOTA
after insert or update on "MASCOTA"
for each row EXECUTE PROCEDURE chip();

CREATE FUNCTION chip() RETURNS trigger AS $mchip_tr$
    BEGIN


if inserting or updating then

	if old.microchip is not null then
		insert into MASCOTA values(new.id_mascota, new.nombre, new.edad, new.especie, new.tamaño, new.sexo, new.potencialmente_peligroso, new.fotografia_medica, new.microchip);
	else
		raise notice'Ya se ha insertado microchip';
	END IF;
END IF;

END
$mchip_tr$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION meta_chip(x date, y date)
  RETURNS void AS
$func$
DECLARE
conteo integer;

begin
conteo = 'select count(id_evento) from "EVENTO"
where fecha between '||x 'and'||y;


insert into "MICROCHIPS_GOALS"(init_date,end_date, conteo) 
values(|| x, ||y,||conteo);

end
$func$  LANGUAGE plpgsql;