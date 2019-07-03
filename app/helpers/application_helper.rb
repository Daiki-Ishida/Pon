module ApplicationHelper
  # 人間なら「さん」、フェレットオスなら「くん」、メスなら「ちゃん」を返す。
  def display_name(object)
    model = model_checker(object)
    if model == "user"
      "#{object.name}さん"
    elsif model == "ferret"
      if object.gender == 1
        "#{object.name} くん"
      elsif object.gender == 2
        "#{object.name} ちゃん"
      end
    end
  end

  # 人間なら「＊＊代」、フェレットなら年齢を返す。
  def display_age(object)
    model = model_checker(object)
    age = (Date.today.strftime('%Y%m%d').to_i - object.birth_date.strftime('%Y%m%d').to_i) / 10000
    if model == "user"
      return "#{age.to_s[0]}0代"
    elsif model == "ferret"
      return "#{age} 才"
    end
  end

  # 人間なら住所、フェレットなら親の住所を市まで返す。
  def display_address(object)

  end

  private
    # 人間かフェレットかチェック。ここでしか使わないのでprivateで定義
    def model_checker(object)
      if object.model_name.name == "User"
        return "user"
      elsif object.model_name.name == "Ferret"
        return "ferret"
      end
    end
end
