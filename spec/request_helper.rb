module RequestHelper
  # mempersingkat pemanggilan response body yg bisa diimplement ke spec test lain
  def response_body
    JSON.parse(response.body)
  end
end
