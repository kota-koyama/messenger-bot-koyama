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
  
  require 'bing-search'

  BingSearch.account_key = ENV["zkiPxRUdYyoDtF63b0TgZ2NV/F47uDgMx3hWPNzJXPI"]
  
  def bot_response(sender, text)
    request_endpoint = "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV["EAAYw9ZC4mz60BABzlBXsBTB45ooS6kvBngD6Wmd5tFjAuMGK84VaOR5mS8MWBpuRT87GpvSr5oYUHifUb9xnR7ZAIp5WeuVyaXPQ4OSX5EU73qkhEZCwpJVZBdakNhZC1x3SfHsATfauE2eiZB58ig3jDQOexzZCXgWwO7ncIIwSQZDZD"]}"
    request_body ="画像を検索します"
      if text =~ /(.+)\s+画像/
        bing_image = BingSearch.image($&, limit: 10).shuffle[0]
        if bing_image.nil?
          text_message_request_body(sender, "残念、画像は見つかりませんでした")
        else
          image_url_message_request_body(sender, bing_image.media_url)
        end
      else
        text_message_request_body(sender, text)
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
end