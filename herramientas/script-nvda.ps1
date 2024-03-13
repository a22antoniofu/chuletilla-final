Set-ExecutionPolicy Bypass -Scope Process -Force

# Instalación del lector de pantalla

try {
    Start-Process winget -ArgumentList "install", "-e", "--id=NVAccess.NVDA" -Wait
}
catch {
    # En caso de fallo, se instala chocolatey y se busca el paquete nvda

    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    choco install nvda --confirm=$false
}

# Habilitar el servicio de sonido y hacer que se inicie automáticamente
restart-service audiosrv
set-service -name audiosrv -startuptype automatic

# Descarga y descompresión de complementos
invoke-webrequest -uri http://154.16.115.204/complementos-nvda.7z -outfile $env:userprofile\Desktop\complementos-nvda.7z

# Instalación de 7-zip
try {
    Start-Process winget -ArgumentList "install", "-e", "--id=7zip.7zip" -Wait
}
catch {
    choco install 7zip --confirm=$false
}

Start-Process -FilePath 'C:\Program Files\7-zip\7z.exe' -ArgumentList "x", "$env:userprofile\Desktop\complementos-nvda.7z", "-o$env:userprofile\Desktop\complementos" -Wait 
# Los complementos se encuentran en un fichero 7-zip

# Eliminación de ficheros innecesarios
Remove-Item -Path "$env:userprofile\Desktop\complementos-nvda.7z" -Force

# Instalación de complementos
#Start-Process -FilePath 'C:\Program Files\NVDA\nvda.exe' -ArgumentList "-install", "$env:userprofile\Desktop\complementos\complementos-nvda\complementos" -Wait