# Main method, initialize Game and pass deck, playerHand, and dealerHand.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'game', new Game(deck, (@get 'playerHand'), (@get 'dealerHand')) 