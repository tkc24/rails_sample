class Admin::SessionsController < Admin::Base
  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Admin::LoginForm.new(params[:admin_login_form])
    if @form.email.present?
      administrator = Administrator.find_by(email_for_index: @form.email.downcase)
    end
    if Admin::Authenticator.new(administrator).authenticate(@form.password)
      if administrator.suspended?
        flash.now.alert = "アカウントが停止されています。"
        render action: 'new'
      else
        flash.notice = "ログインしました。"
        session[:administrator_id] = administrator.id
        redirect_to :admin_root
      end
    else
      flash.now.alert = "ログインに失敗しました。"
      render action: 'new'
    end
  end

  def destroy
    flash.notice = "ログアウトしました。"
    session.delete(:administrator_id)
    redirect_to :admin_root
  end
end
