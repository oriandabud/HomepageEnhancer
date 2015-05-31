# encoding: utf-8
# For testing and manual email sending

module Scrapper
  require 'open-uri'

  def self.scrap_products( url , website  ,doc = nil)
    doc = Nokogiri::HTML(open(url).read) unless doc

    if doc.at_css(website.product_page.validator_selector)
      [ Scrapper.scrap_product( url , website , doc) ]
    elsif doc.at_css(website.category_page.validator_selector)
      Scrapper.scrap_category( url , website , doc)
    else
      []
    end

  end

  def self.scrap_product(url , website ,doc = nil)
    doc = Nokogiri::HTML(open(url).read) unless doc

    title        = doc.at_css(website.product_page.name_selector).text
    picture_link = doc.at_css(website.product_page.picture_selector).xpath('@src').first.value

    if doc.at_css(website.product_page.price_selector)
      price        = doc.at_css(website.product_page.price_selector).text.scan(/[\d\.]/).join('')
      old_price    = website.product_page.old_price_selector ?
          doc.at_css(website.product_page.old_price_selector).text.scan(/[\d\.]/).join('') :
          nil
    else
      price = old_price = doc.at_css(website.product_page.regular_price_selector).text.scan(/[\d\.]/).join('')
    end

    ::ViewAble.find_by_page_link(url) || Product.create!(page_link: url,picture_link: picture_link, title: title , price: price ,old_price: old_price ,  website: website)
  end

  def self.scrap_category( url , website ,doc = nil)
    doc = Nokogiri::HTML(open(url).read) unless doc

    ::ViewAble.find_by_page_link(url) || Category.create!(page_link: url, website: website)

    products_urls = doc.css(website.category_page.products_selector).xpath('@href')

    products = []
    products_urls.each do |product_url|
      product_url = product_url.value.include?('http') ? product_url.value : website.url+product_url.value
      products << Scrapper.scrap_product(product_url,website) || Scrapper.scrap_product(URI.encode(product_url),website)
    end
    products
  end

end
