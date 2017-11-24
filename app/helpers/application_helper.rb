module ApplicationHelper
  def url_encode (text)
    ERB::Util.url_encode(text)
  end

  def encoded_page_url
    url_encode(request.original_url)
  end

  def create_social_link network, url, title, target
    classes = 'social--share social--' + network

    link_to '', url, class: classes, target: target, title: title
  end
end
