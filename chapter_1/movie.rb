class Movie
  attr_writer :price

  # 「price_code」より子クラスのインスタンスを生成した場合
  # attr_reader :price_code
  # カスタムセッターメソッド
  # price_code(料金クラス)次第で子クラスのインスタンスを作成する。
  # def price_code=(=value)
  #   @price_code = value
    # @price = case price_code
    #   when REGULAR: RegularPrice.new
    #   when NEW_RELEASE: NewReleasePrice.new
    #   when CHILDRENS: ChildrensPrice.new
    # end
  # end

  # def initialize(title,the_price_code)
  #   @title, self.price_code = title, the_price_code
  # end

  def initialize(title,price)
    @title, @price
  end

  # 料金の計算
  def charge(day_rentals)
    @price.charge(days_rented)
  end

  # レンタルポイントの計算
  def frequent_renter_points(days_rented)
    # 新作 && 期間 1日以上で 2ポイント それ以外は1ポイント(書き換え)
    @price.frequent_renter_points(days_rented)
  end
end

module DefaultPrice
  def frequent_renter_points(days_rented)
    1
  end
end

class RegularPrice
  include Price
  def charge(days_rented)
    result = 2
    result += (days_rented - 2) * 1.5 if days_rented > 2
    result
  end
end

class NewReleasePrice
  def charge(days_rented)
    days_rented * 3
  end

  def frequent_renter_points(days_rented)
    # 新作 && 期間 1日以上で 2ポイント それ以外は1ポイント(書き換え)
    days_rented > 1 ? 2 : 1
  end
end

class ChildrensPrice
  include Price

  def charge(days_rented)
    result = 1.5
    result += (days_rented - 3) * 1.5 if days_rented > 3
    result
  end
end

# ①Movieクラスにカスタムメソッドがあった場合 price_codeからのpriceの算出
# def price_code=(=value)
#   @price_code = value
#   @price = case price_code
#     when REGULAR: RegularPrice.new
#     when NEW_RELEASE: NewReleasePrice.new
#     when CHILDRENS: ChildrensPrice.new
#   end
# end

# movie = Movie.new("The Watchman", Movie::NEW_RELEASE)
# 新作で無くなったら、
# movie.price_code = Movie::REGULAR

# ・② attr_writer :price の場合(直接priceをセッター)
#   movie = Movie.new("The Watchman", NewReleasePrice.new)
#   movie.price = RegularPrice.new
#   ※ オブジェクトの注入