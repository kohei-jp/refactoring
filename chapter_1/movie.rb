class Movie
  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2
  attr_reader :title
  attr_accessor :price_code

  def initialize(title, price_code)
    @title, @price_code = title, price_code
  end

  # 料金の計算
  def charge(day_rentals)
    result = 0
    case price_code
    when REGULAR
      result += 2
      result += (days_rented - 2) * 1.5 if days_rented > 2
    when NEW_RELEASE
      result += days_rented * 3
    when CHILDRENS
      result += 1.5
      result += (days_rented - 3) * 1.5 if days_rented > 3
    end
    result
  end

  # レンタルポイントの計算
  def frequent_renter_points(days_rented)
    # 新作 && 期間 1日以上で 2ポイント それ以外は1ポイント(書き換え)
    (price_code == NEW_RELEASE && days_rented > 1) ? 2 : 1
  end
end