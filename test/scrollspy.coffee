env = null

clickNWait = (el,cb) ->
  e = new MouseEvent("click",{
    "view": window,
    "bubbles": true,
    "cancelable": true
  })
  el.dispatchEvent(e)
  setTimeout cb, 200

scroll = (x,cb) ->
  window.scrollTo(0,x)
  setTimeout cb,200

shouldBeActive = (name) ->
  for key,val of env.$refs
    if key == name
      val.active.should.be.true
      val.$el.firstChild.should.have.class "active"
      val.$el.firstChild.should.have.attr("style").match /font-weight: bold/
    else
      val.active.should.be.false
      val.$el.firstChild.should.not.have.class "active"
      val.$el.firstChild.should.have.attr("style").not.match /font-weight: bold/
describe "scrollspy", ->

  describe "basic env", ->

    before (done) ->
      env = loadComp(require("../dev/basic.vue"))
      setTimeout done, 50
    after ->
      #unloadComp(env)

    it "should work on start", (done) ->
      shouldBeActive "first"
      done()

    it "should work on item click", (done) ->
      clickNWait env.$refs.second.$el.firstChild, ->
        shouldBeActive "second"
        env.$els.second.getBoundingClientRect().top.should.be.closeTo(0,1)
        done()

    it "should work on scroll down", (done) ->
      vh = env.getViewportSize().height
      top = env.$els.third.offsetTop
      scroll top-0.3*vh, ->
        shouldBeActive "third"
        done()

    it "should activate the last item at the bottom", (done) ->
      scroll 8000, ->
        shouldBeActive "fourth"
        done()

    it "should work on scroll up", (done) ->
      vh = env.getViewportSize().height
      top = env.$els.third.offsetTop
      scroll top-0.6*vh, ->
        shouldBeActive "third"
        done()
