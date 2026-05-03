$usuario = $env:USERNAME
$servidor = "MASTER-CAMINAS"

Net Use F: /delete /y 2>$null
Net Use G: /delete /y 2>$null
Net Use H: /delete /y 2>$null
Net Use I: /delete /y 2>$null

$grupos = ([System.Security.Principal.WindowsIdentity]::GetCurrent()).Groups | ForEach-Object {
    $_.Translate([System.Security.Principal.NTAccount]).Value
}

if ($grupos -like "*Direccion*") {
    Net Use F: \\$servidor\Direccion /persistent:yes
    Net Use G: \\$servidor\Profesorado /persistent:yes
    Net Use H: \\$servidor\Ciclos /persistent:yes
    Net Use I: \\$servidor\ESOBAT /persistent:yes
    $mensaje = "Usuario $usuario, la unidad F: es tu directorio en el servidor en modo lectura/escritura y las G:, H: e I: en sólo lectura."
}
elseif ($grupos -like "*Profesorado*") {
    Net Use F: \\$servidor\Profesorado /persistent:yes
    Net Use G: \\$servidor\Direccion /persistent:yes
    Net Use H: \\$servidor\Ciclos /persistent:yes
    Net Use I: \\$servidor\ESOBAT /persistent:yes
    $mensaje = "Usuario $usuario, la unidad F: es tu directorio en el servidor en modo lectura/escritura y las G:, H: e I: en sólo lectura."
}
elseif ($grupos -like "*Ciclos*") {
    Net Use F: \\$servidor\Ciclos /persistent:yes
    Net Use G: \\$servidor\Direccion /persistent:yes
    Net Use H: \\$servidor\Profesorado /persistent:yes
    Net Use I: \\$servidor\ESOBAT /persistent:yes
    $mensaje = "Usuario $usuario, la unidad F: es tu directorio en el servidor en modo lectura/escritura y las G:, H: e I: en sólo lectura."
}
elseif ($grupos -like "*ESOBAT*") {
    Net Use F: \\$servidor\ESOBAT /persistent:yes
    Net Use G: \\$servidor\Direccion /persistent:yes
    Net Use H: \\$servidor\Profesorado /persistent:yes
    Net Use I: \\$servidor\Ciclos /persistent:yes
    $mensaje = "Usuario $usuario, la unidad F: es tu directorio en el servidor en modo lectura/escritura y las G:, H: e I: en sólo lectura."
}

msg * $mensaje