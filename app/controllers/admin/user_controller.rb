class Admin::UserController < Admin::ApplicationController


  def login
  end

  def new
    @resource = User.new()
    render "show"
  end
  
  def save
    if params[:form][:id] != nil
      
      @resource = User.where(id: params[:form][:id]).first
      if @resource.update(form_params)
        redirect_to :action => "show", :id => @resource.id, notice: "O registro foi criado com sucesso"
      else
        redirect_to :action => "show", :id => @resource.id, notice: "Falha ao tentar salvar o registro"
      end
      
    else

      if @resource = User.create(form_params)
        redirect_to :action => "show", :id => @resource.id, notice: "O registro foi criado com sucesso"
      else
        flash.now.alert = "Ocorreu um erro ao criar o registro, por favor tente novamente."
        render "new"  
      end
      
    end
  end

  def show
    @resource = User.where(id: params[:id]).first

  end
  
  def index
    if params[:busca] != nil
      @resources = User.where("username like :v or first_name like :v or middle_name like :v or last_name like :v or nickname like :v" , v: "%" + params[:busca] + "%")
    else
      @resources = {}
    end
  end
  
  private
  def form_params
    params.require(:form).permit(:username, :first_name, :middle_name, :last_name, :nickname, :email, :password)
  end
end
