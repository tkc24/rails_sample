class Admin::TopController < Admin:base
  def index
    render action: 'index'
  end
end
