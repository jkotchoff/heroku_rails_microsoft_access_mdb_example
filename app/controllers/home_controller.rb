class HomeController < ApplicationController
  def index
    db = Mdb.open("#{Rails.root.to_s}/lib/microsoft_access_db.mdb")
    output = "Tables: #{db.tables}"
    output += "<br/><br/>"
    output += "Data: #{db[:Balance_Sheet].first}"
    render text: output
  end
end