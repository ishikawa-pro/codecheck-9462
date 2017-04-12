require 'net/http'
require 'json'

def main(argv)    
    begin
      #パラメータがない場合は標準エラー出力にエラーメッセージを出力する
      if argv[0] == nil then
        raise "パラメータがセットされていません"
      end
      argv.each do |v|
          #パラメータをセット
          param = v.to_s 
          #urlを作成
          uri = URI.parse('http://challenge-server.code-check.io/api/hash?q='+param)
          
          request = Net::HTTP::Get.new(uri.request_uri)
          # Request headers
          request['Content-Type'] = 'application/json'
          
          #APIを叩いて結果をresponseへ代入
          response = Net::HTTP.start(uri.host, uri.port) do |http|
              http.request(request)
          end
          #結果をjsonにパースして格納
          result = JSON.parse(response.body)
          #ハッシュ値のみを出力
          puts result['hash']
      end
    rescue => e
      #標準エラーを出力
      p e.message
    end
end
