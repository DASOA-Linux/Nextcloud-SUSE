#!/bin/bash

# Comprobamos si el script se ejecuta como root
if [ "$EUID" -ne 0 ]; then
  echo "Necesita ser superusuario (root) para ejecutar este script."
  exit 1
fi

# Función para agregar un nuevo usuario
agregar_usuario() {
  while true; do
    read -p "Nombre del nuevo usuario: " nuevo_usuario

    # Verificar si el nombre de usuario ya existe
    if id "$nuevo_usuario" >/dev/null 2>&1; then
      echo "Error: El usuario $nuevo_usuario ya existe. Por favor, elija otro nombre de usuario."
    else
      useradd -m "$nuevo_usuario"
      echo "El usuario $nuevo_usuario ha sido creado."

      read -p "¿Desea establecer una contraseña para $nuevo_usuario? (S/n): " establecer_contrasena

      case $establecer_contrasena in
        [Ss]*)
          passwd "$nuevo_usuario"
          echo "La contraseña de $nuevo_usuario se ha establecido correctamente."
          break
          ;;
        [Nn]*)
          echo "No se ha establecido una contraseña para $nuevo_usuario."
          break
          ;;
        *)
          echo "Opción no válida."
          return
          ;;
      esac
    fi
  done
}

# Función para establecer la contraseña de un usuario
establecer_contrasena() {
  read -p "Nombre del usuario: " usuario
  passwd "$usuario"
  echo "La contraseña de $usuario ha sido actualizada."
}

# Función para eliminar un usuario
eliminar_usuario() {
  read -p "Nombre del usuario que desea eliminar: " usuario_a_eliminar
  userdel -r "$usuario_a_eliminar"
  echo "$usuario_a_eliminar ha sido eliminado. "
}

# Función para añadir un usuario a un grupo
anadir_a_grupo() {
  while true; do
    read -p "Nombre del usuario: " usuario

    # Verificar si el usuario existe
    if id "$usuario" >/dev/null 2>&1; then
      break
    else
      echo "Error: El usuario $usuario no existe."
    fi
  done

  while true; do
    read -p "Nombre del grupo: " grupo

    # Verificar si el grupo existe
    if getent group "$grupo" >/dev/null 2>&1; then
      usermod -aG "$grupo" "$usuario"
      echo "$usuario ha sido añadido al grupo $grupo."
      break
    else
      echo "Error: El grupo $grupo no existe."
    fi
  done
}


# Menú principal
while true; do
  echo "MENÚ PRINCIPAL"
  echo "1. Crear un nuevo usuario"
  echo "2. Modificar contraseña de un usuario"
  echo "3. Eliminar un usuario"
  echo "4. Añadir un usuario a un grupo"
  echo "5. Salir"
  read -p "Seleccione una opción: " opcion

  case $opcion in
    1) agregar_usuario ;;
    2) establecer_contrasena ;;
    3) eliminar_usuario ;;
    4) anadir_a_grupo ;;
    5) echo "Saliendo..."; break ;;
    *) echo "Opción no válida. Inténtelo de nuevo." ;;
  esac
done
