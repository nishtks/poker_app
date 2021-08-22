module Base #base>api
    class API < Grape::API #classを作って継承
      # あとあと↓のようにしてAPIをマウントするが、今はV1::Rootが無いのでコメントアウトしておく。
      mount V1::Root #api/v1/root　の上に居る
    end
  end