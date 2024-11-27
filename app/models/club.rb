class Club < ApplicationRecord
  belongs_to :user
end

def logo_url
  logo || "https://via.placeholder.com/150" # Default placeholder if no logo exists
end
