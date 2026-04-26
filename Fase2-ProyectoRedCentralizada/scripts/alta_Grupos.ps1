#CSV:
#Name:Path:Description:Category:Scope

#Dominio
$domain="DC=ieselcaminas,DC=mylocal"

$fichero = Import-Csv -Path ".\grupos.csv" -Delimiter ":"

#Crear grupos
foreach($linea in $fichero)
{
	New-ADGroup `
		-Name $linea.Name `
		-Description $linea.Description `
		-GroupCategory $linea.Category `
		-GroupScope $linea.Scope `
		-Path $linea.Path
}

Write-Host ""
Write-Host "Se han creado los grupos en el dominio $domain" -ForegroundColor Green
Write-Host ""