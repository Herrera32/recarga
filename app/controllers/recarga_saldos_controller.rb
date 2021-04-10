class RecargaSaldosController < ApplicationController
  include Controleable
  before_action :authenticate_usuario!
  before_action :coleccion_inicial, only: %i[index]

  def coleccion_inicial
    params[:q] ||= {}
    @coleccion = RecargaSaldo.ransack(params[:q])
    respond_to do |formato|
      formato.html do
        @registros = @coleccion.result.page(params[:page])
      end
    end
  end

  def index
    authorize!(:read, :Recarga)
    @params_permit = params[:q].present? ? {q: params[:q] .permit! } : {}
    render template: "recarga_saldos/index",  layout: "layouts/application"
  end

  def new
    authorize!(:create, :Recarga)
    render template: "recarga_saldos/form", layout: "layouts/application"
  end

  def create
    begin
      if @registro.save!
        flash[:notice] = "El registro fue guardado exitosamente"
        redirect_to action: :index
      end
    rescue StandardError => e
      flash[:error] = e
      render template: "recarga_saldos/form", layout: "layouts/application"
    end
  end

  private

    def nombre_recurso
      "RecargaSaldo"
    end

    def recarga_params
      params.require(:recarga_saldo).permit(:id, :telefono, :catalogo_recarga_id, :usuario_id)
    end

    alias :params_permit :recarga_params
end
