class LoginService
  attr_reader :params, :session

  def initialize(params, session)
    @params = params
    @session = session
  end

  def call
    modify_session if check_password
    message(check_password)
  end

  private

  def check_password
    true if params[:password] == '123'
  end

  def modify_session
    session[:login] = params[:login]
    session[:balance] ||= 100_000
  end

  def message(check_password)
    if check_password
      case Time.now.hour
      when 0..5
        'Good night '
      when 6..11
        'Good morning '
      when 12..17
        'Good afternoon '
      when 18..24
        'Good evening '
      else
        'Greetings '
      end + params[:login]
    else
      'Wrong password'
    end
  end
end
