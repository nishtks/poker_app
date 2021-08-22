class Card < ApplicationRecord
    #DB設計は      t.string :cards
    def hand_validation
        errors = [] #エラー内容を格納する箱
        @card = self.cards
        @card_array = @card.scan(/\S+/)
        @card_length = @card_array.length
        @card_count = @card_array.group_by(&:itself).length
        @card_length = @card_array.length
        @card_count = @card_array.group_by(&:itself).length
        @card_num = @card.scan(/\d+/).map(&:to_i).sort
        @card_suit = @card.scan(/[DHCS]/)
        @num_count = @card_num.uniq.size
        @suit_count = @card_suit.uniq.size
        @suit_count_detail = @card_suit.group_by(&:itself).transform_values(&:size)
        @num_count_detail = @card_num.group_by(&:itself).transform_values(&:size)
        @s= @card_num.each_cons(2).sum{|l,r| (l - r).abs} #SUM{隣あう数字の差分}

        # カードの枚数と重複を確認
        if  @card_length < 5
            @v_message1 ="カード枚数が不足しています。5つのカード指定文字を半角スペース区切りで入力してください（例：S1 H3 D9 C13 S11）。"
        elsif @card_length > 5
            @v_message1 ="カード枚数が多いです。5つのカード指定文字を半角スペース区切りで入力してください（例：S1 H3 D9 C13 S11）。"
        elsif @card_count != 5
            @v_message1 = "カードが重複しています。"
        elsif
            @v_message1 == nil
        end

        # カードのスートと数字を確認
        @card_array.each.with_index(1) do |content,i|
            if  content.match(/[DHCS](1[0-3]|[1-9])$/)
            elsif
                @v_message2 = "#{i}番目の「#{content}」は不正なカードです。スートDHCS,数字1〜13の組み合わせで入力してください(例：S1)。"
                #上書きしてるから最後のカードの不正をチェックしている
            end
        end #Scan

        #バリデーションひっかかったやつらを選定
        if @v_message1 or @v_message2
            error_statement = "" #error格納先を作成
            if @v_message1
            error_statement << @v_message1
            end
            if @v_message2
            error_statement << @v_message2
            end
            if error_statement
            error_element = {
                            "card": @card,
                            "error": error_statement
                            }
            errors.push error_element #push method で配列にresult_element追加
            end

            @v_message1 = nil #initialize
            @v_message2 = nil #initialize
            return errors
        end #@v_message1 or @v_message2
    end # def validation


    def hand_judge
        judges = []
        hand_validation #変数を受け継ぐ
        if @suit_count == 1 and ( @s == 4 or @s == 12)
            @j_message = "ストレートフラッシュ"
            rank = "1"
            best = "false"
        elsif @num_count == 2 and @num_count_detail.values.max == 4
            @j_message = "フォー・オブ・ア・カインド"
            rank = "2"
            best = "false"
        elsif @num_count == 2 and @num_count_detail.values.max == 3
            @j_message = "フルハウス"
            rank = "3"
            best = "false"
        elsif @suit_count == 1
            @j_message = "フラッシュ"
            rank = "4"
            best = "false"
        elsif @s == 4
            @j_message = "ストレート"
            rank = "5"
            best = "false"
        elsif @num_count == 3 and @num_count_detail.values.max == 3
            @j_message = "スリー・オブ・ア・カインド"
            rank = "6"
            best = "false"
        elsif @num_count == 3 and @num_count_detail.values.max == 2
            @j_message = "ツーペア"
            rank = "7"
        elsif @num_count == 4 and @num_count_detail.values.max == 2
            @j_message = "ワンペア"
            rank = "8"
            best = "false"
        elsif
            @j_message == "ハイカード"
            rank = "9"
            best = "false"
        end #yaku hantei

        if @j_message
            judge_statement = @j_message
            judge_element = {
                            "card": @card,
                            "judge": judge_statement,
                            "best": best
                            }
            judges.push judge_element #push method で配列にjudge_element追加
        end #if @j_message

        @j_message = nil #initialize
        ranking = judges.sort_by!{|a| a[:rank]}
        ranking[0][:best] = "true"
        return judges
    end #def hand_judge
end #Card < ApplicationRecord

