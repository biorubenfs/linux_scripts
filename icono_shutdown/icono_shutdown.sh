# Este script crea un icono de apagado en el escritorio


getUsername=`whoami`
echo $getUsername

# Crea el fichero que hará de icono
touch /home/$getUsername/Escritorio/boton-apagado_bis.desktop

# Variable con la ruta absoluta del icono
iconPath=`find /home/$getUsername/Escritorio/ -name "boton-apagado_bis.desktop"`

echo '# boton-apagado.desktop #' >> $iconPath
echo 'FIN PROGRAMA'



#tip: Emplea Ctrl + Shif + / para comentar descomentar todas las líneas seleccionadas
# fichero a crear  

# boton-apagado.desktop
# [Desktop Entry]
# Version=1.0
# Name=Apagar
# Comment=Aceso directo del boton de apagado
# Exec=/sbin/shutdown -Ph now
# Icon=system-shutdown
# Terminal=false
# Type=Application
# Categories=Utility;Application;

