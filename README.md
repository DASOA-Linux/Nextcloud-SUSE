# Instalador de Nextcloud para OpenSUSE Leap 15.5

Este repositorio contiene un script de instalación para configurar Nextcloud en un servidor que ejecuta OpenSUSE Leap 15.5. Nextcloud es una plataforma de colaboración en línea que te permite almacenar, sincronizar y compartir archivos, así como acceder a aplicaciones de productividad directamente desde tu servidor.

Requisitos:

Antes de ejecutar el script, asegúrate de que tu sistema cumple con los siguientes requisitos:

- OpenSUSE Leap 15.5 instalado y actualizado.
- Acceso a Internet para descargar paquetes y dependencias.

  

Instalación:

Clona este repositorio en tu servidor OpenSUSE Leap 15.5:

   git clone https://github.com/DASOA-Linux/Nextcloud-SUSE
   
En caso de no tener git disponible, puedes instalarlo con:
  
   zypper in git-core
   
Una vez clonado el repositorio accede al directorio con:

   cd Nextcloud-SUSE
   
Dale permiso de ejecución al script:

   chmod +x install.sh
   
Y lo ejecutas:
 
   ./install.sh
   
   
   
Otra opción es descargar directamente el script con:

   wget https://github.com/DASOA-Linux/Nextcloud-SUSE/blob/main/install.sh
   
Dar permiso de ejecución al script:

   chmod +x install.sh
   
Y ejecutar:
 
   ./install.sh
   


Una vez completada la instalación, podrás acceder a Nextcloud desde tu navegador web introduciendo la dirección IP de tu servidor seguida de "/nextcloud", con el usuario Admin y la contraseña dasoalinux.


##Desarrollado por:

DASOA Linux
https://www.dasoa.net

##Licencia
Este proyecto está bajo la Licencia Pública General de GNU, versión 3.0 (GNU GPL v3.0). Consulta el archivo LICENSE para obtener más información.


