class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    hitCard = @deck.pop()
    @add(hitCard)
    hitCard

  handleScore: ->
    if @scores().indexOf(21) > -1
      @blackJack()
      return
    if @scores()[0] > 21
      @bust()
    if @scores()[0] >= 17 and @isDealer
      @stand()

  bestScore: ->
      bestScore = @scores()[0]
      if @scores()[1] < 22
        bestScore = @scores()[1]
      bestScore

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    [@minScore(), @minScore() + 10 * @hasAce()]

  bust: ->
    @trigger 'bust'

  stand: ->
    @trigger 'stand'

  blackJack: ->
    @trigger 'blackJack'

  playDealerTurn: ->
    @hit() while @scores()[0] < 18
    @handleScore()

  # fix Game.compareScore
  # Broadcast a blackjack event when this hands score is 21