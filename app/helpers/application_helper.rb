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

  # 人間なら住所、フェレットなら親の住所を、市区町村まで返す。
  def display_address(object)
    # 住所を区切るためのregexp。１：県、２：市区町村、３：その他
    rex = /(...??[都道府県])((?:旭川|伊達|石狩|盛岡|奥州|田村|南相馬|那須塩原|東村山|武蔵村山|羽村|十日町|上越|富山|野々市|大町|蒲郡|四日市|姫路|大和郡山|廿日市|下松|岩国|田川|大村)市|.+?郡(?:玉村|大町|.+?)[町村]|.+?市.+?区|.+?[市区町村])(.+)/
    model = model_checker(object)
    if model == "user"
      return object.postal_address.match(rex)[1,2].join
    elsif model == "ferret"
      return object.user.postal_address.match(rex)[1,2].join
    end
  end

  # 人間なら男性or女性or非公開、フェレットならオスorメスを表示。
  def display_gender(object)
    model = model_checker(object)
    if model == "user"
      if object.gender == 1
        return "男性"
      elsif object.gender == 2
        return "女性"
      else
        return "非公開"
      end
    elsif model == "ferret"
      if object.gender == 1
        return "オス"
      elsif object.gender == 2
        return "メス"
      end
    end
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
