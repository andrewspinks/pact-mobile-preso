require 'sinatra'
require 'json'
require 'yaml'

before do
  content_type :json
  headers 'Access-Control-Allow-Origin' => '*',
          'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']
end

set :protection, false

get '/feed-me' do
  content_type :json

  if FoodRepository.has_food?
    { "message" => "Meow!", "status" => "happy" }.to_json
  else
    status 400
    { "message" => "Out of food dude", "status" => "grumpy" }.to_json
  end
end

class FoodRepository

  def self.amount_of_food= food
    @amount_of_food = food
  end

  def self.amount_of_food
    @amount_of_food ||= 100
  end

  def self.has_food?
    amount_of_food > 0
  end
end
