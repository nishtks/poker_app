class CardsController < ApplicationController
  def top
  end

  def submit
    @card = Card.new(cards: params[:content])
    @error = @card.hand_validation

    # エラーがなければ役判定に飛ばす render ではViewファイルを引数として指定する必要がある
    if  @error
      render("cards/top")
    elsif
      @judge = @card.hand_judge
      render("cards/top")
    end # if @error
  end #submit
end #class

