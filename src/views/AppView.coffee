class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @render()
    game = @model.get 'game'
    game.on 'reset', =>
      @render()
      # get Game's new playerHand
      # update HandView's playerHand to new one
      # get Game's new dealerHand
      # update HandView's dealerHand to new one

  render: ->
    @$el.children().detach()
    @$el.html @template()
    game = @model.get 'game' 
    @$('.player-hand-container').html new HandView(collection: game.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: game.get 'dealerHand').el