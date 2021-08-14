class CardsController < ApplicationController
  def top
  end

  def submit
    @card = params[:content] #form_tag のname="content"をCardに代入する
    @card_array = @card.scan(/\S+/)
    @card_length = @card_array.length
    @card_count = @card_array.group_by(&:itself).length

    # カードの枚数と重複を確認
    if  @card_length < 5
        @v_message1 ="カード枚数が不足しています 5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
    elsif @card_length > 5
        @v_message1 ="カード枚数が多いです 5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
    elsif @card_count != 5
        @v_message2 = "カードが重複しています"
    end

    # カードのスートと数字を確認
    @card_array.each.with_index(1) do |content,i| 
      if  content.match(/[DHCS](1[0-3]|[1-9])$/) 
      elsif
          @v_message3 = "#{i}番目の#{content}は不正なカードです.スートDHCS,数字1〜13の組み合わせで入力してください.(例：S1)"
          #上書きしてるから最後のカードの不正をチェックしている
      end
    end

  # エラーがなければ役判定に飛ばす
  # render ではViewファイルを引数として指定する必要がある
    if  @v_message1
      render("cards/top")
    elsif @v_message2
      render("cards/top")
    elsif @v_message3
      render("cards/top")
    elsif
    # redirect_to("/cards/judge",:content)
    # redirect_toではURLを指定する
    redirect_to action: 'judge' ,content: params[:content]
    end

  end


  def judge
    @card = params[:content]
    @card_array = @card.scan(/\S+/)
    @card_count = @card_array.group_by(&:itself).length
    @card_num = @card.scan(/\d+/).map(&:to_i).sort
      #[1, 2, 3, 4, 5]
    @card_suit = @card.scan(/[DHCS]/)
      #["D", "D", "D", "D", "C"]
    @num_count = @card_num.uniq.size
    @suit_count = @card_suit.uniq.size
      #irb(main):001:0> card = "D1 C1 S1 H1 H4"
      #irb(main):003:0> card.scan(/[DHCS]/)
      #=> ["D", "C", "S", "H", "H"]
      #irb(main):004:0> card.scan(/[DHCS]/).uniq.size
      #=> 4
    @suit_count_detail = @card_suit.group_by(&:itself).transform_values(&:size)
      #{"D"=>4, "C"=>1}
    @num_count_detail = @card_num.group_by(&:itself).transform_values(&:size)      
    @s= @card_num.each_cons(2).sum{|l,r| (l - r).abs}

    if 
      @suit_count == 1 and ( @s == 4 or @s == 12)
      @j_message = "ストレートフラッシュ" 
    elsif 
      @num_count == 2 and @num_count_detail.values.max == 4 
      @j_message = "フォー・オブ・ア・カインド" 
    elsif 
      @num_count == 2 and @num_count_detail.values.max == 3 
      @j_message = "フルハウス" 
    elsif 
      @suit_count == 1
      @j_message = "フラッシュ" 
    elsif 
      @s == 4
      @j_message = "ストレート" 

    elsif 
      @num_count == 3 and @num_count_detail.values.max == 3 
      @j_message = "スリー・オブ・ア・カインド" 
    elsif 
      @num_count == 3 and @num_count_detail.values.max == 2 
      @j_message = "ツーペア" 
    elsif 
      @num_count == 4 and @num_count_detail.values.max == 2 
      @j_message = "ワンペア" 

    elsif
      @j_message = "ハイカード"
    end
    render("cards/top")
  end



end
