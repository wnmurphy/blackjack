# Handle Game logic
class window.Game extends Backbone.Model
  initialize: (deck, playerHand, dealerHand) ->
    @set "deck", deck
    @set "playerHand", playerHand
    @set "dealerHand", dealerHand
    @setEventListeners()

  setEventListeners: ->
    @get 'playerHand' 
      .on 'bust', => 
        @handleBust 'player'

    @get 'dealerHand' 
      .on 'bust', => 
        @handleBust 'dealer'

     @get 'playerHand' 
      .on 'stand', => 
        @handleStand 'player'

    @get 'dealerHand' 
      .on 'stand', => 
        @handleStand 'dealer'

    @get 'playerHand' 
      .on 'blackJack', => 
        @handleBlackJack 'player'

    @get 'dealerHand' 
      .on 'blackJack', => 
        @handleBlackJack 'dealer'

# If player declare dealer winner, else declare player winner.
  handleBust: (who) ->
    if who is 'player'
      @dealerWins()
    else 
      @playerWins() 

  handleStand: (who) ->
    if who is 'player'
      @get 'dealerHand'
        .playDealerTurn()
    else 
      @compareScores()

  handleBlackJack: (who) ->
    if who is 'player'
      @playerWins()
    else 
      @dealerWins()

  compareScores: ->
    playerBestScore = @get 'playerHand'
                        .bestScore()
    dealerBestScore = @get 'dealerHand'
                        .bestScore()
    if playerBestScore < dealerBestScore
      @dealerWins()
    else if playerBestScore > dealerBestScore
      @playerWins()
    else
      @push()

# When player busts, declare dealer winner
  playerWins: ->
    setTimeout => 
      alert('You win!')
      @settleBets('player')
      @resetGame()
    , 100

# When dealer busts, declare player winner  
  dealerWins: ->
    setTimeout =>
      alert('Womp womp womp')
      @settleBets('dealer')
      @resetGame()
    , 100

# Rest game if tie
  push: ->
    setTimeout =>
      alert("It's a tie!")
      @resetGame()
    , 100

# Create new deck, redeal playerHand and dealerHand
  resetGame: ->
    @get "deck"
      .reset()

    @get "deck"
      .populateDeck()

    @get 'playerHand'
      .reset()

    @get "deck"
      .dealPlayer(@get 'playerHand')

    @get 'dealerHand'
      .reset()

    @get "deck"
      .dealDealer(@get 'dealerHand')

    @trigger 'reset'

  settleBets: (winner) ->
    player = @get 'playerHand'
    player.chips -= +player.bet if winner is 'dealer'
    player.chips += +player.bet if winner is 'player'
    if player.chips < 1 
      alert("Y'all are broke. Here's 10 chips on us.")
      player.chips = 10
    player.bet = 1