// out: ..
<template lang="jade">
ul(
  v-bind:style="style"
  v-bind:class="classes"
  )
  slot
</template>

<script lang="coffee">
module.exports =

  props:
    classes:
      type: Array
      default: -> ["table-of-contents"]

  mixins:[
    require("vue-mixins/onWindowScroll")
    require("vue-mixins/getViewportSize")
    require("vue-mixins/onWindowResize")
    require("vue-mixins/getDocumentHeight")
  ]


  data: ->
    height: @getViewportSize().height
    targets: []
    names: []
    lastScrollTop: 0
    scrollTop: 0
    activated: false

  events:
    "addTarget": (targetName,targetEl) ->
      @targets.push targetEl
      @names.push targetName
      true
    "removeTarget": (targetName) ->
      index = @names.indexOf(targetName)
      @targets.splice index,1
      @names.splice index,1
      true
    "activate": (targetName) ->
      @activated = true
      @$broadcast "activate", targetName
      true

  methods:
    processScroll: (e) ->
      if @activated
        @activated = false
      else
        @lastScrollTop = @scrollTop
        @scrollTop = window.pageYOffset or document.documentElement.scrollTop
        if @scrollTop + @height - @getDocumentHeight() > -40
          name = @names[@names.length-1]
        else
          coverage = []
          indices = []
          for el,i in @targets
            rect = el.getBoundingClientRect()
            if @lastScrollTop <= @scrollTop
              top = Math.max(0+@height*15/50,rect.top)
              bottom = Math.min(@height*20/50,rect.bottom)
            else
              top = Math.max(0+@height*30/50,rect.top)
              bottom = Math.min(@height*35/50,rect.bottom)
            area = bottom - top
            if area >= 0
              indices.push i
              coverage.push area
          max = coverage.reduce(((iMax,x,i,a) -> if x>a[iMax] then i else iMax), 0)
          name = @names[indices[max]]
        @$broadcast "activate", name

  compiled: ->
    @onWindowScroll @processScroll
    @onWindowResize =>
      @height = @getViewportSize().height
  ready: ->
    @processScroll()

</script>
