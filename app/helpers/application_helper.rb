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

  def markdown(content, file = nil)
    return content if content == '' || content.nil?

    @_renderer ||= Redcarpet::Render::HTML.new(hard_wrap: true)
    @_markdown ||= Redcarpet::Markdown.new(@_renderer)

    if file&.attached?
      file_path = rails_service_blob_path(file.blob.signed_id, file.blob.filename)

      content += "\n![Image](#{file_path})"
    end

    final_str = if content[0] != '>'
                  @_markdown.render(content)[3..-5]
                else
                  @_markdown.render(content)
                end

    sanitize(final_str[0] == '>' ? final_str[1..-1] : final_str)
  end

  def sanitize_links(content)
    @_renderer ||= Redcarpet::Render::HTML.new(hard_wrap: true)
    @_markdown ||= Redcarpet::Markdown.new(@_renderer)

    return content if content == '' || content.nil?

    links = content.split("\n").map { |link| "\n - [#{link}](#{link})" }.join
    html_links = @_markdown.render(links)[4..-5]
    sanitize(html_links)
  end

  def poll_for_vote
    Poll.users_can_vote(Time.now.in_time_zone('Mexico City').to_date).first
  end

  def can_upload_project?
    @match.project_match? && current_user.project.nil?
  end

  def active_match?
    Match.active_match.first ? true : false
  end

  def user_can_comment?(commentable)
    return true if current_user.judge?

    commentable.team == current_user.current_team
  end

  def poll_content_path(match, content)
    if content.instance_of? Activity
      match_activity_path(match, content.id)
    else
      match_project_path(match, content.id)
    end
  end
end
