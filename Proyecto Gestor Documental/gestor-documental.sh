#!/bin/bash 
# Proyecto: Gestor Documental IES Camp de Morvedre

# --- 1. La creación de los usuarios/grupos ---
fntFuncion1() {
    echo "--- Creando Grupos y Usuarios ---"
    groupadd ESO
    groupadd BACH

    # ESO
    for i in 1 2 3 4; do
        groupadd ${i}ESO
        useradd -g ${i}ESO -G ESO -s /bin/bash ${i}ESO
        echo "${i}ESO:M0rv32026" | chpasswd
    done

    # BACH
    groupadd 1BACH; groupadd 2BACH
    useradd -g 1BACH -G BACH -s /bin/bash 1BACH
    echo "1BACH:M0rv32026" | chpasswd
    useradd -g 2BACH -G BACH -s /bin/bash 2BACH
    echo "2BACH:M0rv32026" | chpasswd

    # DAW y Otros
    groupadd 1DAW
    useradd -g 1DAW -G sudo -s /bin/bash 1DAW
    echo "1DAW:M0rv32026" | chpasswd

    groupadd alumnado; groupadd profesorado; groupadd administrador
    useradd -g alumnado -G users -s /bin/bash alumnado
    echo "alumnado:M0rv32026" | chpasswd
    useradd -g profesorado -G users -s /bin/bash profesorado
    echo "profesorado:M0rv32026" | chpasswd
    useradd -g administrador -G sudo -s /bin/bash administrador
    echo "administrador:M0rv32026" | chpasswd

    # Seguridad GDM: Ocultar lista de usuarios
    sudo apt install dbus-x11 -y
    sudo xhost +SI:localuser:gdm
    sudo -u gdm gsettings set org.gnome.login-screen disable-user-list true
    echo "Usuarios y seguridad configurados."
}

# --- 2. La creación de la estructura de directorios ---
fntFuncion2() {
    echo "--- Creando Estructura en /media/lgimenez/Publico ---"
    mkdir -p /media/lgimenez/Publico/{ESO/{1,2,3,4}ESO,BACH/{1,2}BACH,DAW/1DAW} && touch /media/lgimenez/Publico/ESO/{1,2,3,4}ESO/doc.dat /media/lgimenez/Publico/BACH/{1,2}BACH/doc.dat /media/lgimenez/Publico/DAW/1DAW/doc.dat

    chmod 755 /media/lgimenez/Publico
    echo "Estructura y archivos creados."
}

# --- 3. Establecer los permisos en la estructura ---
fntFuncion3() {
    # 1. Seguridad base:
    chmod 750 /media/lgimenez/Publico

    # 2. ACCESO TOTAL PARA 1DAW 
    setfacl -R -m g:1DAW:rwx /media/lgimenez/Publico
    setfacl -R -d -m g:1DAW:rwx /media/lgimenez/Publico

    # 3. Visibilidad para ESO y BACH en la raíz 
    setfacl -m g:ESO:rx /media/lgimenez/Publico
    setfacl -m g:BACH:rx /media/lgimenez/Publico

    # 4. AISLAMIENTO CARPETA DAW:
    # Esto responde a tu última petición: DAW es invisible para ellos
    setfacl -m g:ESO:--- /media/lgimenez/Publico/DAW
    setfacl -m g:BACH:--- /media/lgimenez/Publico/DAW

    # 5. CONFIGURACIÓN ESO
    setfacl -m g:ESO:rx /media/lgimenez/Publico/ESO
    setfacl -m g:ESO:--- /media/lgimenez/Publico/BACH  # No ven BACH

    for i in 1 2 3 4; do
        # Permisos para el alumno del curso
        setfacl -R -m u:${i}ESO:rwx /media/lgimenez/Publico/ESO/${i}ESO
        # Lectura para el resto de la etapa ESO
        setfacl -R -m g:ESO:rx /media/lgimenez/Publico/ESO/${i}ESO
        # REFUERZO: DAW edita todo
        setfacl -R -m g:1DAW:rwx /media/lgimenez/Publico/ESO/${i}ESO
    done

    # 6. CONFIGURACIÓN BACH
    setfacl -m g:BACH:rx /media/lgimenez/Publico/BACH
    setfacl -m g:BACH:--- /media/lgimenez/Publico/ESO   # No ven ESO

    for i in 1 2; do
        # Permisos para el alumno del curso
        setfacl -R -m u:${i}BACH:rwx /media/lgimenez/Publico/BACH/${i}BACH
        # Lectura para el resto de la etapa BACH
        setfacl -R -m g:BACH:rx /media/lgimenez/Publico/BACH/${i}BACH
        # REFUERZO: DAW edita todo
        setfacl -R -m g:1DAW:rwx /media/lgimenez/Publico/BACH/${i}BACH
    done

    echo "Permisos actualizados"
}

# --- 4. Funcionalidad extra: Estado del espacio ---
fntFuncion4() {
    echo "--- Estado del Disco de 2GB ---"
    du -sh /media/lgimenez/Publico/*
    df -h /media/lgimenez/Publico
}

# --- 5. Menú Principal ---
opcion=""
while [ "$opcion" != "5" ]; do
    clear
    echo "********************************************"
    echo "* GESTOR DOCUMENTAL - IES CAMP MORVEDRE  *"
    echo "********************************************"
    echo "1) Creación de usuarios/grupos"
    echo "2) Creación gestor documental (disco 2GB)"
    echo "3) Establecer permisos en la estructura"
    echo "4) Funcionalidad extra: Consultar Espacio"
    echo "5) Salir de la aplicación"
    echo " "
    read -p "Elija una opción [1-5]: " opcion

    case $opcion in
        1) fntFuncion1 ;;
        2) fntFuncion2 ;;
        3) fntFuncion3 ;;
        4) fntFuncion4 ;;
        5) exit 0 ;;
    esac
    read -p "Presione Enter para continuar..."
done

