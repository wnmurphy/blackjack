class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: -> 
    rankName = @model.get 'rankName'
    suitName = @model.get 'suitName'
    fileName = 'img/cards/' + rankName + '-' + suitName + '.png'
    @$el.css 'background-image', 'url(' + fileName + ')'

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.css 'background-image', "url('img/card-back.png')" unless @model.get 'revealed'