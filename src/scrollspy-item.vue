// out: ..
<template lang="pug">
li
  a(
    :class="cClass",
    :style="cStyle",
    @click="scroll"
    )
    slot
</template>

<script lang="coffee">
module.exports =
  props:
    target: null

  computed:
    targetEl: ->
      if @ready and typeof @target == 'string' or @target instanceof String
        return document.getElementById(@target)
      return @target
    cClass: ->
      if @active and @targetEl
        return [@$parent.activeClass]
      return null
    cStyle: ->
      style = []
      if @targetEl
        style.push cursor:'pointer'
        if @active
          style.push @$parent.activeStyle
      return style

  data: ->
    isScrollspyItem: true
    active: false
    ready: false

  methods:
    scroll: (e) ->
      if e?
        return if e.defaultPrevented
        e.preventDefault()
      if @targetEl?
        @$parent.pause = true
        @$parent.transition @targetEl.getBoundingClientRect().top, =>
          @$parent.pause = false
          @$parent.activate(@)

    activate: ->
      @active = true
    deactivate: ->
      @active = false
  ready: -> @ready = true
</script>
