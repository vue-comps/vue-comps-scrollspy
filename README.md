# vue-comps-scrollspy

Tracks, which element is currently in the viewport

### [Demo](https://vue-comps.github.io/vue-comps-scrollspy)

On scrolling down, the target with the most area filling the space in the range [0.3-0.4] \* viewportHeight is set active.  
On scrolling up, the range [0.6-0.7] \* viewportHeight is taken.


# Install

```sh
npm install --save-dev vue-comps-scrollspy
```
or include `build/bundle.js`.

## Usage
```coffee
# in your component
components:
  "scrollspy": require("vue-comps-scrollspy")
  "scrollspy-item": require("vue-comps-scrollspy/scrollspy-item")
# or, when using bundle.js
components:
  "scrollspy": window.vueComps.scrollspy
  "scrollspy-item": window.vueComps.scrollspyItem
```
```html
<scrollspy>
  <scrollspy-item target="someID">someDescription</scrollspy-item>
</scrollspy>
```

For examples see [`dev/`](dev/).

#### Props
Scrollspy

Name | type | default | description
---:| --- | ---| ---
transition | Function | see [transtion](#transition) | function which gets used for scrolling item into view
activeClass | String | `active` | class will be applied to active item
activeStyle | String / Object | "" | style will be applied to active item

Scrollspy-item

Name | type | default | description
---:| --- | ---| ---
target | String or Element | - | string will be converted by `document.getElementById`

#### Transition

This is the default transition:
```js
function (scrollBy, done) {
  window.scrollBy(0,scrollBy)

}
```

Always make sure you apply a little timeout before calling `done`

Example of `vue-materialize` for a transition with velocity:

```js
Velocity = require("velocity-animate")
function (scrollBy, done) {
  var body = document.body
  var docEl = document.documentElement
  var scrollTop = window.pageYOffset || docEl.scrollTop || body.scrollTop
  scrollTop += scrollBy
  var duration = Math.abs(scrollBy)/3
  if (duration < 100) {
    duration = 100
  } else if (duration > 500) {
    duration = 500
  }
  Velocity(docEl, "scroll", {
    duration: duration,
    offset: scrollTop,
    complete: function() {setTimeout(done, 66)}
  })
}
```

## Changelog
- 1.0.0  
some cleaning  
added unit tests  
added `transition`, `activeClass`, `activeStyle` props  
added ability to directly give a element as target  

# Development
Clone repository.
```sh
npm install
npm run dev
```
Browse to `http://localhost:8080/`.

## License
Copyright (c) 2016 Paul Pflugradt
Licensed under the MIT license.
