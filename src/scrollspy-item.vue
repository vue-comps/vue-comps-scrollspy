// out: ..
<template lang="jade">
li
  a(
    v-bind:class="{active:active}"
    v-bind:style="{cursor:'pointer'}"
    @click="scrollTo | notPrevented | prevent"
    )
    slot
</template>

<script lang="coffee">
module.exports =

  filters:
    notPrevented: require("vue-filters/notPrevented")
    prevent: require("vue-filters/prevent")

  props:
    "target":
      type: String
      required: true

  watch:
    "target": "addTarget"

  data: ->
    active: false
    targetEl: null

  events:
    activate: (name) ->
      @active = name == @target
      true

  methods:
    addTarget: (newTarget=@target,oldTarget) ->
      @removeTarget(oldTarget) if oldTarget?
      @targetEl = document.getElementById(newTarget)
      if @targetEl?
        @$dispatch "addTarget", newTarget, @targetEl
    removeTarget: (target=@target) ->
      @$dispatch "removeTarget", target
    scrollTo: ->
      @$dispatch "activate",@target
      @targetEl?.scrollIntoView()

  attached: ->
    @addTarget()

  dettached: ->
    @removeTarget()
</script>
