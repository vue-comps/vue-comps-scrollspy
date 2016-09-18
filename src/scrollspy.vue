// out: ..
<template lang="pug">
ul(
  v-bind:class="computedClass"
  )
  slot
</template>

<script lang="coffee">
trim = (str) -> return str.replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, '')
module.exports =

  mixins:[
    require("vue-mixins/onWindowScroll")
    require("vue-mixins/getViewportSize")
    require("vue-mixins/onWindowResize")
    require("vue-mixins/getDocumentHeight")
    require("vue-mixins/class")
  ]

  props:
    class:
      default: -> ["table-of-contents"]
    transition:
      type: Function
      default: (scrollBy, done) ->
        window?.scrollBy?(0,scrollBy)
        setTimeout done, 66
    activeClass:
      default: "active"
      type: String
    activeStyle:
      default: ""
      coerce: (val) ->
        if typeof val == 'string' or val instanceof String
          obj = {}
          for opt in val.split(";")
            kv = opt.split(":")
            if kv.length == 2
              obj[trim(kv[0])] = trim(kv[1])
          return obj
        return obj

  methods:
    processHeight: ->
      @vpHeight = @getViewportSize().height
      @processScroll()
    activate: (target) ->
      if target != @lastTarget
        @lastTarget = target
        for child in @$children
          if child.isScrollspyItem and child.targetEl?
            if child == target
              child.activate()
            else
              child.deactivate()
    processScroll: (e) ->
      unless @pause
        @lastScrollTop = @scrollTop
        body = document.body
        docEl = document.documentElement
        @scrollTop = window.pageYOffset || docEl.scrollTop || body.scrollTop
        if @scrollTop + @vpHeight - @getDocumentHeight() > -40
          for i in [@$children.length-1..0]
            child = @$children[i]
            if child.isScrollspyItem and child.targetEl?
              @activate(child)
              break
        else
          coverage = []
          indices = []
          for child,i in @$children
            if child.isScrollspyItem and child.targetEl?
              rect = child.targetEl.getBoundingClientRect()
              if @lastScrollTop == -1
                top = Math.max(0,rect.top)
                bottom = Math.min(@vpHeight*0.1,rect.bottom)
              else if @lastScrollTop <= @scrollTop
                top = Math.max(0+@vpHeight*0.3,rect.top)
                bottom = Math.min(@vpHeight*0.4,rect.bottom)
              else
                top = Math.max(0+@vpHeight*0.6,rect.top)
                bottom = Math.min(@vpHeight*0.7,rect.bottom)
              area = bottom - top
              if area >= 0
                indices.push i
                coverage.push area
            max = coverage.reduce(((iMax,x,i,a) -> if x>a[iMax] then i else iMax), 0)
            @activate(@$children[indices[max]])
  ready: ->
    @onWindowScroll @processScroll
    @onWindowResize @processHeight
    @scrollTop = -1
    @lastTarget = -1
    @processHeight()

</script>
