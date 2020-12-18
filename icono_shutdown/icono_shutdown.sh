# Este script crea un icono de apagado en el escritorio de GNOME
# No sé si este método funciona para otros escritorios, así que lo 
# he limitado al escritorio GNOME.

clear

desktop=`echo $XDG_CURRENT_DESKTOP | grep GNOME | cut -d':' -f1`

crearIcono() {

    echo "Recopilando información..."
    # Obteniendo nombre usuario
    getUsername=`whoami`

    echo "Generando archivos..."
    # Crea el fichero que hará de icono
    touch /home/$getUsername/Escritorio/boton-apagado.desktop

    # Variable con la ruta absoluta del icono
    iconPath=`find /home/$getUsername/Escritorio/ -name "boton-apagado.desktop"`

    #tip: Emplea Ctrl + Shif + / para comentar descomentar todas las líneas seleccionadas  

    # Editando el fichero
    echo '# boton-apagado.desktop #' >> $iconPath
    echo '[Desktop Entry]' >> $iconPath
    echo 'Version=1.0' >> $iconPath
    echo 'Name=Apagar' >> $iconPath
    echo 'Comment=Acceso directo del boton de apagado' >> $iconPath
    echo 'Exec=/sbin/shutdown -Ph now' >> $iconPath
    echo 'Icon=system-shutdown' >> $iconPath
    echo 'Terminal=false' >> $iconPath
    echo 'Type=Application' >> $iconPath
    echo 'Categories=Utility;Application;' >> $iconPath

    # Agregar fichero a .local/share/applications
    # Esto nos permite que podamos agregar el icono al dock de ubuntu
    cp /home/$getUsername/Escritorio/boton-apagado /home/$getUsername/.local/share/applications

    echo "El icono se ha creado correctamente."
    echo "La primera vez que ejecute el lanzador se le pedirá permiso"
}

if [ $desktop == 'GNOME' ]; then
    echo "El escritorio es GNOME"
    crearIcono
    cat ./penguin
else
    echo "El escritorio no es GNOME"
    echo "No es seguro crear el icono"
    echo "No se ha creado el icono"
    cat ./error
    echo ""
fi

echo "El programa ha finalizado"