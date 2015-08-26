class Staff::SessionsController < Staff::Base
  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)
    end
    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      if staff_member.suspended?
        flash.now.alert = "アカウントが停止されています。"
        render action: 'new'
      else
        flash.notice = "ログインしました。"
        session[:staff_member_id] = staff_member.id
        redirect_to :staff_root
      end
    else
      flash.now.alert = "ログインに失敗しました。"
      render action: 'new'
    end
  end

  def destroy
    flash.notice = "ログアウトしました。"
    session.delete(:staff_member_id)
    redirect_to :staff_root
  end
end
