require 'base64'
begin
    puts '==> Creando Seeds'
    puts '==> Creando Roles por defecto'
    Rol.create!(id: 1, nombre: "Administrador")
    puts ': Realizado con exito.'

    puts '==> Creando Tipo de Recursos por defecto'
    TipoRecurso.create!(id: 1, nombre: "Catalogo")
    TipoRecurso.create!(id: 2, nombre: "Configuración")
    puts ': Realizado con exito.'

    puts '==> Creando Recursos por Defecto'
    Recurso.create!(id: 1, nombre: "Usuario", descripcion: "Configuración Usuarios", tipo_recurso_id: 2)
    Recurso.create!(id: 2, nombre: "Roles", descripcion: "Configuración Roles", tipo_recurso_id: 2)
    Recurso.create!(id: 3, nombre: "Recarga", descripcion: "Catalogo Recargas", tipo_recurso_id: 1)

    puts ': Realizado con exito.'

    puts '==> Creando Acciones por Defecto'
    Accion.create!(id: 1, nombre: "Lectura", descripcion: "Permite leer el recurso")
    Accion.create!(id: 2, nombre: "Escritura", descripcion: "Permite generar el recurso")
    Accion.create!(id: 3, nombre: "Actualizar", descripcion: "Permite actualizar el recurso")
    Accion.create!(id: 4, nombre: "Eliminar", descripcion: "Permite eliminar el recurso")
    puts ': Realizado con exito.'

    puts '==> Creando Catalogo de Recargas por Defecto'
    CatalogoRecarga.create!(id: 1, nombre: "Paquete 1", monto: 10)
    CatalogoRecarga.create!(id: 2, nombre: "Paquete 2", monto: 20)
    CatalogoRecarga.create!(id: 3, nombre: "Paquete 3", monto: 50)
    CatalogoRecarga.create!(id: 4, nombre: "Paquete 4", monto: 100)
    
    puts ': Realizado con exito.'

    puts '==> Creando Usuarios por defecto'
    if Usuario.all.blank?
        Usuario.create!(email: 'mporras@recarga.com', password: 'root12345',
                        password_confirmation: 'root12345', usuario: 'M_Porras',
                        activo: true, rols_id: 1, telefono: "87501549" )
        puts ': Realizado con exito.'
    else
        puts 'No se puede agregar datos por defecto a la tabla Usuarios, porque ya contiene registros'
    end
end