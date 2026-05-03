# Compartición de carpetas del gestor documental

New-SmbShare -Name "Ciclos" -Path "E:\Ciclos" -FullAccess "GG-Ciclos" -ReadAccess "GG-ESOBAT","GG-Direccion","GG-Profesorado"

New-SmbShare -Name "ESOBAT" -Path "E:\ESOBAT" -FullAccess "GG-ESOBAT" -ReadAccess "GG-Ciclos","GG-Direccion","GG-Profesorado"

New-SmbShare -Name "Direccion" -Path "E:\Direccion" -FullAccess "GG-Direccion" -ReadAccess "GG-Ciclos","GG-ESOBAT","GG-Profesorado"

New-SmbShare -Name "Profesorado" -Path "E:\Profesorado" -FullAccess "GG-Profesorado" -ReadAccess "GG-Ciclos","GG-ESOBAT","GG-Direccion"