class Admin::DeviceController< Admin::ApplicationController


 def new
   @resource = Device.new()
   render "show"
 end
 
 def save
   if params[:form][:id] != nil
     
     @resource = Device.where(id: params[:form][:id]).first
     if @resource.update(form_params)
       redirect_to :action => "show", :id => @resource.id, notice: "O registro foi criado com sucesso"
     else
       redirect_to :action => "show", :id => @resource.id, notice: "Falha ao tentar salvar o registro"
     end
     
   else

     if @resource = Device.create(form_params)
       redirect_to :action => "show", :id => @resource.id, notice: "O registro foi criado com sucesso"
     else
       flash.now.alert = "Ocorreu um erro ao criar o registro, por favor tente novamente."
       render "new"  
     end
     
   end
 end

 def show
   @resource = Device.where(id: params[:id]).first

 end
 
 def index
   if params[:busca] != nil
     @resources = Device.where("serial like :v or device_name like :v" , v: "%" + params[:busca] + "%")
   else
     @resources = {}
   end
 end
 
 private
 def form_params
   params.require(:form).permit(:serial, :device_name, :obs, :device_manufacturer_identification )
 end
end
