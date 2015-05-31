module ViewAble

  def self.find_by_page_link url
    Product.find_by_page_link(url) ||
        Category.find_by_page_link(url)
  end

end