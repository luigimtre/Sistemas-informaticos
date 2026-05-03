# Crear estructura de carpetas
New-Item -Path "E:\Ciclos" -ItemType Directory -Force
New-Item -Path "E:\ESOBAT" -ItemType Directory -Force
New-Item -Path "E:\Direccion" -ItemType Directory -Force
New-Item -Path "E:\Profesorado" -ItemType Directory -Force

# Permisos básicos
icacls "E:\Ciclos" /inheritance:r
icacls "E:\Ciclos" /grant "GG-Ciclos:(OI)(CI)M"
icacls "E:\Ciclos" /grant "GG-ESOBAT:(OI)(CI)R"
icacls "E:\Ciclos" /grant "GG-Direccion:(OI)(CI)R"
icacls "E:\Ciclos" /grant "GG-Profesorado:(OI)(CI)R"

icacls "E:\ESOBAT" /inheritance:r
icacls "E:\ESOBAT" /grant "GG-ESOBAT:(OI)(CI)M"
icacls "E:\ESOBAT" /grant "GG-Ciclos:(OI)(CI)R"
icacls "E:\ESOBAT" /grant "GG-Direccion:(OI)(CI)R"
icacls "E:\ESOBAT" /grant "GG-Profesorado:(OI)(CI)R"

icacls "E:\Direccion" /inheritance:r
icacls "E:\Direccion" /grant "GG-Direccion:(OI)(CI)M"
icacls "E:\Direccion" /grant "GG-Ciclos:(OI)(CI)R"
icacls "E:\Direccion" /grant "GG-ESOBAT:(OI)(CI)R"
icacls "E:\Direccion" /grant "GG-Profesorado:(OI)(CI)R"

icacls "E:\Profesorado" /inheritance:r
icacls "E:\Profesorado" /grant "GG-Profesorado:(OI)(CI)M"
icacls "E:\Profesorado" /grant "GG-Ciclos:(OI)(CI)R"
icacls "E:\Profesorado" /grant "GG-ESOBAT:(OI)(CI)R"
icacls "E:\Profesorado" /grant "GG-Direccion:(OI)(CI)R"