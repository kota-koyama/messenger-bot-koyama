class MessengerBotController < ActionController::Base
  def message(event, sender)
      text = event['message']['text']
    # profile = sender.get_profile(field) # default field [:locale, :timezone, :gender, :first_name, :last_name, :profile_pic]
    if text == "おはよう"
      sender.reply({ text: "おはよう" })
    else
      sender.reply({"私はおはようしかいえません"})
    end
  end

  def delivery(event, sender)
  end

  def postback(event, sender)
    payload = event["postback"]["payload"]
    case payload
    when :something
      #ex) process sender.reply({text: "button click event!"})
    end
  end
end