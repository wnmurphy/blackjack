# Handle Game logic
class window.Game extends Backbone.Model
  initialize: (deck, playerHand, dealerHand) ->
    @set "deck", deck
    @set "playerHand", playerHand
    @set "dealerHand", dealerHand

    @get 'playerHand' 
      .on 'bust', => 
        @handleBust()

    @get 'dealerHand' 
      .on 'bust', => 
        @handleBust()


# Take a parameter (buster), if player declare dealer winner, else declare player winner.
  handleBust: ->

# When player busts, declare dealer winner
  playerWins: ->

# When dealer busts, declare player winner  
  dealerWins: ->