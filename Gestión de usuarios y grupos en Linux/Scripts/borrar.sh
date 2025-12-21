#!/bin/bash

# 1. Borrar Usuarios
while IFS=, read -r login password nombre apellido1 apellido2 descripcion departamento
do
  userdel -r "$login" 2>/dev/null
done < <(tail -n +2 UsuariosSistema.csv | tr -d '\r')

# 2. Borrar Grupos
while IFS=, read -r nombre Descripcion
do
  groupdel "$nombre" 2>/dev/null
done < <(tail -n +2 GruposSistema.csv | tr -d '\r')
