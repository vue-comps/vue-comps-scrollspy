<template lang="jade">
.container.scrollspy
  a(href="https://github.com/vue-comps/vue-comps-scrollspy/blob/master/dev/basic.vue") source
  scrollspy
    scrollspy-item(target="first") first
    scrollspy-item(target="second") second
    scrollspy-item(target="third") third
    scrollspy-item(target="fourth") fourth
  #first.section
    h3 First
  #second.section
    h3 Second
  #third.section
    h3 Third
  #fourth.section
    h4 Fourth
</template>

<script lang="coffee">
module.exports =
  components:
    "scrollspy": require "../src/scrollspy.vue"
    "scrollspy-item": require "../src/scrollspy-item.vue"
</script>

<style lang="stylus">
.container.scrollspy > a
  position absolute
  left 250px
  top 40px
#first
  height 600px
#second
  height 100px
#third
  height 500px
#fourth
  height 150px
.table-of-contents
  position fixed
  right 20px
  top 20px
  list-style-type none
  .active
    font-weight: bold
</style>
