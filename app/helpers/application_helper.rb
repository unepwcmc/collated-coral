module ApplicationHelper
  def page_title 
    'Coral Reef Funding Landscape'
  end

  def page_description
    'Coral Reef Funding Landscape is a filterable database of international funding allocations for the sustainable management of coral reefs and related mangroves and seagrass ecosystems'
  end

  def url_encode (text)
    ERB::Util.url_encode(text)
  end

  def encoded_page_url
    url_encode(request.original_url)
  end

  def social_image
    image_url('coral-reef-funding-landscape-social.jpg')
  end

  def social_image_alt
    'Coral reef'
  end

  def create_social_facebook_link
    title = url_encode('Share ' + page_title + ' on Facebook')
    url = encoded_page_url
    href = 'https://facebook.com/sharer/sharer.php?u=' + url

    link_to '', href, title: title, class: 'social--share social--facebook', target: '_blank'
  end

  def create_social_linkedin_link
    title = url_encode('Share ' + page_title + ' on LinkedIn')
    url = encoded_page_url
    href = 'https://www.linkedin.com/shareArticle?url=' + url

    link_to '', href, title: title, class: 'social--share social--linkedin', target: '_blank'
  end

  def create_social_twitter_link
    title = url_encode('Share ' + page_title + ' on Twitter')
    text = url_encode('Coral Reef Funding Landscape - Explore international funding allocations for the sustainable management of coral reefs and related mangroves and seagrass ecosystems.')
    url = encoded_page_url
    href = 'https://twitter.com/intent/tweet/?text=' + text + '&url=' + url
    
    link_to '', href, title: title, class: 'social--share social--twitter', target: '_blank'
  end

  def create_social_email_link
    title = url_encode('Share ' + page_title + ' via Email')
    url = encoded_page_url
    subject = url_encode('Coral Reef Funding Landscape')
    body = url_encode("Coral Reef Funding Landscape\n\nSearch the database to explore international funding allocations for the sustainable management of coral reefs and related mangroves and seagrass ecosystems.\n\n") + url
    href = 'mailto:?subject=' + subject + '&body=' + body

    link_to '', href, title: title, class: 'social--share social--email', target: '_self'
  end
end
