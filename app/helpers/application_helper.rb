module ApplicationHelper
  def flash_class(category)
    case category
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'warning' then 'alert alert-warning'
    when 'error' then 'alert alert-error'
    else 'alert alert-danger'
    end
  end

  def markdown(content)
    @_renderer ||= Redcarpet::Render::HTML.new(hard_wrap: true)
    @_markdown ||= Redcarpet::Markdown.new(@_renderer)
    sanitize(@_markdown.render(content || '')[3..-5])
  end

  def poll_for_vote
    Poll.users_can_vote(Time.now.in_time_zone('Mexico City').to_date).first
  end
end
