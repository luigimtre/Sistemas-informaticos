#Campos del CSV:
#Name*Surname*Surname1*Surname2*Account*Path*Group*DNI*Departament*Enabled*Password*ExpirationAccount*Email*NetTime*Computer

#Dominio
$domain="DC=ieselcaminas,DC=mylocal"

#Cargar módulo AD
Import-Module ActiveDirectory

$fichero = Import-Csv -Path ".\usuarios.csv" -Delimiter "*"

foreach($linea in $fichero)
{
    #Contraseña
    $pass = ConvertTo-SecureString $linea.Password -AsPlainText -Force

    #Apellidos
    $apellidos = $linea.Surname1 + " " + $linea.Surname2

    #Nombre completo
    $nombreCompleto = $linea.Name + " " + $apellidos

    #Habilitado
    $habilitado = $true
    if($linea.Enabled -eq "no") { $habilitado = $false }

    #Expiración (si es 0 no caduca)
    if($linea.ExpirationAccount -eq "0"){
        $fechaExp = $null
    } else {
        $fechaExp = (Get-Date).AddDays($linea.ExpirationAccount)
    }

    #Crear usuario
    New-ADUser `
        -SamAccountName $linea.Account `
        -UserPrincipalName ($linea.Account + "@ieselcaminas.mylocal") `
        -Name $linea.Account `
        -GivenName $linea.Name `
        -Surname $apellidos `
        -DisplayName $nombreCompleto `
        -EmailAddress $linea.Email `
        -AccountPassword $pass `
        -Enabled $habilitado `
        -Path $linea.Path `
        -ChangePasswordAtLogon $true `
        -AccountExpirationDate $fechaExp

    #Añadir al grupo
    Add-ADGroupMember -Identity $linea.Group -Members $linea.Account

    #Asignar equipo
    if (![string]::IsNullOrWhiteSpace($linea.Computer)) {
        Set-ADUser -Identity $linea.Account -LogonWorkstations $linea.Computer.Trim()
    }
    
    #Horario
    if($linea.NetTime -ne ""){
        $horario = $linea.NetTime -replace(" ","")
        net user $linea.Account /times:$horario
    }
}

Write-Host "Usuarios creados correctamente en el dominio $domain"