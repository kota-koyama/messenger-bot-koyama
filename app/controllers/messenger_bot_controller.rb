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
          
        
          if @@flag == 1
            
                      if text.include?("やまP説明書")
                        sender.reply({ text: "これからやまPを攻略します。方法は2つです。"})
                        sender.reply({ text: "一つ目は、時々発生する選択しイベントで評価の選択肢を選択することです。選択によって付与されるポイントが変わってくるので適切とおもわれる回答を選択しましょう!選択によっては減点されてしまうので注意！"})
                        sender.reply({ text: "二つ目は、日常の会話の中でやまPが喜ぶ言葉を見つけましょう！インターネットで「やまP」のことを調べてみましょう！やまPの好きなものや、やまPに関連することを入力してみると何かが起こるかも？逆にやまPが嫌いなことを発言しないように注意！"})
                        sender.reply({ text: "好感度をあげるとやまPとの関係が発展して返ってくる言葉が変化してくるかも・・・！"})
                        sender.reply({ text: "それでは選択肢イベントをためしてみよう！"})
                        sender.reply({"attachment":{
                                      "type":"image",
                                      "payload":{
                                      "url":"http://stat.ameba.jp/user_images/20091117/08/yamabiko141/59/32/j/o0635044310309754271.jpg"
                                                }
                                            }
                                   })
                        sender.reply({ "attachment":{
                                      "type":"template",
                                      "payload":{
                                          "template_type":"button",
                                          "text":"お前、男だったの!?",
                                          "buttons":[
                                              {
                                                  "type":"postback",
                                                  "title":"はい",
                                                  "payload":"1"
                                              },
                                              {
                                                  "type":"postback",
                                                  "title":"なんとも言えない",
                                                  "payload":"1"
                                              },
                                              {
                                                  "type":"postback",
                                                  "title":"いいえ",
                                                  "payload":"1"
                                              }
                                          ]
                                      }
                                   }
                                })
                                        
                      else
                        sender.reply({ text: "やまPだよ"})
                      end  
                      
          elsif @@flag == 2
          
                      if text.include?("5時→9時～私に恋したお坊さん～")
                         @users.yamapoint += 1
                         @users.save
                           sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                           
                      else
                        sender.reply({text: "やまPだよ!!"})
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
     
        
        when "1"
          @users.yamapoint += 1
          @users.save
          @@flag = 2
          sender.reply({"attachment":{
            "type":"image",
            "payload":{
            "url":"http://stat.ameba.jp/user_images/20091117/08/yamabiko141/59/32/j/o0635044310309754271.jpg"
                      }
                  }
         })
          sender.reply({text: "性別なんてなんだって構わないさ！これからよろしく！"})
          sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
          sender.reply({text: "次は好感度アップの言葉を言ってみよう！「5時→9時～私に恋したお坊さん～」と入力してみましょう！"})
       
          
          
                        
                              
         
        
    end
  end
  
 
end