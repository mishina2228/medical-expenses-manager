class ApplicationController < ActionController::Base
  protected

  def require_data(redirect_url, *klass)
    notices = []
    klass.each do |k|
      notices << t('helpers.notice.require_data', model: k.model_name.human) unless k.exists?
    end
    return if notices.blank?

    redirect_to redirect_url, notice: notices
  end
end
