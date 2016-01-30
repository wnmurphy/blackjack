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
    alert('You win!')
    @resetGame()

# When dealer busts, declare player winner  
  dealerWins: ->
    alert('Womp womp womp')
    @resetGame()

# Rest game if tie
  push: ->
    alert("It's a tie!")
    @resetGame()

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