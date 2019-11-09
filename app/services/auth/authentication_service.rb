module Auth
  class AuthenticationService
    class << self
      def login(params)
        @user = User.find_by(username: params[:username])
        return nil unless @user.present?
        return @user if @user.authenticate(params[:password])
      end
    end
  end
end
