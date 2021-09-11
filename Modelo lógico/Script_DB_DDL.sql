
CREATE DATABASE "Ciudadanos de 4 Patas";

CREATE TABLE "ASIG_PROPIETARIO_MASCOTA" (
  "id_usuario" INTEGER NOT NULL DEFAULT 0, 
  "id_mascota" INTEGER NOT NULL DEFAULT 0, 
  PRIMARY KEY ("id_usuario", "id_mascota")
);

CREATE INDEX "ASIG_PROPIETARIO_MASCOTA_MASCOTA" ON "ASIG_PROPIETARIO_MASCOTA" ("id_mascota");
CREATE INDEX "ASIG_PROPIETARIO_MASCOTA_PK" ON "ASIG_PROPIETARIO_MASCOTA" ("id_usuario");

--------------------------------------------------------------------------------------

CREATE TABLE "EVENTO" (
  "id_evento" SERIAL NOT NULL, 
  "id_tipo_evento" INTEGER DEFAULT 0, 
  "desc_evento" VARCHAR(255), 
  PRIMARY KEY ("id_evento")
);

CREATE INDEX "EVENTO_TIPO" ON "EVENTO" ("id_tipo_evento");

--------------------------------------------------------------------------------------

CREATE TABLE "EVENTO_MASCOTA" (
  "id_evento_mascota" SERIAL NOT NULL, 
  "id_mascota" INTEGER DEFAULT 0, 
  "id_veterinaria" INTEGER DEFAULT 0, 
  "id_evento" INTEGER DEFAULT 0, 
  "fecha_evento" TIMESTAMP, 
  PRIMARY KEY ("id_evento_mascota")
);

CREATE INDEX "EVENTO_VETERINARIA_FK" ON "EVENTO_MASCOTA" ("id_veterinaria");

--------------------------------------------------------------------------------------

CREATE TABLE "MASCOTA" (
  "id_mascota" SERIAL NOT NULL, 
  "nombre" VARCHAR(255), 
  "edad" INTEGER DEFAULT 0, 
  "especie" VARCHAR(255), 
  "tamaño" INTEGER DEFAULT 0, 
  "sexo" INTEGER DEFAULT 0, 
  "potencialmente_peligroso" BOOLEAN DEFAULT E'0', 
  "fotografia_medica" TEXT, 
  "microchip" VARCHAR(255), 
  PRIMARY KEY ("id_mascota")
);

CREATE INDEX "MASCOTA_POTENCIAL" ON "MASCOTA" ("potencialmente_peligroso");
CREATE INDEX "MASCOTA_PRIMARY_KEY" ON "MASCOTA" ("id_mascota");
--------------------------------------------------------------------------------------

CREATE TABLE "SEXO" (
  "id_sexo" SERIAL NOT NULL, 
  "desc_sexo" VARCHAR(255), 
  PRIMARY KEY ("id_sexo")
);

--------------------------------------------------------------------------------------

CREATE TABLE "TIPO_EVENTO" (
  "id_tipo_evento" SERIAL NOT NULL, 
  "desc_tipo_evento" VARCHAR(255), 
  PRIMARY KEY ("id_tipo_evento")
);

--------------------------------------------------------------------------------------

CREATE TABLE "TIPO_DOCUMENTO" (
  "id_tipo_documento" SERIAL NOT NULL, 
  "desc_tipo_documento" VARCHAR(255), 
  PRIMARY KEY ("id_tipo_documento")
);

CREATE INDEX "TIPO_DOCUMENTO_PK" ON "TIPO_DOCUMENTO" ("id_tipo_documento");

--------------------------------------------------------------------------------------

CREATE TABLE "TIPO_USUARIO" (
  "id_tipo_usuario" SERIAL NOT NULL, 
  "desc_tipo_usuario" VARCHAR(255), 
  PRIMARY KEY ("id_tipo_usuario")
);
--------------------------------------------------------------------------------------

CREATE TABLE "USUARIO" (
  "num_documento" INTEGER NOT NULL DEFAULT 0, 
  "tipo_Documento" INTEGER DEFAULT 0, 
  "tipo_Usuario" INTEGER DEFAULT 0, 
  "nombre_usuario" VARCHAR(255), 
  "telefono_usuario" VARCHAR(255), 
  "correo_Electrónico" VARCHAR(255), 
  "contraseña_usuario" TEXT, 
  "direccion_usuario" VARCHAR(255), 
  "barrio_usuario" VARCHAR(255), 
  "localidad_usuario" VARCHAR(255), 
  PRIMARY KEY ("num_documento")
);

CREATE INDEX "USUARIO_PK" ON "USUARIO" ("num_documento");


--------------------------------------------------------------------------------------
----------------------------  FOREIGN KEY --------------------------------------------
--------------------------------------------------------------------------------------

ALTER TABLE "USUARIO"
ADD CONSTRAINT fk_usuario_tipo_documento 
FOREIGN KEY ("tipo_Documento") 
REFERENCES "TIPO_DOCUMENTO" ("id_tipo_documento");


ALTER TABLE "USUARIO"
ADD CONSTRAINT fk_usuario_tipo_usuario 
FOREIGN KEY ("tipo_Usuario") 
REFERENCES "TIPO_USUARIO" ("id_tipo_usuario");

--------------------------------------------------------------------------------------

ALTER TABLE "MASCOTA"
ADD CONSTRAINT fk_mascota_sexo 
FOREIGN KEY ("sexo") 
REFERENCES "SEXO" ("id_sexo");

--------------------------------------------------------------------------------------

ALTER TABLE "EVENTO"
ADD CONSTRAINT fk_evento_tipo_evento 
FOREIGN KEY ("id_tipo_evento") 
REFERENCES "TIPO_EVENTO" ("id_tipo_evento");

--------------------------------------------------------------------------------------

ALTER TABLE "ASIG_PROPIETARIO_MASCOTA"
ADD CONSTRAINT fk_asig_propietario_mascota_propietario
FOREIGN KEY ("id_usuario") 
REFERENCES "USUARIO" ("num_documento");

--------------------------------------------------------------------------------------

ALTER TABLE "ASIG_PROPIETARIO_MASCOTA"
ADD CONSTRAINT fk_asig_propietario_mascota_mascota
FOREIGN KEY ("id_mascota") 
REFERENCES "MASCOTA" ("id_mascota");

--------------------------------------------------------------------------------------

ALTER TABLE "EVENTO_MASCOTA"
ADD CONSTRAINT fk_mascota_evento 
FOREIGN KEY ("id_mascota") 
REFERENCES "MASCOTA" ("id_mascota");

--------------------------------------------------------------------------------------

ALTER TABLE "EVENTO_MASCOTA"
ADD CONSTRAINT fk_evento_evento 
FOREIGN KEY ("id_evento") 
REFERENCES "EVENTO" ("id_evento");
--------------------------------------------------------------------------------------

ALTER TABLE "EVENTO_MASCOTA"
ADD CONSTRAINT fk_evento_veterinaria 
FOREIGN KEY ("id_veterinaria") 
REFERENCES "USUARIO" ("num_documento");
--------------------------------------------------------------------------------------