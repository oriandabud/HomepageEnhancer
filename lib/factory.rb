# encoding: utf-8
# For testing and manual email sending

module Factory

  class ViewAble
    require 'open-uri'

    def self.generate(url , website)

      doc = Nokogiri::HTML(open(url).read)

      if doc.at_css(website.product_page.validator_selector)

        title        = doc.at_css(website.product_page.name_selector).text
        picture_link = doc.at_css(website.product_page.picture_selector).xpath('@src').first.value
        price        = doc.at_css(website.product_page.price_selector).text.scan(/[\d\.]/).join('')

        [ViewAble.find_by_page_link(url) || Product.create(page_link: url,picture_link: picture_link, title: title , price: price , website: website)]


      elsif doc.at_css(website.category_page.validator_selector)

        ViewAble.find_by_page_link(url) || Category.create(page_link: url, website: website)

        products_urls = doc.css(website.category_page.products_selector).xpath('@href')

        products = []
        products_urls.each do |product_url|
          products += ViewAble.generate(website.url+product_url,website)
        end
        products
      else
        []
      end
    end

    def self.find_by_page_link url
      Product.find_by_page_link(url) ||
        Category.find_by_page_link(url)
    end

  end

end
