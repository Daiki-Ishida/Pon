module ApplicationHelper
  require "uri"

  def display_basic_info(object)
    display_address(object)+ " | " + display_gender(object) + " | " + display_age(object)
  end

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

  def display_time(time)
    time.strftime("%Y-%m-%d %H:%M")
  end

  # Request or Contractの期間を返す
  def display_period(contract)
    from = contract.start_at.strftime("%Y-%m-%d")
    to = contract.end_at.strftime("%Y-%m-%d")
    diff = contract.end_at.day - contract.start_at.day
    return "#{from}から#{to}までの#{diff}泊#{diff + 1}日"
  end

  def current_user
    if session[:user_id]
      current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # 文字列中にURLがあればリンクにする。
  def text_url_to_link(text)
    URI.extract(text, ['http', 'https']).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
      text.gsub!(url, sub_text)
    end
    return text
  end

  def nav_links(type)
    hash = {}
    case type
    when "users"
      hash[:index] = users_path
      hash[:territory] = territory_users_path
      hash[:follow] = followings_users_path
      hash[:search] = search_users_path
    when "ferrets"
      hash[:index] = ferrets_path
      hash[:territory] = territory_ferrets_path
      hash[:follow] = followings_ferrets_path
      hash[:search] = search_ferrets_path
    when "posts"
      hash[:index] = posts_path
      hash[:territory] = territory_posts_path
      hash[:follow] = followings_posts_path
      hash[:search] = search_posts_path
    end
    return hash
  end

  def display_notification(notification)
    action_user = notification.action_user
    user = link_to(display_name(action_user), user_path(action_user), class:"notification--user")
    case notification.action
      when "like"
        post = link_to("あなたの投稿", post_path(notification.post),  class:"notification--action")
        "#{user}が#{post}にいいね！しました。"
      when "comment"
        post = link_to("あなたの投稿", post_path(notification.post),  class:"notification--action")
        "#{user}が#{post}にコメントしました。"
      when "message"
        room = notification.message.room
        message = link_to("メッセージ", room_path(room), class:"notification--action")
        "#{user}から#{message}が届きました。"
    end
  end

  def unread_notifications
    notifications = current_user.passive_notifications.where(checked: false)
  end

  private
    # 人間かフェレットかチェック。
    def model_checker(object)
      if object.model_name.name == "User"
        return "user"
      elsif object.model_name.name == "Ferret"
        return "ferret"
      end
    end
end
