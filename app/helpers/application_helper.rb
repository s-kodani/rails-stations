module ApplicationHelper
  def is_showing_checked(is_showing_query_param, compare_str)
    if is_showing_query_param == compare_str then
      return true
    elsif is_showing_query_param == nil && compare_str == "all" then
      return true
    else
      return false
    end
  end
end
