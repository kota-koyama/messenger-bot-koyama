class MessengerBotController < ActionController::Base
@@message_count = 0
  def message(event, sender)
      text = event['message']['text']
    # profile = sender.get_profile(field) # default field [:locale, :timezone, :gender, :first_name, :last_name, :profile_pic]
    if text == "おはよう"
      @@message_count += 1
      sender.reply({ text: "おはよう#{@@message_count}" })
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
                        "title":"記念日なら昨日終わっただろ",
                        "payload":"1"
                    },
                    {
                        "type":"postback",
                        "title":"君とであった蜂蜜公園でデート",
                        "payload":"2"
                    },
                    {
                        "type":"postback",
                        "title":"僕が全部準備しておくから！",
                        "payload":"3"
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
      when "1","3"
        sender.reply({ text: "別れましょう" })
    end
  end
  
 
end