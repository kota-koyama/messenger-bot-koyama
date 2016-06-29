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
                         @@flag = 3
                          sender.reply({ "attachment":{
                                          "type":"template",
                                          "payload":{
                                              "template_type":"generic",
                                              "elements":[
                                                  {
                                                      "title":"ドラマみてくれてたんだ！ありがとう！",
                                                      "image_url":"http://im4-a.mbokimg.dena.ne.jp/3/7/027/482665027.1.jpg",
                                                      "subtitle":"DVDも買ってくれたら嬉しいな…",
                                                      "buttons":[
                                                          {
                                                              "type":"web_url",
                                                              "url":"https://www.amazon.co.jp/5%E2%86%929-5%E6%99%82%E3%81%8B%E3%82%899%E6%99%82%E3%81%BE%E3%81%A7-~%E7%A7%81%E3%81%AB%E6%81%8B%E3%81%97%E3%81%9F%E3%81%8A%E5%9D%8A%E3%81%95%E3%82%93~-DVD-BOX/dp/B019BSE9VM",
                                                              "title":"詳細をHPで見る"
                                                          }
                                                          
                                                      ]
                                                  }
                                                  
                                              ]
                                          }
                                      }
                                  })

                           sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                           sender.reply({text: "それと、これは悲しいお話なんだけど、もしやまPとうまく行かなかったら「別れる」と入力してね…男の子の選択からやり直せるよ！"})
                           sender.reply({text: "これで説明は終わり！あとはあなたとやまPだけの時間になります！素敵な恋物語の始まり始まり！"})
                           
                      else
                        sender.reply({text: "やまPだよ!!"})
                      end
                      
          elsif @@flag == 3 
          
                      if text.include?("のぶた") || text.include?("野ブタ") || text.include?("野ぶた") 
                        @users.yamapoint += 1
                         @users.save
                        sender.reply({text: "彰だっちゃ"})
                        sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                        
                      elsif text.include?("千葉県")
                        @users.yamapoint += 1
                         @users.save
                        sender.reply({text: "思い出たくさんなんだ"})
                        sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                        
                      elsif text.include?("クロサギ") || text.include?("くろさぎ") || text.include?("シロサギ")
                        @users.yamapoint += 1
                         @users.save
                        sender.reply({text: "シロサギは例外なく俺の餌だ"})
                        sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                        
                      elsif text.include?("コード・ブルー") || text.include?("コードブルー") || text.include?("こーどぶるー")
                        @users.yamapoint += 1
                         @users.save
                        sender.reply({text: "ドクターヘリってすごいよね！"})
                        sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                        
                      elsif text.include?("ブザー・ビート") || text.include?("ブザービート") || text.include?("ぶざーびーと")
                        @users.yamapoint += 1
                         @users.save
                        sender.reply({text: "今度バスケットボールしよ！ワン　オン　ワン！ワンワン♪"})
                        sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                        
                      elsif text.include?("SUMMER NUDE") || text.include?("サマーヌード") || text.include?("さまーぬーど")
                      @users.yamapoint += 1 
                         @users.save
                        sender.reply({text: "ロケ地の海がきれいだったなぁ…今度海いこうね！"})
                        sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                        
                      elsif text.include?("アルジャ") || text.include?("あるじゃ") 
                        @users.yamapoint += 1
                         @users.save
                        sender.reply({text: "あいきょでしょ‼︎"})
                        sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                        
                      elsif text.include?("タッキー" )|| text.include?("滝沢") || text.include?("たっきー")
                        @users.yamapoint += 1
                         @users.save
                        sender.reply({text: "俺にとってはいつまでも憧れの人だね！"})
                        sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                        
                      elsif text.include?("修二と彰") || text.include?("彰") || text.include?("あきら")
                        @users.yamapoint += 1
                         @users.save
                        sender.reply({text: "なつかしいなぁ…カラオケランキング良くて嬉しかったな！"})
                        sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                        
                      elsif text.include?("修二と彰") || text.include?("彰") || text.include?("あきら") || text.include?("青春アミーゴ") || text.include?("抱いてセニョリータ")
                        @users.yamapoint += 1
                         @users.save
                        sender.reply({text: "なつかしいなぁ…カラオケランキング良くて嬉しかったな！"})
                        sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                        
                      elsif text.include?("白虎隊") || text.include?("びゃっこ") || text.include?("みねじ") || text.include?("峰治")
                        @users.yamapoint += 1
                         @users.save
                        sender.reply({text: "精米業を営んでおります。"})
                        sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                        
                      elsif text.include?("明日のジョー") || text.include?("明日のじょー") || text.include?("あしたのじょー") || text.include?("あしたのじょう")
                        @users.yamapoint += 1
                         @users.save
                        sender.reply({text: "立つんだ、立つんだジョー"})
                        sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                        
                    　elsif text.include?("すねお") || text.include?("スネ夫") || text.include?("スネオ") || text.include?("すねちゃま") || text.include?("スネちゃま") || text.include?("ほねかわ") || text.include?("骨川")
                        @users.yamapoint += 1
                         @users.save
                        sender.reply({text: "車のCMってお金かけるんだなぁって思う"})
                        sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                      
                      elsif text.include?("テラフォーマーズ") || text.include?("テラホー") || text.include?("てらほーまー") || text.include?("てらふぉーまーず") || text.include?("ティン" ) || text.include?("武藤仁")
                        @users.yamapoint += 1
                         @users.save
                        sender.reply({"attachment":{
                                      "type":"image",
                                      "payload":{
                                      "url":"http://kumasim.jp/wp-content/uploads/2015/07/05_01.jpg"
                                                }
                                            }
                                   })
                        sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                        
                      elsif ext.include?("sound tripper") || text.include?("Sound Tripper") || text.include?("Sound tripper") || text.include?("sound Tripper")
                        @users.yamapoint += 1
                         @users.save
                        sender.reply({text: "聞いてくれてるの！嬉しいな！ラジオの仕事って本当に楽しいんだ。"})
                        sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                        
                      elsif text == "別れる"
                                                 sender.reply({ "attachment":{
                                    "type":"template",
                                    "payload":{
                                        "template_type":"button",
                                        "text":"本当に俺と別れるの？",
                                        "buttons":[
                                            {
                                                "type":"postback",
                                                "title":"はい",
                                                "payload":"2"
                                            },
                                            {
                                                "type":"postback",
                                                "title":"いいえ",
                                                "payload":"3"
                                            }
                                        ]
                                    }
                                 }
                              })
                        　
                        
                      else
                        sender.reply({text: "てすと"})
                      
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
       
      when "2"
            @@flag = nil
             sender.reply({ text: "今は言葉を返してくれる人がいないよ！「かんな！」と呼んでみて！"})
                      
      when "3"
           
           sender.reply({ text: "脅かさないでくれよ・・・"})    
                              
         
        
    end
  end
  
 
end