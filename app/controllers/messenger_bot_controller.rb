class MessengerBotController < ActionController::Base
  def message(event, sender)
    # profile = sender.get_profile(field) # default field [:locale, :timezone, :gender, :first_name, :last_name, :profile_pic]
   sender.reply({ "attachment":{
            "type":"template",
            "payload":{
                "template_type":"button",
                "text":"#{profile_last_name} #{profile_first_name}さんこんにちは",
                "buttons":[
                    {
                        "type":"postback",
                        "title":"OVER",
                        "payload":"OVER"
                    },
                    {
                        "type":"postback",
                        "title":"UNDER",
                        "payload":"UNDER"
                    }
                ]
            }
         }
      })
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