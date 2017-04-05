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

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
  
end
