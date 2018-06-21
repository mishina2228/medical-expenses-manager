class ApplicationController < ActionController::Base
  protected

  def require_data(redirect_url, *klass)
    notice = ''
    klass.each do |k|
      notice << "・#{k.model_name.human}<br>" unless k.exists?
    end

    return if notice.blank?

    notice = "#{t('helpers.notice.require_data')}<br>" + notice
    redirect_to redirect_url, notice: notice
  end
end
