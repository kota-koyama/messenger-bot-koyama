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
                "text":"結婚記念日どうしようか？",
                "buttons":[
                    {
                        "type":"postback",
                        "title":"何言ってるんだよ、記念日なら昨日終わっただろ（愛人）",
                        "payload":"1"
                    },
                    {
                        "type":"postback",
                        "title":"楽しみにしといて！僕が全部準備しておくから！",
                        "payload":"2"
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
                "text":"えぇ…はじめましょうよ？",
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
      
      when "2"
        sender.reply({ text: "愛してる" })
      when "1"
        sender.reply({ text: "別れましょう" })
    end
  end
end