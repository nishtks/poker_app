module V1 #v1>root
    class Root < Grape::API #classを作成して,GRAPEを継承
      version 'v1'#, using: :path #https://github.com/ruby-grape/grape#versioning
      prefix 'api/' #なんか必要っぽい.Basic Usageに記載あり
      format :json #Json形式の指定.Basic Usageに記載あり
      mount V1::Cards  # api/v1/cards　の上に居る

    end
end