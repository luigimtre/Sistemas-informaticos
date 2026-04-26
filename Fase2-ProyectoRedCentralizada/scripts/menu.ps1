$domain="DC=ieselcaminas,DC=mylocal"


if (!(Get-Module -Name ActiveDirectory))
{
    Import-Module ActiveDirectory
}


function Show-Menu
{
     param (
           [string]$Titulo = 'MENÚ PRINCIPAL'
     )

     Clear-Host
     Write-Host "================ $Titulo ================"
     Write-Host ""
     Write-Host "1: Crear UOs"
     Write-Host "2: Crear Grupos"
     Write-Host "3: Crear Usuarios"
     Write-Host "4: Crear Equipos"
     Write-Host "5: Consultar objetos del subsistema"
     Write-Host "Q: Salir"
     Write-Host ""
}


function alta_UOs
{
    .\alta_UnidadesOrg.ps1
}

function alta_grupos
{
    .\alta_Grupos.ps1
}

function alta_usuarios
{
    .\alta_Usuarios.ps1
}

function alta_equipos
{
    .\alta_Equipos.ps1
}


function consulta_objetos
{
    Clear-Host
    Write-Host "================ CONSULTA DEL SUBSISTEMA ================" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "---- UNIDADES ORGANIZATIVAS ----" -ForegroundColor Yellow
    Get-ADOrganizationalUnit -Filter * -SearchBase $domain |
        Format-Table Name, DistinguishedName -AutoSize

    Write-Host ""
    Write-Host "---- GRUPOS ----" -ForegroundColor Yellow
    Get-ADGroup -Filter * -SearchBase $domain |
        Format-Table Name, GroupScope -AutoSize

    Write-Host ""
    Write-Host "---- USUARIOS ----" -ForegroundColor Yellow
    Get-ADUser -Filter * -SearchBase $domain |
        Format-Table Name, SamAccountName, Enabled -AutoSize

    Write-Host ""
    Write-Host "---- EQUIPOS ----" -ForegroundColor Yellow
    Get-ADComputer -Filter * -SearchBase $domain |
        Format-Table Name, Enabled -AutoSize

    Write-Host ""
    Write-Host "Consulta finalizada correctamente." -ForegroundColor Green
}


do
{
     Show-Menu
     $opcion = Read-Host "Selecciona una opción"

     switch ($opcion)
     {
           '1' {
                Clear-Host
                alta_UOs
           }
           '2' {
                Clear-Host
                alta_grupos
           }
           '3' {
                Clear-Host
                alta_usuarios
           }
           '4' {
                Clear-Host
                alta_equipos
           }
           '5' {
                consulta_objetos
           }
           'q' {
                Write-Host "Saliendo de la aplicación..." -ForegroundColor Green
           }
     }

     Pause

}
until ($opcion -eq 'q')