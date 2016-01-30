class window.Deck extends Backbone.Collection
  model: Card
  
  # build a new deck of 52 cards, shuffle, 
  initialize: ->
    @populateDeck()

  populateDeck: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        # convert 52 cards to a 0-12 rank
        rank: card % 13
        # convert 52 cards to one of 4 suits
        suit: Math.floor(card / 13)

  # Deck.dealPlayer() creates a new hand, and pops two cards.
  dealPlayer: (hand) -> 
    if !hand
      new Hand [@pop(), @pop()], @
    else
      hand.add [@pop(), @pop()]
  
  # Deck.dealDealer() creates a new hand, and pops two cards, isDealer gets true.
  dealDealer: (hand) -> 
    if !hand
      new Hand [@pop().flip(), @pop()], @, true
    else
      hand.add [@pop().flip(), @pop()]