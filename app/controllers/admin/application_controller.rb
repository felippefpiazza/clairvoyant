# encoding: utf-8
class Admin::ApplicationController < ApplicationController
  layout 'admin'
  
  before_filter :restrict_access
  
  def restrict_access
    session[:color] = 'blue' #['green','blue','purple','orange','yellow'][rand(5)]
  end
  
end