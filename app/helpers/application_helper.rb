module ApplicationHelper
  def full_title page_title = ""
    base_title = t ".crawler"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", status: 404
  end

  def index_for counter, page, per_page
    (page - 1) * per_page + counter + 1
  end
end
