module CatsHelper
  def owners_cat?(cat)
    current_user && cat.user_id == current_user.id
  end
end