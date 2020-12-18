# Este script crea un icono de apagado en el escritorio de GNOME
# No sé si este método funciona para otros escritorios, así que lo 
# he limitado al escritorio GNOME.

desktop=`echo $XDG_CURRENT_DESKTOP | grep GNOME | cut -d':' -f2`
echo desktop

crearIcono() {

    # Obteniendo nombre usuario
    getUsername=`whoami`

    # Crea el fichero que hará de icono
    touch /home/$getUsername/Escritorio/boton-apagado2.desktop

    # Variable con la ruta absoluta del icono
    iconPath=`find /home/$getUsername/Escritorio/ -name "boton-apagado2.desktop"`

    #tip: Emplea Ctrl + Shif + / para comentar descomentar todas las líneas seleccionadas  

    # Editando el fichero
    echo '# boton-apagado.desktop #' >> $iconPath
    echo '[Desktop Entry]' >> $iconPath
    echo 'Version=1.0' >> $iconPath
    echo 'Name=Apagar' >> $iconPath
    echo 'Comment=Aceso directo del boton de apagado' >> $iconPath
    echo 'Exec=/sbin/shutdown -Ph now' >> $iconPath
    echo 'Icon=system-shutdown' >> $iconPath
    echo 'Terminal=false' >> $iconPath
    echo 'Type=Application' >> $iconPath
    echo 'Categories=Utility;Application;' >> $iconPath

    # Agregar fichero a .local/share/applications
    # Esto nos permite que podamos agregar el icono al dock de ubuntu
    #cp /home/$getUsername/Escritorio/boton-apagado /home/$getUsername/.local/share/applications

    cat ./penguin
}

if [ $desktop == 'GNOME' ]; then
    echo "El escritorio es GNOME"
    crearIcono
else
    echo "El escritorio no es GNOME"
    cat ./error
fi

# cat ./penguin
