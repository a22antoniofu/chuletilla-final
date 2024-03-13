<# Dada una unidad como base, la idea es que nos vaya entrando en los grupos siguientes o unidades que tenga dentro.
Podría ser interesante por ejemplo que luego la formateara en md, o algo similar, que permite una lectura eficiente.#>

$ouraiz=Read-Host "Introduce la OU raiz en x500: "
# Se elimina la tilde por razones de codificación.

$ouraiz=$ouraiz -replace "á","a"
$ouraiz=$ouraiz -replace "é","e"
$ouraiz=$ouraiz -replace "í","i"
$ouraiz=$ouraiz -replace "ó","o"
$ouraiz=$ouraiz -replace "ú","u"
$ouraiz=$ouraiz -replace "ñ","n"

# Se muestra la OU raíz introducida
Write-Host "La OU raíz introducida es: $ouraiz"

# Se obtienen los grupos de la OU raíz
$grupos=Get-ADGroup -Filter * -SearchBase $ouraiz | fl Name,DistinguishedName
<# VALE, FALTA VER EN QUE FORMATO SALEN LOS GRUPOS, Y COMO SE PUEDE HACER QUE SE VAYAN METIENDO EN UNA LISTA, Y QUE SE VAYAN METIENDO EN UNA LISTA LOS GRUPOS QUE TIENEN DENTRO, Y ASÍ SUCESIVAMENTE.
buscar un type en powershell. #>