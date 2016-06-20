class MessengerBotController < ActionController::Base
  def message(event, sender)
      text = event['message']['text']
    # profile = sender.get_profile(field) # default field [:locale, :timezone, :gender, :first_name, :last_name, :profile_pic]
    if text == "おはよう"
      sender.reply({ text: "おはよう" })
    else
      sender.reply({ "attachment":{
                          "type":"template",
                          "payload":{
                              "template_type":"button",
                              "text":"大人の恋愛ゲームを始めますか？",
                              "buttons":[
                                  {
                                      "type":"postback",
                                      "title":"はい",
                                      "payload":"OVER"
                                  },
                                  {
                                      "type":"postback",
                                      "title":"いいえ",
                                      "payload":"UNDER"
                                  }
                              ]
                          }
                       }
                    })
    end
    
  end
  
  def choice(event, sender)
    
  end

  def delivery(event, sender)
  end

  def postback(event, sender)
    payload = event["postback"]["payload"]
    case payload
    when "OVER"
      sender.reply({ "attachment":{
            "type":"template",
            "payload":{
                "template_type":"button",
                "text":"ええ、はじめましょうよ？",
                "buttons":[
                    {
                        "type":"postback",
                        "title":"何言ってるんだよ、記念日なら昨日終わっただろ（愛人）",
                        "payload":"1"
                    },
                    {
                        "type":"postback",
                        "title":"やややややばい！わすれてた！",
                        "payload":"2"
                    },
                    {
                        "type":"postback",
                        "title":"君とであった蜂蜜公園でピクニックしよう。",
                        "payload":"3"
                    },
                    {
                        "type":"postback",
                        "title":"楽しみにしといて！僕が全部準備しておくから！",
                        "payload":"4"
                    }
                ]
            }
         }
      })
      
    when "UNDER"
      sender.reply({ "attachment":{
            "type":"template",
            "payload":{
                "template_type":"button",
                "text":"ええ、はじめましょうよ？",
                "buttons":[
                    {
                        "type":"postback",
                        "title":"はい",
                        "payload":"OVER"
                    },
                    {
                        "type":"postback",
                        "title":"いいえ",
                        "payload":"UNDER"
                    }
                ]
            }
         }
      })
      when "3"
        sender.reply({ text: "愛してる" })
        
      when"1","2","4"
        sender.reply({ text: "別れましょう" })
        
    end
  end
end