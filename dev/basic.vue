<template lang="pug">
.container
  br
  a(href="https://github.com/vue-comps/vue-comps-scrollspy/blob/master/dev/basic.vue") source
  scrollspy(style="position:fixed;right:20px;top:20px;list-style-type:none",active-style="font-weight:bold")
    scrollspy-item(target="first", v-ref:first) first
    scrollspy-item(target="second", v-ref:second) second
    scrollspy-item(target="third", v-ref:third) third
    scrollspy-item(target="fourth", v-ref:fourth) fourth
  #first.section(style="height:1200px", v-el:first)
    h3 First
  #second.section(style="height:100px", v-el:second)
    h3 Second
  #third.section(style="height:1200px", v-el:third)
    h3 Third
  #fourth.section(style="height:150px", v-el:fourth)
    h4 Fourth
</template>

<script lang="coffee">
module.exports =
  mixins: [
    require("vue-mixins/getViewportSize")
  ]
  components:
    "scrollspy": require "../src/scrollspy.vue"
    "scrollspy-item": require "../src/scrollspy-item.vue"
</script>
