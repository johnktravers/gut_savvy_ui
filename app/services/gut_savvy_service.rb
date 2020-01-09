class GutSavvyService
  def get_food_info(upc)
    response = conn.get('api/v1/food_search') do |req|
      req.params['upc'] = upc
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def food_info(upc)
    @food_info ||= get_food_info(upc)
  end

  private

  def conn
    Faraday.new(url: 'https://gut-savvy-service.herokuapp.com') do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end
  end
end
