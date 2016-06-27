class MessengerBotController < ActionController::Base

      def message(event, sender)
            text = event['message']['text']
            user_id = event['sender']['id']
          
          if User.find_by(user_id: user_id).nil?
            @users = User.new
            @users.user_id = user_id
            @users.userpoint = 0
            @users.save
          
          else
            @users = User.find_by(user_id: user_id)
          end
          
          # profile = sender.get_profile(field) # default field [:locale, :timezone, :gender, :first_name, :last_name, :profile_pic]
      
          if text == "おはよう"
            
            sender.reply({ text: "おはよう" })
            
          
          elsif text == "かんな！"
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
                      
          else 
            @point = @users.userpoint + 1
            @users.userpoint = @point
            @users.update(users_params)
                sender.reply({ text: "今は言葉を返してくれる人がいないよ！「かんな！」と呼んでみて！#{@users.userpoint}"})
          
          end
              
      end
        
  
    

  def delivery(event, sender)
  end

  def postback(event, sender)
    user_id = event['sender']['id']
     @users = User.find_by(user_id: user_id)
    
    payload = event["postback"]["payload"]
    
    case payload
    
       when "OVER" 
         sender.reply({ text: "それじゃぁ、好きなタイプの男の子を選んでね！" })
         sender.reply({ "attachment":{
                        "type":"template",
                        "payload":{
                            "template_type":"generic",
                            "elements":[
                                {
                                    "title":"さとみ",
                                    "image_url":"http://cdn-ak.f.st-hatena.com/images/fotolife/R/ROUTE53/20150515/20150515181625.jpg",
                                    "subtitle":"ひたすらかわいい！たまに計算高いけど間接キスできたらこっちのもの！",
                                    "buttons":[
                                        {
                                            "type":"postback",
                                            "title":"さとみ一択！",
                                            "payload":"satomi_choice"
                                        }
                                        
                                    ]
                                },
                                {
                                    "title":"はるか",
                                    "image_url":"http://img.laughy.jp/12186/default_7610bda4c74c6d51f83617e318f8e096.jpg",
                                    "subtitle":"とんでもない天然…しかし、本気になったとき何でもすごい！",
                                    "buttons":[
                                        {
                                            "type":"postback",
                                            "title":"はるか一択！",
                                            "payload":"haruka_choice"
                                        }               
                                    ]
                                },
                                {
                                    "title":"すず",
                                    "image_url":"http://contents.oricon.co.jp/photo/img/1000/1794/detail/img660/1458092117458.jpg",
                                    "subtitle":"とてもかわいい妹系！どうやってDACに入社したのか・・・",
                                    "buttons":[
                                        {
                                            "type":"postback",
                                            "title":"すず一択！",
                                            "payload":"suzu_choice"
                                        }               
                                    ]
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
        
        when "satomi_choice"
          
          sender.reply({ text: "g" })
       
          
        when "haruka_choice"
      
          sender.reply({ text: "i" })
         
          
        when "suzu_choice"

          sender.reply({ text: "r" })
     
        
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
        
    end
  end
  
 
end