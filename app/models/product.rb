class Product < ActiveRecord::Base
  belongs_to :website
  has_many :popularities
  has_many :users, :through => :popularities

  def self.create_using_crawler url ,website
    doc = Nokogiri::HTML(open(url).read)

    if doc.at_css(website.page_product_name_selector)
      title        = doc.at_css(website.page_product_name_selector).text
      picture_link = doc.at_css(website.page_product_picture_selector).xpath('@src').first.value
      price        = doc.at_css(website.page_product_price_selector).text.scan(/[\d\.]/).join('')

      Product.create(page_link: url,picture_link: picture_link, title: title , price: price)
    else
      nil
    end
  end

end
