require 'pact/provider/rspec'

Pact.service_provider "CatKit Service" do

  honours_pact_with 'CatKit iOS App' do
    pact_uri './pacts/ios-app/catkit_ios_app-catkit_service.json'
  end

end
