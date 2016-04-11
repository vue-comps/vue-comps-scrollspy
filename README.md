# vue-comps-scrollspy

Tracks, which element is currently in the viewport

### [Demo](https://vue-comps.github.io/vue-comps-scrollspy)


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

| Name | type | default | description |
| ---:| --- | ---| --- |
| classes | String | ["table-of-contents"] | the css classes of the ul |

Scrollspy-item

| Name | type | default | description |
| ---:| --- | ---| --- |
| target | String | - | (required) id of the element which should be watched |

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
