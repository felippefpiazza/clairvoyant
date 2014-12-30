class Admin::ManufacturerController < Admin::ApplicationController
  

  def new
    @resource = Manufacturer.new()
    render "show"
  end
  
  def save
    if params[:form][:id] != nil
      
      @resource = Manufacturer.where(id: params[:form][:id]).first
      if @resource.update(form_params)
        redirect_to :action => "show", :id => @resource.id, notice: "O registro foi criado com sucesso"
      else
        redirect_to :action => "show", :id => @resource.id, notice: "Falha ao tentar salvar o registro"
      end
      
    else

      if @resource = Manufacturer.create(form_params)
        redirect_to :action => "show", :id => @resource.id, notice: "O registro foi criado com sucesso"
      else
        flash.now.alert = "Ocorreu um erro ao criar o registro, por favor tente novamente."
        render "new"  
      end
      
    end
  end

  def show
    @resource = Manufacturer.where(id: params[:id]).first

  end
  
  def index
    if params[:busca] != nil
      @resources = Manufacturer.where("username like :v or first_name like :v or middle_name like :v or last_name like :v or nickname like :v" , v: "%" + params[:busca] + "%")
    else
      @resources = {}
    end
  end
  
  private
  def form_params
    params.require(:form).permit(:first_name, :nickname)
  end
  
end
