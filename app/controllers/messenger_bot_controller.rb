class MessengerBotController < ActionController::Base
  
    require 'json'
    require 'open-uri'
    require 'uri'
    require 'openssl'
    require 'net/http'
    
  USER_LOCAL_ID = 'b8d9c896e319e72ff91a'

      def message(event, sender)
            text = event['message']['text']
            user_id = event['sender']['id']
            @profile = sender.get_profile[:body]
            @nick_name = URI.escape("https://chatbot-api.userlocal.jp/api/name?name=#{@profile['last_name']} #{@profile['first_name']}&key=#{USER_LOCAL_ID}")
            @oknickname = JSON.load(open(@nick_name).read)
            @localapi = URI.escape("https://chatbot-api.userlocal.jp/api/chat?key=#{USER_LOCAL_ID}&message=#{text}")
            @response = JSON.load(open(@localapi).read)
            @yamasita = "山P"||"山下"||"智久"||"やまP"||"やまピー"||"やまぴー"||"山ぴー"||"山ピー"||"やまp"||"山p"
          
          if User.find_by(user_id: user_id).nil?
            @users = User.new
            @users.user_id = user_id
            @users.userpoint = 0
            @users.save
          
          else
            @users = User.find_by(user_id: user_id)
          end
          
          # profile = sender.get_profile(field) # default field [:locale, :timezone, :gender, :first_name, :last_name, :profile_pic]
        
          if @users.userpoint == 1
            
                      if text.include?("説明書")
                        sender.reply({ text: "これからやまPを攻略するよ！。方法は2つ！"})
                        sender.reply({ text: "一つ目は、時々発生する選択肢イベント！やまPの質問に選択肢で回答！選択によって好感度UP or DOWN！"})
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
                        sender.reply({ text: "説明書と入力してみよう！"})
                      end  
                      
          elsif @users.userpoint == 2
          
                      if text.include?("5時→9時")||text.include?("5じ9じ")||text.include?("5時9時")||text.include?("５時９時")||text.include?("５じ９じ")
                        @users.userpoint = 3
                         @users.yamapoint += 1
                         @users.save
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
                           sender.reply({text: "グレート！"})
                           sender.reply({text: "あと一つだけ・・・「別れる」と打つとやまPと別れて男の子を選択し直せるよ・・・"})
                           sender.reply({text: "これで説明は終わり！あとはあなたとやまPだけの時間になります！素敵な恋物語の始まり始まり！"})
                           
                      else
                        sender.reply({text: "５時９時と入力してみよう！"})
                      end
                      
          elsif @users.userpoint == 3 
          
                if  @users.yamapoint > 5
  
                      @users.userpoint = 4
                      @users.save
                        sender.reply({ text: "好感度が5を超えたので、やまPとの関係が発展しました！"})
                        sender.reply({"attachment":{
                                      "type":"image",
                                      "payload":{
                                      "url":"http://pr.cgiboy.com/image/483/960/11960483.jpeg"
                                                }
                                            }
                                   })
                        sender.reply({text: "#{@profile['last_name']}と話してると楽しいな！仲良くなってきたしアダ名で呼びたいなぁ・・・#{@oknickname['result']['nickname'].first}って呼ぶね！"})
                
                else
          
                          if text.include?("のぶた") || text.include?("野ブタ") || text.include?("野ぶた") 
                            @users.yamapoint += 1
                             @users.save
                            sender.reply({text: "彰だっちゃ"})
                            sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                            
                          elsif text.include?("千葉県")
                            @users.yamapoint += 1
                             @users.save
                            sender.reply({text: "#{@profile['last_name']}も千葉県に遊びに来てね！"})
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
                            sender.reply({text: "今度バスケットボールしよ！#{@profile['last_name']}とワン　オン　ワン！ワンワン♪"})
                            sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                            
                          elsif text.include?("SUMMER NUDE") || text.include?("サマーヌード") || text.include?("さまーぬーど")
                          @users.yamapoint += 1 
                             @users.save
                            sender.reply({text: "ロケ地の海がきれいだったなぁ…#{@profile['last_name']}と一緒に海いきたいな！"})
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
                            sender.reply({text: "なつかしいなぁ…カラオケランキング良くて嬉しかったな！そうだ#{@profile['last_name']}カラオケ行こう！"})
                            sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                          
                          elsif text.include?("白虎隊") || text.include?("びゃっこ") || text.include?("みねじ") || text.include?("峰治")
                            @users.yamapoint += 1
                             @users.save
                            sender.reply({text: "精米業を営んでおります。"})
                            sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                            
                          elsif text.include?("明日のジョー") || text.include?("明日のじょー") || text.include?("あしたのじょー") || text.include?("あしたのじょう")
                            @users.yamapoint += 1
                             @users.save
                            sender.reply({text: "立つんだ、立つんだ#{@profile['last_name']}"})
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
                            
                          elsif text.include?("sound tripper") || text.include?("Sound Tripper") || text.include?("Sound tripper") || text.include?("sound Tripper")
                            @users.yamapoint += 1
                             @users.save
                            sender.reply({text: "聞いてくれてるの！嬉しいな！ラジオの仕事って本当に楽しいんだ。"})
                                  sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                                  
                          elsif text.include?("プロポーズ") || text.include?("大作戦") 
                            @users.yamapoint += 1
                             @users.save
                            sender.reply({text: "ハレルヤー・・・チャンス！"})
                            sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                          
                         
                            
                          elsif text == "別れる"
                          
                                sender.reply({"attachment":{
                                      "type":"image",
                                      "payload":{
                                      "url":"http://img-cdn.jg.jugem.jp/fe9/1778029/20150506_1062817.jpg"
                                                }
                                            }
                                   })
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
                          elsif text == "テスト"
                                sender.reply({ text: "#{@profile['last_name']} #{@profile['first_name']}さんこんにちは！#{@profile['gender']}" })
       
                          else
                              
                              sender.reply({ text: "#{@response['result']}" })
                          end
                end
                              
         
         
          elsif @users.userpoint == 4
                    
                if @users.yamapoint > 10
                   @users.userpoint = 5
                      @users.save
                        sender.reply({ text: "好感度が10を超えたので、やまPとの関係が発展しました！"})
                        sender.reply({"attachment":{
                                      "type":"image",
                                      "payload":{
                                      "url":"http://img1.gtimg.com/ent/pics/hv1/156/190/1300/84581106.jpg"
                                                }
                                            }
                                   })
                        sender.reply({text: "俺、#{@profile['first_name']}の事好きになっちゃった。"})
                else
                  
                    if text.include?("親子丼" )|| text.include?("おやこどん")
                            @users.yamapoint += 1
                             @users.save
                            sender.reply({text: "親子丼大好き！"})
                            sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                            
                    elsif text.include?("カレー") || text.include?("かれー")
                      @users.yamapoint += 1
                       @users.save
                      sender.reply({text: "カレーライス最高だよね！"})
                      sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                      
                    elsif text.include?("ラーメン")
                      @users.yamapoint += 1
                       @users.save
                      sender.reply({text: "アァ・・・ラーメンの海を泳ぎたい"})
                      sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                      
                    elsif text.include?("酒")
                      @users.yamapoint += 1
                       @users.save
                      sender.reply({text: "俺、酔うと歌いたくなるんだよね！"})
                      sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                      
                    elsif text.include?("テンピュール")
                      @users.yamapoint += 1
                       @users.save
                      sender.reply({text: "テンピュールの枕がなければ生きてい行けぬ"})
                      sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                      
                    elsif text.include?("都市伝説") 
                      @users.yamapoint += 1
                       @users.save
                      sender.reply({text: "アァ・・・そのミステリアスな響きワクワクする！"})
                      sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                    
                    elsif text.include?("脚") || text.include?("胸")|| text.include?("巨乳") 
                      @users.yamapoint += 1
                       @users.save
                      sender.reply({text: "脚フェチで、バストが大きいといいね！"})
                      sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                      
                    elsif text.include?("sound tripper") || text.include?("Sound Tripper") || text.include?("Sound tripper") || text.include?("sound Tripper")
                      @users.yamapoint += 1
                       @users.save
                      sender.reply({text: "聞いてくれてるの！嬉しいな！ラジオの仕事って本当に楽しいんだ。"})
                            sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
                
                    elsif text == "テスト"
                          sender.reply({ text: "#{@profile['last_name']} #{@profile['first_name']}さんこんにちは！#{@profile['gender']}" })
                          
                    elsif text == "別れる"
                                sender.reply({"attachment":{
                                      "type":"image",
                                      "payload":{
                                      "url":"http://img-cdn.jg.jugem.jp/fe9/1778029/20150506_1062817.jpg"
                                                }
                                            }
                                   })
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
                    
                    elsif text == "ニックネーム"
                       
                        sender.reply({text: "#{@oknickname['result']['nickname'].first}"})
                            sender.reply({text: "今は好きしか言いたくない気分なんだ"})
                        
                    else
                        if rand(9) + 1 == 5
                          sender.reply({ "attachment":{
                                              "type":"template",
                                              "payload":{
                                                  "template_type":"button",
                                                  "text":"#{@oknickname['result']['nickname'].first}はところてんと酢豚ならどっちが好き？",
                                                  "buttons":[
                                                      {
                                                          "type":"postback",
                                                          "title":"ところてん",
                                                          "payload":"tokoroten"
                                                      },
                                                      {
                                                          "type":"postback",
                                                          "title":"選択肢おかしくない？",
                                                          "payload":"X"
                                                      },
                                                      {
                                                          "type":"postback",
                                                          "title":"酢豚",
                                                          "payload":"subuta"
                                                      }
                                                  ]
                                              }
                                           }
                                        })
                        elsif rand(9) + 1 == 2
                            sender.reply({ "attachment":{
                                                  "type":"template",
                                                  "payload":{
                                                      "template_type":"button",
                                                      "text":"#{@oknickname['result']['nickname'].first}はデートで行くなら映画館とディズニーランドどっちがいい？",
                                                      "buttons":[
                                                          {
                                                              "type":"postback",
                                                              "title":"映画館",
                                                              "payload":"eiga"
                                                          },
                                                          {
                                                              "type":"postback",
                                                              "title":"ディズニーランド",
                                                              "payload":"D"
                                                          }
                                                      ]
                                                  }
                                               }
                                            })
                        elsif rand(9) + 1 == 3
                            sender.reply({ "attachment":{
                                                  "type":"template",
                                                  "payload":{
                                                      "template_type":"button",
                                                      "text":"#{@oknickname['result']['nickname'].first}は海派？山派？",
                                                      "buttons":[
                                                          {
                                                              "type":"postback",
                                                              "title":"海派",
                                                              "payload":"umi"
                                                          },
                                                          {
                                                              "type":"postback",
                                                              "title":"山派",
                                                              "payload":"yama"
                                                          }
                                                      ]
                                                  }
                                               }
                                            })
                        
                       
                        else   
                          sender.reply({ text: "#{@response['result']}" })
                        end
                      
                    end
                
                end
                
          elsif @users.userpoint == 5
                if text =="好き"|| text.include?("#{@yamasita}好き") || text.include?("#{@yamasita}すき")||text.include?("#{@yamasita}スキ")||text.include?("好き")
                
                sender.reply({ text: "俺は#{@profile['first_name']}の事宇宙で一番好きだよ" })
                
                elsif text.include?("デート")
                
                sender.reply({ text: "#{@profile['first_name']}とだったらどこでデートするのも楽しいと思う！" })
                
                elsif text == ("#{@yamasita}")
                
                sender.reply({ text: "#{@profile['first_name']}どうしたの？" })
                
                elsif text == "別れる"
                                sender.reply({"attachment":{
                                      "type":"image",
                                      "payload":{
                                      "url":"http://img-cdn.jg.jugem.jp/fe9/1778029/20150506_1062817.jpg"
                                                }
                                            }
                                   })
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
                
                    if rand(9) + 1 == 3
                    sender.reply({ text: "今は好きしか言いたくない気分なんだ。#{@profile['first_name']}好きだよ。" })
                    
                    elsif rand(9) + 1 == 4
                    sender.reply({ text: "ごめん。今夜#{@profile['first_name']}の夢見られるようにお祈り中！" })
                    
                    elsif rand(9) + 1 == 5
                    sender.reply({ text: "なんでもいいけど#{@profile['first_name']}に会いたい！" })
                    
                    else
                    sender.reply({ text: "#{@response['result']}" })
                    end
                end  
                
          elsif @users.userpoint == 0
                      if text.include?("おはよう")
                        
                        sender.reply({ text: "おはよう" })
                        
                      
                      elsif text.include?("かんな")
                          sender.reply({ "attachment":{
                                      "type":"template",
                                      "payload":{
                                          "template_type":"generic",
                                          "elements":[
                                              {
                                                  "title":"こんにちは！#{@profile['last_name']}さん！私は案内人のかんなです！",
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
                                    "image_url":"http://geinou0999.up.seesaa.net/image/2009012914162327290.jpg",
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
                                    "title":"翔君",
                                    "image_url":"http://e.blog.xuite.net/e/4/6/7/25663626/blog_2465113/txt/56675990/2.jpg",
                                    "subtitle":"マイルドなイケメンだけど中身はクール！しょう君の多彩さにはみんなメロメロ。。。",
                                    "buttons":[
                                        {
                                            "type":"postback",
                                            "title":"翔君一択！",
                                            "payload":"haruka_choice"
                                        }               
                                    ]
                                },
                                {
                                    "title":"松潤",
                                    "image_url":"https://pbs.twimg.com/profile_images/378800000165087594/231b01998d0f996d81b030d0cc4f7b3a.png",
                                    "subtitle":"凛々しさを感じるイケメン！情熱的なところや負けず嫌いなところにキュンとくる！",
                                    "buttons":[
                                        {
                                            "type":"postback",
                                            "title":"松潤一択",
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
          @users.userpoint = 1
          @users.yamapoint = 1
          @users.save
          sender.reply({ text: "やまPに決定！やまPの好感度が#{@users.yamapoint}になったよ！それではやまP攻略のコツを教えるよ！「やまPの説明書」と入力してみてね！" })
       
          
        when "haruka_choice"
      
          sender.reply({ text: "i" })
         
          
        when "suzu_choice"

          sender.reply({ text: "r" })
     
        
        when "1"
          @users.userpoint = 2
          @users.yamapoint += 1
          @users.save
          sender.reply({"attachment":{
            "type":"image",
            "payload":{
            "url":"http://stat.ameba.jp/user_images/20091117/08/yamabiko141/59/32/j/o0635044310309754271.jpg"
                      }
                  }
         })
          sender.reply({text: "性別なんてなんだって構わないさ！これからよろしく！"})
          sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
          sender.reply({text: "ナイス！やまPのハートをバッチリつかみ始めてるよ！"})
          sender.reply({text: "二つ目は、やまPに関することを調べて入力！場合によっては好感度UP or DOWN！"})
          sender.reply({text: "今回は特別にキーワードを教えるよ！やまPに「5時→9時」と送ってみよう！"})
          
       
        when "2"
            @users.userpoint = 0
            @users.save
            sender.reply({ text: "今は言葉を返してくれる人がいないよ！「かんな！」と呼んでみて！"})
                        
        when "3"
             
             sender.reply({ text: "脅かさないでくれよ・・・"})
       
        when "tokoroten"
          @users.yamapoint += 1
          @users.save
          sender.reply({ text: "ところてんだよね！"})
          sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
          
        when "X"
          sender.reply({ text: "確かにね笑"})
        when "subuta"
          @users.yamapoint -= 1
          @users.save
          sender.reply({ text: "そっかぁ・・・"})
          sender.reply({text: "好感度が#{@users.yamapoint}に下がりました。"})
        
        when "eiga"
            
          @users.yamapoint += 1
          @users.save
          sender.reply({ text: "やっぱり映画だよね！"})
          sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})
          
        
        when "D"
          sender.reply({ text: "そっかぁ・・・"})
        when "yama"
          @users.yamapoint += 1
          @users.save
          sender.reply({ text: "山もいいよね！"})
          sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})

        when "umi"
          @users.yamapoint += 2
          @users.save
          sender.reply({ text: "海いいよね！"})
          sender.reply({text: "好感度が#{@users.yamapoint}に上がりました。"})

    end
  end
  
 
end