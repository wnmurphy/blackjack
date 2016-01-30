class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'
  scoresTemplate: '<div class="chips"></div><div class="bet"></div> <div class="placeBet"><input type="number" min="1" placeholder="Place bet."></div>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @collection.on 'lock', =>
      $("input").prop('disabled', true);
      @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    
    @$el.append @scoresTemplate if not @collection.isDealer
    
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]
    @$('.chips').text "Chips: " + @collection.chips
    @$('.bet').text "Bet: " + @collection.bet
    @$('input').val @collection.bet
    @$('input').attr 'max', @collection.chips