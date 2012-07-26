Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  provider :facebook, '339158919498974', '7dcb4b8f959d25f9547807a5ebe7b852', { :scope => 'email' }
end