class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  play: ->
    while @scores()[0] < 17
      @at(0).flip()
      @hit()
      # if @scores()[0] > 21 then @trigger 'bust'
    if @scores()[0] >= 17 and @scores()[0] < 21
      @stand


  hit: ->
    @add(@deck.pop()).last()
    @trigger 'bust' if @scores()[0] > 21
    @trigger 'blackjack' if @scores()[0] is 21

  stand: ->
    console.log @scores()[0]
    @trigger 'stand'

  doAThing: ->
    console.log 'i am doing a thing'
  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]