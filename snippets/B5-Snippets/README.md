# Bootstrap 5 
[![Version](https://vsmarketplacebadge.apphb.com/version/HansUXdev.bootstrap5-snippets.svg)](https://marketplace.visualstudio.com/items?itemName=HansUXdev.bootstrap5-snippets)
[![Installs](https://vsmarketplacebadge.apphb.com/installs/HansUXdev.bootstrap5-snippets.svg)](https://marketplace.visualstudio.com/items?itemName=HansUXdev.bootstrap5-snippets)
[![Ratings](https://vsmarketplacebadge.apphb.com/rating/HansUXdev.bootstrap5-snippets.svg)](https://marketplace.visualstudio.com/items?itemName=HansUXdev.bootstrap5-snippets)

[![The MIT License](https://img.shields.io/badge/license-MIT-orange.svg?style=flat-square)](http://opensource.org/licenses/MIT) [![GitHub](https://img.shields.io/github/stars/HansUXdev/B5-Snippets.svg?style=flat-square)](https://github.com/HansUXdev/B5-Snippets) [![GitHub](https://img.shields.io/github/followers/HansUXdev.svg?style=flat-square)](https://github.com/HansUXdev)



<!-- [![GitHub](https://img.shields.io/github/release/HansUXdev/B5-Snippets.svg?style=flat-square)](https://github.com/HansUXdev/B5-Snippets/releases) -->

The first, (currently only) and hands down BEST bootstrap 5 snippet extension. Includes templates, powerful utility snippets, and much more.

## Features
1. Templates one tab away
2. Powerful utilities
3. Font Awesome icons ! (currently 4.7, eventually 6.0)
4. Much more hidden...
<!-- 5. hidden snippets to convert ya'll to javascript fans, such as !http -->
6. Much more planned, so consider giving it a star on [github](https://github.com/HansUXdev/B5-Snippets) or the [marketplace](https://marketplace.visualstudio.com/items?itemName=HansUXdev.bootstrap5-snippets), become a [sponsor](https://github.com/sponsors/HansUXdev/).

![](Templates2.gif)


# Open Source Marketplace
This may surprizes you but VS-Code and it's marketplace aren't really open source, is licensed under a not-FLOSS license and contains telemetry/tracking, [read more...](https://vscodium.com/)

This extension is built for [open-vsx](https://open-vsx.org/) and published on the ONLY [open source registry](https://open-vsx.org/about) for VS Code extensions.

<!-- 
If you are reading this, it's because I opened sourced it. Hopefully you love open source as much as me...

Don't share this code comment with anyone. It'll be our little inside joke.

Wanna conduct an expirment together?
1. Give this extension 5 stars. Write an awesome review.
2. Share it and promote it on social media, twitter, facebook, linkedin, etc... 
3. Lets see if we can get ~20-100k downloads.
4. Just as people are getting hooked, I'll uncomment the text below. 
    Then remove the extension from the stor at a random time to raise awareness about open source.
    If you are a publisher of an extension, or snippet, you do the same thing.
-->

<!-- **Eventually, this extension may be removed from [visual studio marketplace](https://marketplace.visualstudio.com/) in order raise awareness**.  -->

Learn more about **open source** versions of vscode such as [vscodium](https://vscodium.com/), [GitPod's IDE](https://www.gitpod.io/docs/ide/) and more.
<!-- 
## Installing
The simplest way is to install command line.
`code --install-extension myextension.vsix` -->

## Notes
Bootstrap 5 is currently in alpha and this extension should be considered in the same status.
Unlike a lot of other snippets, this extension aims to balence user simplicity, with power and flexibility by keeping the **total number of snippets to a minimum**. 

In terms of **user simplicity**, other Bootstrap 4 snippets have 5 different snippets for the grid, whereas this will have 3, but each is more powerful.

## Roadmap
* v1.2.5 - Introduces Flex utilities, media-query and awesome awesome 4.7.0.
* v1.6-8 - Each snippet with eventually have a gif demo (SOON).
* v2 - All base [templates](https://v5.getbootstrap.com/docs/5.0/examples/) and several others will be one tab away, so consider  [sponsoring this](https://github.com/sponsors/HansUXdev/) or giving it a star.

---

## Powerful, Simple, **Flex** Snippets
> **Center, position or reorder any element, by any default breakpoint with under 10 snippets.**


Trigger | Description
--- | ---
`!templates` | Sets the display type.
`!utilities` | Sets the display type.
`b5-` | Main component snippets.
`fa-` | Font Awesome component snippets.

---

## Templates/Layout
Templates are just one tab away. Most of the [official example templates](https://v5.getbootstrap.com/docs/5.0/examples/) have been implmented.

Trigger | Description
--- | ---
!b5-$ | Shortcut creating an html document with cdn scripts included
!b5-$Offcanvas | Offcanvas Template, one tab away.
!b5$Template-name | More coming soon... 

---

## Powerful Utility Classes
There are two way to use utilities.
1. **Class utilities**, which use `!` as a prefix. For example, if you want to add a utility class to an existing HTML element, inside of `class=" "` you would add `class="!spacing"` then hit tab and fill out the options, the default will be `class="mx-auto"` which sets margin to auto on left and right (x).
2. **Wrapper elements**, ex: `b5-{txt,color,shadow,boder,spacing}` which will create a div, p, h2 then allow you to tab through the options. 

Trigger | Description
--- | ---
`!spacing` or `b5-spacing` | A single, powerful utility snippet. The default is `mx-auto` which adds margins on right and left. The options allow you to switch between (m)argin and (p)adding, x,y,(t)op,(r)ight, (b)ottom, (l)eft, etc. Read about the classes on the [official bootstrap documentation](https://v5.getbootstrap.com/docs/5.0/utilities/spacing/).
`!shadow` or `b5-shadow` | Useful whenever you want to make things look like paper or material design. Read about the classes on the [official bootstrap documentation](https://v5.getbootstrap.com/docs/5.0/utilities/spacing/). https://v5.getbootstrap.com/docs/5.0/utilities/shadows/
`!font` or `b5-text` | This intentionally uses two different names to differentiate between the class utility and the wrapper element. The options are responsive positions `{|sm,md,lg,xl|}-${|left,center,right|}`, line-height `base,1,sm,lg}`, font-weight `normal,italic,weight-normal,weight-bold,weight-bolder,weight-light,weight-lighter` ,and `text-${6|none,lowercase,uppercase,capitalize|}`, decoration and `reset,break,monospace` !
`b5-border` | change border attributes all border attributes. Read about the classes on the [official bootstrap documentation](https://v5.getbootstrap.com/docs/5.0/utilities/borders/).


---

## Powerful, Simple, **Flex** Snippets
> **Center, position or reorder any element, by any default breakpoint with under 10 snippets.**


Trigger | Description
--- | ---
`!!MQ` | Sets the display type.
`!flex` | Sets the display type.
`!justify` | Sets the display type.
`!align` | Sets the display type.
`!fill` | Sets the display type.
`!grow-shrink` | Sets the display type.
`!flex-wrap` | Sets the display type.
`!flex-order` | Sets the display type.

---

#### Grid
This is works great but it may be simplified and rewritten. 
I'm also toying around with new utility snippet to that combines the [display classes](https://v5.getbootstrap.com/docs/5.0/utilities/display/) and [flex classes](https://v5.getbootstrap.com/docs/5.0/utilities/flex/). If you have any thoughts or suggestions, let me know on github.

Trigger | Description
--- | ---
b5-**container** | Grid container with options for -fluid, px, gy and more.
b5-**row** | Powerful row, `${1| ,row-cols-2,row-cols-3, auto,justify-content-md-center,md,lg,xl,xxl|}`. Default to row with optional utility classes. 
b5-**col** | Pretty much all your need covered and more. Ex: `col${1| ,-1,-2,-3,-4,-5,-6,-sm,-md,-lg,-xl,-xxl|}${2| ,-auto,-1,-2,-3,-4,-5,-6,-7,-8,-9,-10,-11,-12`

#### Navbar

Trigger | Description
--- | ---
b5-**navbar-default** | Navbar default
b5-**navbar-scollspy** | V1 is here
b5-**Nav-bottom** | V1 is here

b5-**nav-item** | item with link and options for common pages such as Home, About, Blog, Contact.
b5-**navlink** | link
b5-**nav-dropdown** | dropdown
b5-**nav-dropdown toggle** | Navbar toggle
b5-**nav-** | more in this category coming soon...

#### Button

Trigger | Description
--- | ---
b5-**btn** | Button with link
b5-**btn-o** | Button with outline
b5-**btn-close** | Close buttons...
b5-**btn-** | more in this category coming soon...



#### Cards

Trigger | Description
--- | ---
b5-**card** | Basic Card
b5-**card-** | more in this category coming soon...


#### modal

Trigger | Description
--- | ---
b5-**modal** | Basic modal
b5-**modal-** | more in this category coming soon...

#### Collapse

Trigger | Description
--- | ---
b5-**btn-reveal** | Click a button and reveal some content.
b5-**modal-** | more in this category coming soon...


#### JavaScript
I plan on eventually adding bootstrap snippet for the JavaScript but its not on the roadmap yet because I'm also working on this [massive javascript extension](https://marketplace.visualstudio.com/items?itemName=HansUXdev.javascript-first-snippets) which will replace about 5-10 of the most popular extensions add and add things like optional chaining among other methods.

Trigger | Description
--- | ---
`jb5` | consider submitting a PR or becoming a [sponsor](https://github.com/sponsors/HansUXdev/).

<!-- #### Bgroup
Trigger | Description
--- | ---
b5-**bgroup-default** | Bgroup default
b5-**bgroup-dropdown-vertical** | Bgroup dropdown vertical
b5-**bgroup-dropdown** | Bgroup dropdown
b5-**bgroup-size** | Bgroup size
b5-**bgroup-toolbar** | Bgroup toolbar -->

<!-- #### Dropdown

Trigger | Description
--- | ---
b5-**dropdown-alignment** | Dropdown alignment
b5-**dropdown-anchor** | Dropdown anchor
b5-**dropdown-button** | Dropdown button
b5-**dropdown-colored** | Dropdown colored
b5-**dropdown-default** | Dropdown default
b5-**dropdown-sized** | Dropdown sized
b5-**dropdown-split** | Dropdown split
b5-**dropdown-up-split** | Dropdown up split
b5-**dropdown-up** | Dropdown up -->



<!-- ## Known Issues
No serious issue known at the moment. -->

## Release Notes

Users appreciate release notes as you update your extension.

### 1.2.3 - Updated documentation, added templates and much more.

### 1.2.5 - Fixed Bugs
- [x] Flex Utilities ! 
- [x] added !round utility
- [x] Added CTA Button - with options for call and email
- [x] breadcrumb - fixed bug and added breadcrumb item
- [x] border- fixed bug and added !round option
- [ ] 


## Supporting the Developers 
If you use this a lot or want to see it improve consider giving it a star, following the dev on social media below, or becoming a [githup sponsor](https://github.com/sponsors/HansUXdev/). 


<a href="https://medium.com/@hansOnConsult" class="MEDIUM">
   <img src="https://img.shields.io/badge/medium-%2312100E.svg?&style=for-the-badge&logo=medium&logoColor=white" />
</a>
<a href="https://dev.to/hansuxdev" class="DEV TO">
   <img src="https://img.shields.io/badge/DEV.TO-%230A0A0A.svg?&style=for-the-badge&logo=dev-dot-to&logoColor=white" />
</a>
<a href="https://www.youtube.com/channel/UCCGfELkPCJg1XHxQfFFz7pw/about" class="YOUTUBE">
   <img src="https://img.shields.io/badge/youtube-%23FF0000.svg?&style=for-the-badge&logo=youtube&logoColor=white" />
</a>
<a href="https://www.twitch.tv/hansoncoding" class="Twitch">
   <img src="https://img.shields.io/twitch/status/hansoncoding?style=for-the-badge" />
</a>



### Educational Repos
The author does **a lot more** than just publishing a json file for snippets.

Here are just a few things he's working on, while taking care of his 👶 as a full-time single father, job hunting & competing in hackathons...

Trigger | Description & Info
--- | ---
[JavaScript-First](https://github.com/HansUXdev/JavaScript-First) | An Open Source Book that teaches anyone how to code with JavaScript using the node.js runtime environment rather than a browser and by the end, you will build a server and a website using JavaScript..
[Learn Mongo GitPod](https://github.com/HansUXdev/LearnMongoGitPod)| A repo designed to teach mongoDB to people with zero experiance and zero config, meaning you can learn on virtually any device that has a browser that GitPod can run on! This 🤞may🤞 become part of Free Code Camp [[1](https://forum.freecodecamp.org/t/how-is-new-content-created-at-fcc/416191/3)], [[2](https://github.com/freeCodeCamp/CurriculumExpansion/issues/103)].


### Future Snippets & Extensions
Name | Description
--- | ---
[JavaScript-First](https://marketplace.visualstudio.com/items?itemName=HansUXdev.javascript-first-snippets)  | JavaScript First is a huge collection of snippets built to establish better code habits for working with JS-based servers, browser methods, react, mongo databases and more. It is also meant to be paired with the book, [JavaScript-First](https://github.com/HansUXdev/JavaScript-First).
Foundation 6 Snippets| This will start as a snippets for [sites](https://get.foundation/sites/docs/) and then be updated for.
Code Slides | A snippet extension for creating educational slides with [vscode-reveal](https://marketplace.visualstudio.com/items?itemName=evilz.vscode-reveal) and a custom theme. (not public yet)
Foundation 6 Snippets| This will start as a snippets for [sites](https://get.foundation/sites/docs/) and then be updated for.[email](https://get.foundation/emails). If sponsored, I will extend this to eventually replace the [CLI](https://github.com/foundation/foundation-cli) and [building blocks](https://get.foundation/building-blocks/) by implementing a custom feature that writes install kits in a similar way the [web boilerplate](https://marketplace.visualstudio.com/items?itemName=jamesqquick.web-boilerplate) writes an html, css, and js file.  (not started yet)

### Social Entrepreneurship: Open Source Non-Profit
I'm in the process of founding a non-profit dedicated to promoting open source by doing the following and can only commit to the first two without proper sponsorship:
Name | Description
--- | ---
Creating open source curriculum | Getting open source curriculum into the hands for high school students.
CTE Coding Students | Bringing industry professionals into the class room to inspire them (via zoom). I already did this as a teacher by bringing people from Riot Games / Carvana, Choice Hotels, Auth0, and many others into my classroom. Now I want to streamline this for more schools.
Free Coding Classes on Twitch | I stream open source classes for an introductory javaScript class every week to test the open source curriculum I write. Think of it as a free bootcamp online. I also despritely need a better computer that doesn't require iced gel packs to be able to stream 😅.... 
Lobbying for Open Source Certification | When I taught in a public CTE high school, I couldn't believe that a multiple choice test like th MTA certifications were approved by the state over open source certifications such as Free Code Camp's. I know enough school board members and a few house members to help get the ball rolling but, it's a lot of leg work and I don't want to commit to this without funding...
Laptop | Donating 4G latops/tablets to students struggling with remote academic life. Having taught a few students with bad internet, etc, this is especially important to me but I don't have the resources to address this without funding.
