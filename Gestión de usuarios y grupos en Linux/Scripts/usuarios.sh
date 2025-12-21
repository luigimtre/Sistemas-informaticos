#!/bin/bash

while IFS=, read -r login password nombre apellido1 apellido2 descripcion departamento
do
  
  u_login=$(echo "$login" | tr -d '\r' | xargs)
  u_pass=$(echo "$password" | tr -d '\r' | xargs)
  u_dep=$(echo "$departamento" | tr -d '\r' | xargs)
  u_comment="${nombre} ${apellido1} ${apellido2}"

  
  if [ -z "$u_login" ]; then continue; fi

 
  useradd -m -g "$u_dep" -c "$u_comment" "$u_login"
  echo "${u_login}:${u_pass}" | chpasswd
  chage -d 0 "$u_login"
  
  echo "Procesado: $u_login"
done < <(tail -n +2 UsuariosSistema.csv)
