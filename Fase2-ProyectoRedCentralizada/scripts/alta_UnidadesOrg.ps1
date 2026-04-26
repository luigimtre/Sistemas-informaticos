#CSV:
#Name:Description:Path

#Dominio
$domain="DC=ieselcaminas,DC=mylocal"

$fichero = Import-Csv -Path ".\unidades_org.csv" -Delimiter ":"

#Recorrer líneas
foreach($line in $fichero)
{
    New-ADOrganizationalUnit `
        -Name $line.Name `
        -Description $line.Description `
        -Path $line.Path `
        -ProtectedFromAccidentalDeletion $true
}

Write-Host "Se han creado las UOs correctamente en el dominio $domain"