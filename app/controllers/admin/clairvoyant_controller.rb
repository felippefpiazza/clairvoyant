class Admin::ClairvoyantController < Admin::ApplicationController


  def new
    @resource = Clairvoyant.new()
    render "show"
  end
  
  def save
    if params[:form][:id] != nil
      
      @resource = Clairvoyant.where(id: params[:form][:id]).first
      if @resource.update(form_params)
        redirect_to :action => "show", :id => @resource.id, notice: "O registro foi criado com sucesso"
      else
        redirect_to :action => "show", :id => @resource.id, notice: "Falha ao tentar salvar o registro"
      end
      
    else

      if @resource = Clairvoyant.create(form_params)
        redirect_to :action => "show", :id => @resource.id, notice: "O registro foi criado com sucesso"
      else
        flash.now.alert = "Ocorreu um erro ao criar o registro, por favor tente novamente."
        render "new"  
      end
      
    end
  end

  def show
    @resource = Clairvoyant.where(id: params[:id]).first

  end
  
  def index
    if params[:busca] != nil
      @resources = Clairvoyant.where("serial like :v or identification like :v" , v: "%" + params[:busca] + "%")
    else
      @resources = {}
    end
  end
  
  private
  def form_params
    params.require(:form).permit(:serial, :identification, :equipment_id, :client_id, :obs )
  end
  
end
