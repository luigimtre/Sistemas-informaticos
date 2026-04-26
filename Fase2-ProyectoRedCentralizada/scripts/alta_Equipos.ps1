#CSV:
#Computer:Path

#Dominio
$domain="DC=ieselcaminas,DC=mylocal"

$fichero = Import-Csv -Path ".\equipos.csv" -Delimiter ":"

#Crear equipos
foreach($line in $fichero)
{
	New-ADComputer `
		-Name $line.Computer `
		-SamAccountName $line.Computer `
		-Enabled $true `
		-Path $line.Path
}

Write-Host ""
Write-Host "Se han creado los equipos en el dominio $domain" -ForegroundColor Green
Write-Host ""