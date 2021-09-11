
INSERT INTO TIPO_EVENTO (desc_tipo_evento) VALUES ("CASO"); --este es id_tipo_evento = 1;---
INSERT INTO TIPO_EVENTO (desc_tipo_evento) VALUES ("VISITA");  --este es id_tipo_evento = 2;---

---------------------VISTAS------------------------
CREATE OR REPLACE VIEW consultaCasosxVeterinaria AS 
	SELECT 	nombre_usuario AS nombre_veterinaria, 
			desc_evento AS tipo_caso, 
			nombre_mascota,
	FROM EVENTO 
	WHERE EVENTO_MASCOTA.id_mascota = MASCOTA.id_mascota AND
		  EVENTO_MASCOTA.id_evento = EVENTO.id_evento AND
		  EVENTO.id_tipo_evento = 1;


CREATE OR REPLACE VIEW consultarVisitasxVeterinaria AS
	SELECT 	nombre_usuario AS nombre_veterinaria, 
			desc_evento AS tipo_caso, 
			nombre_mascota,
	FROM EVENTO 
	WHERE EVENTO_MASCOTA.id_mascota = MASCOTA.id_mascota AND
		  EVENTO_MASCOTA.id_evento = EVENTO.id_evento AND
		  EVENTO.id_tipo_evento = 2;