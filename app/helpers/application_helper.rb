module ApplicationHelper
 def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def foundation_flash_class(level)
    case level.to_sym
    when :notice    then "alert-box"
    when :alert     then "alert-box warning"
    when :success   then "alert-box success"
    when :info      then "alert-box info"
    when :error     then "alert-box alert"
    when :secondary then "alert-box secondary"
    end
  end
  
end
