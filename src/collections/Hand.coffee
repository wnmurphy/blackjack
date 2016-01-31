class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @chips = 10
    @bet = 1

  hit: ->
    cacheBet = $('input').val()
    hitCard = @deck.pop()
    @add(hitCard)
    @lockInBet(cacheBet)
    hitCard

  handleScore: ->
    if @scores().indexOf(21) > -1
      @blackJack()
      return
    else if @scores()[0] > 21
      @bust()
    else if @scores()[0] >= 17 and @isDealer
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
    @lockInBet()
    @trigger 'stand'

  lockInBet: (cacheBet) ->
    @bet = cacheBet || $('input').val()
    @trigger 'lock'

  blackJack: ->
    @trigger 'blackJack'

  playDealerTurn: ->
    @at(0)
      .flip()
    @hit() while @scores()[0] < 18
    @handleScore()

# if bet > chips, alert "too poor, reduce bet"