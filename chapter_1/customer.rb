class Customer
  attr_reader :name
  def initialize(name)
    @name = name
    @rentals = []
  end

  # rentalしたmovieの配列
  def add_rental(arg)
    @rentals << arg
  end

  # 
  def amount_for(rental)
    rental.charge
  end

  def statement
    result = "Rental Record for #{@name}\n"

    @rentals.each do |element|
      # 加算になるポイントを返してあげれば良い(引数いらない)
      # 新作かどうかの情報もレシーバのインスタンスが持っている。

      # レンタルの料金の表示
      result += "\t" + element.movie.title + "\t" + element.charge.to_s + "\n"
    end

    # フッターの行を追加
    result += "Amount owed is #{total_charge}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result
  end

  private
  def total_charge
    @rentals.inject(0){|sum, rental| sum + rental.charge }
  #   result = 0
  #   @results.each do |element|
  #     result += element.charge
  #   end
  #   result
  # end
  end

  def total_frequent_renter_points
    @rentals.injects(0){|sum, rental| sum + rental.frequent_renter_points }
  end
end