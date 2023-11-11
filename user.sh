#!/bin/bash

# Comprobamos si el script se ejecuta como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script como superusuario (root)."
  exit 1
fi

# Menú principal
while true; do
  echo "1. Agregar nuevo usuario"
  echo "2. Establecer contraseña de usuario"
  echo "3. Eliminar usuario"
  echo "4. Salir"
  read -p "Seleccione una opción: " opcion

  case $opcion in
    1) agregar_usuario ;;
    2) establecer_contrasena ;;
    3) eliminar_usuario ;;
    4) echo "Saliendo. Adiós."; break ;;
    *) echo "Opción no válida. Inténtelo de nuevo." ;;
  esac
done

# Función para agregar un nuevo usuario
agregar_usuario() {
  read -p "Ingrese el nombre del nuevo usuario: " nuevo_usuario
  useradd -m "$nuevo_usuario"
  echo "Usuario $nuevo_usuario agregado correctamente."
}

# Función para establecer la contraseña de un usuario
establecer_contrasena() {
  read -p "Ingrese el nombre de usuario al que desea establecer la contraseña: " usuario
  passwd "$usuario"
  echo "Contraseña para el usuario $usuario actualizada correctamente."
}

# Función para eliminar un usuario
eliminar_usuario() {
  read -p "Ingrese el nombre de usuario que desea eliminar: " usuario_a_eliminar
  userdel -r "$usuario_a_eliminar"
  echo "Usuario $usuario_a_eliminar eliminado correctamente."
}

# Menú principal
while true; do
  echo "1. Agregar nuevo usuario"
  echo "2. Establecer contraseña de usuario"
  echo "3. Eliminar usuario"
  echo "4. Salir"
  read -p "Seleccione una opción: " opcion

