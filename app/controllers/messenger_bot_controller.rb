class MessengerBotController < ActionController::Base
@@message_count = 0
  def message(event, sender)
      text = event['message']['text']
    # profile = sender.get_profile(field) # default field [:locale, :timezone, :gender, :first_name, :last_name, :profile_pic]
    if text == "おはよう"
      @@message_count += 1
      sender.reply({ text: "おはよう#{@@message_count}" })
      
    elsif text.end_with?("画像？")  
            BingSearch.account_key = "94d986b2a4e84fee94a9cedd0e9f1084"
            sender.reply({ text: "#{text.chop.chop.chop}" })
            bing_image = BingSearch.image(text.chop.chop.chop, limit: 30).shuffle[0]
            if bing_image.nil?
                sender.reply({ text: "画像が見つかりませんでした" })
            else
                sender.reply({ "attachment": {
                "type": "image",
                "payload": {
                  "url": bing_image.media_url
                          }
                                              }
                            })
            end
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

  def image_url_message_request_body(sender, url)
    {
      recipient: {
        id: sender
      },
      message: {
        attachment: {
          type: "image",
          payload: {
            url: url
          }
        }
      }
    }.to_json
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