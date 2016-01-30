class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    hitCard = @deck.pop()
    @add(hitCard)
    if @scores()[0] > 21
      @bust()
    hitCard

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  bust: ->
    @trigger 'bust'

  # Broadcast a blackjack event when this hands score is 21
  
  # Broadcast a bust event for all hands when detect when this hand's score is over 21