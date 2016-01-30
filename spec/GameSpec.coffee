assert = chai.assert
expect = chai.expect

describe 'game', ->
  app = null
  game = null

  beforeEach ->
    app = new App()
    game = app.get "game"

  describe 'property access', ->
    it 'should have access to the app deck, playerHand, and dealerHand', ->
      assert.strictEqual (app.get "deck"), (game.get "deck")
      assert.strictEqual (app.get "playerHand"), (game.get "playerHand")
      assert.strictEqual (app.get "dealerHand"), (game.get "dealerHand")

  describe 'game rules', ->

    describe 'busting', ->
     
      beforeEach ->
        game = app.get "game"
        game.resetGame()
        
      it 'should call handleBust when either hand busts', ->
        sinon.spy(game, "handleBust")

        # trigger bust on playerHand
        game.get 'playerHand' 
          .trigger 'bust'
        expect game.handleBust.callCount
          .to
          .be
          .equal 1 

        # trigger bust on dealerHand
        game.get 'dealerHand'
          .trigger 'bust'
        expect game.handleBust.callCount 
          .to
          .be
          .equal 2

      it 'should call playerWins when dealer busts', ->
        sinon.spy(game, "playerWins")

        game.get 'dealerHand' 
          .trigger 'bust'
        expect game.playerWins.callCount
          .to
          .be
          .equal 1

      it 'should call dealerWins when player busts', ->
        sinon.spy(game, "dealerWins")

        game.get 'playerHand' 
          .trigger 'bust'
        expect game.dealerWins.callCount
          .to
          .be
          .equal 1

      it 'should reset game after bust', ->
        game.get 'playerHand' 
          .trigger 'bust'
        deck = game.get 'deck'
        expect deck.length
          .to
          .be
          .equal 48
        expect (game.get "playerHand").length
          .to
          .be
          .equal 2
        expect (game.get "dealerHand").length
          .to
          .be
          .equal 2

      it 'should trigger a bust event if score is over 21', ->
        pHand = game.get 'playerHand'
        sinon.spy(pHand, "bust")

        pHandCount = pHand.bust.callCount
        card1 = new Card({rank:10, suit:0})
        card2 = new Card({rank:10, suit:1})
        pHand.add([card1, card2])
        pHand.hit()
        pHand.handleScore()
        expect pHand.bust.callCount
          .to
          .be
          .equal pHandCount+1
        return

    describe 'stand', ->
      it 'should call handleStand when either player stands', ->
        sinon.spy(game, "handleStand")
        handleStandCall = game.handleStand.callCount
        # trigger stand on playerHand
        game.get 'playerHand' 
          .trigger 'stand'
        expect game.handleStand.callCount
          .to
          .be
          .equal handleStandCall + 1 

        handleStandCall = game.handleStand.callCount
        # trigger stand on dealerHand
        game.get 'dealerHand'
          .trigger 'stand'
        expect game.handleStand.callCount 
          .to
          .be
          .equal handleStandCall + 1

      # handle playerStand
      it 'should call playDealerTurn when player stands', ->
        dealer = game.get 'dealerHand'
        sinon.spy(dealer, "playDealerTurn")

        game.get 'playerHand' 
          .trigger 'stand'
        expect dealer.playDealerTurn.callCount
          .to
          .be
          .equal 1

      it 'should call compareScores when dealer stands', ->
        sinon.spy(game, "compareScores")

        game.get 'dealerHand' 
          .trigger 'stand'
        expect game.compareScores.callCount
          .to
          .be
          .equal 1