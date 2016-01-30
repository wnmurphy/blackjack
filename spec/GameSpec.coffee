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



# obj
#  .func1 "aaa"
#  .func2 "bbb"

# obj.func1("aaa").func2("bbb");

###

it("should have a step function that makes its node blink", function() {
    sinon.spy(blinkyDancer.$node, 'toggle');
    blinkyDancer.step();
    expect(blinkyDancer.$node.toggle.called).to.be.true;
  });

  describe("dance", function(){
    it("should call step at least once per second", function(){
      sinon.spy(blinkyDancer, "step");
      expect(blinkyDancer.step.callCount).to.be.equal(0);
      clock.tick(timeBetweenSteps); // ? it seems an extra tick is necessary...
      clock.tick(timeBetweenSteps);

      expect(blinkyDancer.step.callCount).to.be.equal(1);

      clock.tick(timeBetweenSteps);
      expect(blinkyDancer.step.callCount).to.be.equal(2);
    });
  });###