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
                            "template_type":"generic",
                            "elements":[
                                {
                                    "title":"こんにちは！案内人のかんなです！",
                                    "image_url":"http://xn--ecki7azcr4a4m918z.asia/img/i9BNCbxO.jpeg",
                                    "subtitle":"DAC社内恋愛ゲームを始めましょう！",
                                    "buttons":[
                                        {
                                            "type":"postback",
                                            "title":"はい",
                                            "payload":"OVER"
                                        },{
                                            "type":"postback",
                                            "title":"いいえ",
                                            "payload":"UNDER"
                                        }
                                        
                                    ]
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
        sender.reply({"attachment":{
            "type":"image",
            "payload":{
            "url":"https://pbs.twimg.com/profile_images/705260772243320832/cLl8XRdV.jpg"
                      }
                  }
         })
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
        when "3"
          
          
                        
                              
         sender.reply({"attachment":{
            "type":"image",
            "payload":{
            "url":"http://kanna77.blog.so-net.ne.jp/_images/blog/_cf4/kanna77/980-kanna-003_x1000.jpg"
                      }
                  }
         })
         sender.reply({ "attachment":{
                        "type":"template",
                        "payload":{
                            "template_type":"generic",
                            "elements":[
                                {
                                    "title":"【肩こり対策】(1)腕・胸・背中のストレッチ",
                                    "image_url":"http://imgcp.aacdn.jp/img-a/auto/auto/aa/gm/article/1/9/5/4/2/7/ude.jpg",
                                    "subtitle":"片側の腕を後頭部で曲げる。できるだけ肘を曲げるように。肘を反対側の手で後頭部に引っ張る。後頭部で肘を後ろに押すようにする。",
                                    "buttons":[
                                        {
                                            "type":"postback",
                                            "title":"腰痛対策へ",
                                            "payload":"stretching_hip"
                                        },{
                                            "type":"postback",
                                            "title":"足のむくみ対策へ",
                                            "payload":"stretching_leg"
                                        },{
                                            "type":"web_url",
                                            "url":"http://allabout.co.jp/gm/gc/195427/",
                                            "title":"詳細をHPで見る"
                                        }
                                        
                                    ]
                                },
                                {
                                    "title":"【肩こり対策】(2)背中のストレッチ",
                                    "image_url":"http://imgcp.aacdn.jp/img-a/auto/auto/aa/gm/article/1/9/5/4/2/7/senaka.jpg",
                                    "subtitle":"背筋を伸ばして座り、両手でシャツの襟を持つ。両肘を体の正面でつける。首の力を抜いて前へ倒し首の後ろを伸ばす。背中を丸める。この時に肘が下を向くように。",
                                    "buttons":[
                                        {
                                            "type":"web_url",
                                            "url":"http://allabout.co.jp/gm/gc/195427/",
                                            "title":"詳細をHPで見る"
                                        }               
                                    ]
                                },
                                {
                                    "title":"【肩こり対策】(3)胸のストレッチ",
                                    "image_url":"http://imgcp.aacdn.jp/img-a/auto/auto/aa/gm/article/1/9/5/4/2/7/mune.jpg",
                                    "subtitle":"背筋を伸ばして腰の後ろに手を当て両手を組む。両肘を閉じる。この時に肩が上がらないように。首の力を抜いてアゴを上に。こうすると首筋もストレッチできる。",
                                    "buttons":[
                                        {
                                            "type":"web_url",
                                            "url":"http://allabout.co.jp/gm/gc/195427/",
                                            "title":"詳細をHPで見る"
                                        }               
                                    ]
                                }
                            ]
                        }
                    }
                })
    end
  end
  
 
end