RSpec.describe Herokenv::Client do
  let(:token){ 'fake-token' }
  let(:app){ 'stark-citadel-2145' }
  let(:fake_platoform_api){ double PlatformAPI }
  let(:heroku_config) do
    {
      "HEROKU_TEST_VAR" => "test",
      "HEROKU_TEST_VAR2" => "test2"
    }
  end
  let(:herokenv){ Herokenv::Client.new oauth_token: token, app: app }

  before do
    heroku_config.keys.each do |var|
      expect(ENV['HEROKU_TEST_VAR']).to be_nil
    end
    allow(PlatformAPI).to receive(:connect_oauth).and_return(fake_platoform_api)
  end

  after do
    heroku_config.keys.each do |var|
      ENV.delete var
    end
  end

  describe 'populate_env_from' do
    it 'pulls config vars from a heroku app and populates the local ENV' do
      expect(ENV['HEROKU_TEST_VAR']).to be_nil
      expect(ENV['HEROKU_TEST_VAR2']).to be_nil
      expect(fake_platoform_api).to receive_message_chain(:config_var, :info_for_app).and_return(heroku_config)
      herokenv.populate_env_from_app
      expect(ENV['HEROKU_TEST_VAR']).to eq('test')
      expect(ENV['HEROKU_TEST_VAR2']).to eq('test2')
    end

    it 'takes an only: option' do
      expect(ENV['HEROKU_TEST_VAR']).to be_nil
      expect(ENV['HEROKU_TEST_VAR2']).to be_nil
      expect(fake_platoform_api).to receive_message_chain(:config_var, :info_for_app).and_return(heroku_config)
      herokenv.populate_env_from_app only: ['HEROKU_TEST_VAR']
      expect(ENV['HEROKU_TEST_VAR']).to eq('test')
      expect(ENV['HEROKU_TEST_VAR2']).to be_nil
    end

    it 'takes an except: option' do
      expect(ENV['HEROKU_TEST_VAR']).to be_nil
      expect(ENV['HEROKU_TEST_VAR2']).to be_nil
      expect(fake_platoform_api).to receive_message_chain(:config_var, :info_for_app).and_return(heroku_config)
      herokenv.populate_env_from_app except: ['HEROKU_TEST_VAR2']
      expect(ENV['HEROKU_TEST_VAR']).to eq('test')
      expect(ENV['HEROKU_TEST_VAR2']).to be_nil
    end
  end

end
