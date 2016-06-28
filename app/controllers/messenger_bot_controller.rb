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
          
        
          if @@flag = 1
            
                      if text.include?("やまP説明書")
                        sender.reply({ text: "これからやまPを攻略します。方法は2つです。"})
                        sender.reply({ text: "一つ目は、時々発生する選択しイベントで評価の選択肢を選択することです。選択によって付与されるポイントが変わってくるので適切とおもわれる回答を選択しましょう!
                                              選択によっては減点されてしまうので注意！"})
                        sender.reply({ text: "二つ目は、日常の会話の中でやまPが喜ぶ言葉を見つけましょう！インターネットで「やまP」のことを調べてみましょう！やまPの好きなものや、やまPに関連することを入力
                                              してみると何かが起こるかも？逆にやまPが嫌いなことを発言しないように注意！"})
                        sender.reply({ text: "好感度をあげるとやまPとの関係が発展して返ってくる言葉が変化してくるかも・・・！"})
                        
                      else
                        sender.reply({ text: "やまPだよ"})
                      end  
                      
          else
                      if text.include?("おはよう")
                        
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
                        
                        @users.userpoint += 1
                        @users.save
                            sender.reply({ text: "今は言葉を返してくれる人がいないよ！「かんな！」と呼んでみて！#{@users.userpoint}"})
                      
                      end
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
                                    "title":"やまP",
                                    "image_url":"http://userdisk.webry.biglobe.ne.jp/017/341/37/N000/000/018/144686495833049792180_151107hh.PNG",
                                    "subtitle":"至高のイケメン。テレビでは色々な顔を見せるアイドル。普段は何を考えているのかわからないミステリアスさが魅力",
                                    "buttons":[
                                        {
                                            "type":"postback",
                                            "title":"やまP一択！",
                                            "payload":"yamasita_choice"
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
        
        when "yamasita_choice"
          @users.yamapoint = 1
          @users.save
          @@flag = 1
          sender.reply({ text: "やまPに決定！やまPの好感度が#{@users.yamapoint}になったよ！" })
        　sender.reply({ text: "それではやまP攻略のコツを教えるよ！「やまPの説明書」と入力してみてね！"})
       
          
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