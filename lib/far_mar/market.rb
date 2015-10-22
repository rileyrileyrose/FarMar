# CSV.read('./support/markets.csv')

module FarMar

  class Market
    attr_reader :market_id, :name, :address, :city, :county, :state, :zip

  	def initialize(market_id, name, address, city, county, state, zip)
  		@market_id = market_id.to_i
  		@name = name
  		@address = address
  		@city = city
  		@county = county
  		@state = state
  		@zip = zip
  	end

  	def self.all
      @@market_array ||= []
      if @@market_array == []
  		  CSV.read('./support/markets.csv').each do |row|
          market = FarMar::Market.new(row[0], row[1], row[2], row[3], row[4], row[5], row[6])
          @@market_array.push(market)
        end
      end
      return @@market_array
  	end

    def self.find(id)
      FarMar::Market.all.find {|mar| mar.market_id == id }
    end

    def vendors
      FarMar::Vendor.all.find_all {|ven| ven.market == market_id }
    end

    def products
      ven_array = self.vendors
      prod_array = []
      ven_array.each do |ven|
        prod_array.push(ven.products)
        end
      return prod_array.flatten
    end


  end

end