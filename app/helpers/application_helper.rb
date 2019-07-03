module ApplicationHelper

  def display_user_name(user)
    "#{user.name}さん"
  end

  def display_ferret_name(ferret)
    if ferret.gender == 1
      "#{ferret.name} くん"
    elsif ferret.gender == 2
      "#{ferret.name} ちゃん"
    end
  end

  def display_age(object)
    (Date.today.strftime('%Y%m%d').to_i - object.birth_date.strftime('%Y%m%d').to_i) / 10000
  end

  def display_address(object)

  end
end
