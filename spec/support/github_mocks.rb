module OmniauthMocks
  def github_mock(name, email)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      provider: 'github',
      uid: 1234567890,
      info: {
        name: name,
        email: email
      },
      credentials: {
        "token" => "mock_credentails_token",
      }
    )
  end
end

OmniAuth.config.test_mode = true
