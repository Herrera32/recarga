class RecargaSaldo < ApplicationRecord
    belongs_to :usuario
    belongs_to :catalogo_recarga

    validates :telefono, presence: true, numericality: true, length: {is: 8}
    validates :catalogo_recarga, presence: true
    validate :validar_telefono
    before_save :asignar_valores
    after_commit :calcular_promociones

    def validar_telefono
        usuario = Usuario.find_by_id(usuario_id)
        if usuario.telefono != telefono
            raise StandardError.new "Telefono no pertenece al Usuario." 
        end 
    end

    def calcular_promociones
        rango_fecha = Date.today.beginning_of_month...Date.today.end_of_month
        recargas = RecargaSaldo.where(fecha: rango_fecha, catalogo_recarga_id: self.catalogo_recarga_id, 
                                      telefono: self.telefono)
        promocion_recarga_id = case self.catalogo_recarga_id    
        when CatalogoRecarga::RECARGA_20   
            if recargas.size == CatalogoRecarga::NUMERO_RECARGA_20
                CatalogoRecarga::RECARGA_10
            end
        when CatalogoRecarga::RECARGA_50
            if recargas.size == CatalogoRecarga::NUMERO_RECARGA_50
                CatalogoRecarga::RECARGA_20
            end
        when CatalogoRecarga::RECARGA_100
            if recargas.size == CatalogoRecarga::NUMERO_RECARGA_100
                CatalogoRecarga::RECARGA_50
            end
        end
        unless promocion_recarga_id.nil?
            usuario = Usuario.find_by_id(usuario_id)
            catalogo_recarga = CatalogoRecarga.find(promocion_recarga_id)       
            monto_final = usuario.saldo_recarga + catalogo_recarga.monto 
            promocion = RecargaSaldo.new(fecha: Date.today, usuario_id: self.usuario_id, catalogo_recarga_id: promocion_recarga_id,
                                         saldo_inicial: usuario.saldo_recarga, saldo_final: monto_final, telefono: self.telefono )
            promocion.save!
        end
    end

    def asignar_valores
        # Encontramos el usuario y procedemos a actualizar los datos
        usuario = Usuario.find_by_id(usuario_id)
        self.usuario_id = usuario.id
        self.telefono = usuario.telefono        
        self.saldo_inicial = self.usuario.saldo_recarga
        self.saldo_final = saldo_inicial + catalogo_recarga.monto
        self.fecha = Date.today
        usuario.saldo_recarga =  saldo_final
        usuario.save!
    end
end
