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
end
