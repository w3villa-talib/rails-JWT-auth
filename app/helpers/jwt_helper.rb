module JwtHelper
  SECRET = "yoursecretword"

  def authentication
    # making a request to a secure route, token must be included in the headers

    decode_data = decode_user_data(request.headers["token"])
    # getting user id from a nested JSON in an array.
    user_data = decode_data[0]["user_data"] unless !decode_data
    user = User.find(user_data)
    if user
      return true
    else
      render json: { message: "invalid credentials" }
    end
  end

   # turn user data (payload) to an encrypted string  [ A ]
  def encode_user_data(payload)
    token = JWT.encode payload, SECRET, "HS256"
    return token
  end

   # decode token and return user info, this returns an array, [payload and algorithms] [ A ]
  def decode_user_data(token)
    begin
      data = JWT.decode token, SECRET, true, { algorithm: "HS256" }
      return data
    rescue => e
      puts e
    end
  end


end