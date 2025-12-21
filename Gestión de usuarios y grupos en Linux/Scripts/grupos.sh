#!/bin/bash

while IFS=, read -r nombre Descripcion
do
  groupadd -f "${nombre}" >/dev/null 2>&1
done < <(tail -n +2 GruposSistema.csv)
