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


# Take a parameter (buster), if player declare dealer winner, else declare player winner.
  handleBust: (who) ->
    if who is 'player'
      @dealerWins()
    else 
      @playerWins() 


# When player busts, declare dealer winner
  playerWins: ->
    alert('You win!')
    @resetGame()

# When dealer busts, declare player winner  
  dealerWins: ->
    alert('Womp womp womp')
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

  # Write tests for standing
  # Broadcast a stand event
  # Write logic for stand event > dealer's turn
