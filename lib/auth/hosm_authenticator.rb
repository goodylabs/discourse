class Auth::HosmAuthenticator < Auth::OAuth2Authenticator

  def name
    "hosm"
  end

  def initialize(opts={})
    @name = "hosm"
    @opts = opts
    super(@name,@opts)
  end


  def register_middleware(omniauth)
    omniauth.provider :hosm,
           :setup => lambda { |env|
              strategy = env["omniauth.strategy"]
              strategy.options[:client_id] = SiteSetting.hosm_app_id
              strategy.options[:client_secret] = SiteSetting.hosm_app_secret
           },
           :scope => "email"
  end


end
