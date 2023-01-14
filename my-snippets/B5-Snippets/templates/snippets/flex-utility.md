<!-- 
Read the docs: \n https://deploy-preview-29017--twbs-bootstrap.netlify.app/docs/5.0/utilities/flex/


-->






<div class="d-${1|flex,inline-flex,sm-flex,sm-inline-flex,md-flex,md-inline-flex,lg-flex,lg-inline-flex,xl-flex,xl-inline-flex,xxl-flex,xxl-inline-flex|} ${2|row,row-reverse,column,column-reverse,sm-row,sm-row-reverse,sm-column,sm-column-reverse,md-row,md-row-reverse,md-column,md-column-reverse,lg-row,lg-row-reverse,lg-column,lg-column-reverse,xl-row,xl-row-reverse,xl-column,xl-column-reverse,xxl-row,xxl-row-reverse,xxl-column,xxl-column-reverse|} ">

${3| ,!direction,!justify,!align|}
<!-- ${|!spacing,!shadow,!color,!font,!flex,!direction,!justify,!align|} -->

</div>


This has x options:
1. behavior
2. direction
3. justify content
4. align-items,self,content
5. 


# Display 

d-sm--flex 

d${1|\b,-sm,-md,-lg,-xl,-xxl|}-${2|flex,inline-flex,none,block,inline,inline-block,table,table-cell,table-row|}

${3| ,!direction,!justify,!align|}


none
inline
inline-block
block
table
table-cell
table-row
flex
inline-flex


# Justify Content

`!justify`

.justify-content-start
.justify-content-end
.justify-content-center
.justify-content-between
.justify-content-around
.justify-content-evenly

Description: change the alignment of flex items on the main axis (the x-axis to start, y-axis if flex-direction: column)

Options: 

justify-content${2|\b-,-sm-,-md-,-lg-,-xl-,-xxl-|}${3|start,end,center,baseline,stretch,around,between,evenly|}

!flex-justify
justify-content-${|start,end,center,between,around,evenly,sm-start,sm-end,sm-center,sm-between,sm-around,sm-evenly,md-start,md-end,md-center,md-between,md-around,md-evenly,lg-start,lg-end,lg-center,lg-between,lg-around,lg-evenly,xl-start,xl-end,xl-center,xl-between,xl-around,xl-evenly,xxl-start,xxl-end,xxl-center,xxl-between,xxl-around,xxl-evenly|}

Options:
- start,
- end,
- center,
- between,
- around,
- evenly,
- sm-start,
- sm-end,
- sm-center,
- sm-between,
- sm-around,
- sm-evenly,
- md-start,
- md-end,
- md-center,
- md-between,
- md-around,
- md-evenly,
- lg-start,
- lg-end,
- lg-center,
- lg-between,
- lg-around,
- lg-evenly,
- xl-start,
- xl-end,
- xl-center,
- xl-between,
- xl-around,
- xl-evenly,
- xxl-start,
- xxl-end,
- xxl-center,
- xxl-between,
- xxl-around,
- xxl-evenly,


!flex-align-item
align-items-${1|start,end,center,baseline,stretch,sm-start,sm-end,sm-center,sm-baseline,sm-stretch,md-start,md-end,md-center,md-baseline,md-stretch,lg-start,lg-end,lg-center,lg-baseline,lg-stretch,xl-start,xl-end,xl-center,xl-baseline,xl-stretch,xxl-start,xxl-end,xxl-center,xxl-baseline,xxl-stretch|}

Options: 
- start,
- end,
- center,
- baseline,
- stretch,
- sm-start,
- sm-end,
- sm-center,
- sm-baseline,
- sm-stretch,
- md-start,
- md-end,
- md-center,
- md-baseline,
- md-stretch,
- lg-start,
- lg-end,
- lg-center,
- lg-baseline,
- lg-stretch,
- xl-start,
- xl-end,
- xl-center,
- xl-baseline,
- xl-stretch,
- xxl-start,
- xxl-end,
- xxl-center,
- xxl-baseline,
- xxl-stretch,


# !flex-align

`!flex-align`

align-self-sm-start














Descriptions: 1. align-content: aligns items together on the CROSS axis (horizontal) \n  2. align-content: change the alignment of flex items on the cross axis (the y-axis to start, x-axis if flex-direction: column) \n 3. align-self: change their alignment on the cross axis (the y-axis to start, x-axis if flex-direction: column)

Usage: align-${1|items,self,content|}-${2|\b,-sm,-sm,-md,-md,-lg,-lg,-xl,-xl,-xxl,-xxl|}-${3|start,end,center,baseline,stretch|}

align-self-${1|start,end,center,baseline,stretch,sm-start,sm-end,sm-center,sm-baseline,sm-stretch,md-start,md-end,md-center,md-baseline,md-stretch,lg-start,lg-end,lg-center,lg-baseline,lg-stretch,xl-start,xl-end,xl-center,xl-baseline,xl-stretch,xxl-start,xxl-end,xxl-center,xxl-baseline,xxl-stretch|}

Options:

- start,
- end,
- center,
- baseline,
- stretch,
  
- sm-start,
- sm-end,
- sm-center,
- sm-baseline,
- sm-stretch,
- md-start,
- md-end,
- md-center,
- md-baseline,
- md-stretch,
- lg-start,
- lg-end,
- lg-center,
- lg-baseline,
- lg-stretch,
- xl-start,
- xl-end,
- xl-center,
- xl-baseline,
- xl-stretch,
- xxl-start,
- xxl-end,
- xxl-center,
- xxl-baseline,
- xxl-stretch,


# Flex-fill
`!fill`
Description: use on sibling elements to force them into widths equal to their content

Usage: flex-${1|fill,sm-fill,md-fill,lg-fill,xl-fill,xxl-fill|}



Options: 
- fill
- sm-fill
- md-fill
- lg-fill
- xl-fill
- xxl-fill


# Grow and shrink

`!flex-grow-shrink`

Description: utilities to toggle a flex item’s ability to grow to fill available space

Usage: flex-${1|\b,-sm,-sm,-md,-md,-lg,-lg,-xl,-xl,-xxl,-xxl|}-${2|grow,shrink|}${3|0,1|}



Options: 


.flex${1|-,-sm,-md-,-lg-,-xl-,-xxl-|}{grow|shrink}-${3|0,1|}
.flex-{grow|shrink}-1
.flex-sm-{grow|shrink}-0
.flex-sm-{grow|shrink}-1
.flex-md-{grow|shrink}-0
.flex-lg-{grow|shrink}-0
.flex-xl-{grow|shrink}-0
.flex-xl-{grow|shrink}-1
.flex-xxl-{grow|shrink}-0
.flex-xxl-{grow|shrink}-1



# Wrap

`!flex-wrap`

Description: utilities to toggle a flex item’s ability to grow to fill available space.


flex-${2|\b,sm-,md-,lg-,xl-,xxl-|}${3| ,wrap,nowrap,wrap-reverse, |}

Options: 
.flex-nowrap
.flex-wrap
.flex-wrap-reverse
.flex-sm-nowrap
.flex-sm-wrap
.flex-sm-wrap-reverse
.flex-md-nowrap
.flex-md-wrap
.flex-md-wrap-reverse
.flex-lg-nowrap
.flex-lg-wrap
.flex-lg-wrap-reverse
.flex-xl-nowrap
.flex-xl-wrap
.flex-xl-wrap-reverse
.flex-xxl-nowrap
.flex-xxl-wrap
.flex-xxl-wrap-reverse




# Order

`!order`

Description: Change the visual order of specific flex items with a handful of order utilities.



order-${1|\b,sm-,md-,lg-,xl-,xxl-|}${2|1,2,3,4,5,first,last|}

order-first

Options: 

.order-first
.order-last
.order-sm-first
.order-sm-last
.order-md-first
.order-md-last
.order-lg-first
.order-lg-last
.order-xl-first
.order-xl-last
.order-xxl-first
.order-xxl-last


.order-0
.order-1
.order-2
.order-3
.order-4
.order-5
.order-sm-0
.order-sm-1
.order-sm-2
.order-sm-3
.order-sm-4
.order-sm-5
.order-md-0
.order-md-1
.order-md-2
.order-md-3
.order-md-4
.order-md-5
.order-lg-0
.order-lg-1
.order-lg-2
.order-lg-3
.order-lg-4
.order-lg-5
.order-xl-0
.order-xl-1
.order-xl-2
.order-xl-3
.order-xl-4
.order-xl-5
.order-xxl-0
.order-xxl-1
.order-xxl-2
.order-xxl-3
.order-xxl-4
.order-xxl-5



# border

`!border`


Description:

Options: 

rounded rounded-sm


# Round

`!round`

Description:

Options: 

rounded rounded-sm


# align-content

`!flex-align-content`

Description:  align flex items together on the cross axis. Choose from start (browser default), end, center, between, around, or stretch

align-content-${1|\b,sm-,md-,lg-,xl-,xxl-|}${2|start,end,center,around,stretch|}



Options: 

.align-content-start
.align-content-end
.align-content-center
.align-content-around
.align-content-stretch
.align-content-sm-start
.align-content-sm-end
.align-content-sm-center
.align-content-sm-around
.align-content-sm-stretch
.align-content-md-start
.align-content-md-end
.align-content-md-center
.align-content-md-around
.align-content-md-stretch
.align-content-lg-start
.align-content-lg-end
.align-content-lg-center
.align-content-lg-around
.align-content-lg-stretch
.align-content-xl-start
.align-content-xl-end
.align-content-xl-center
.align-content-xl-around
.align-content-xl-stretch
.align-content-xxl-start
.align-content-xxl-end
.align-content-xxl-center
.align-content-xxl-around
.align-content-xxl-stretch

# Flex Utility

`!flex`

Usage: 
    d-${1|\b-,-sm-,-md-,-lg-,-xl-,-xxl-|}${2|flex,inline-flex|}

Description: 
    Create a flexbox container and transform direct children elements into flex items. \n\n Ends with an option to continue tabing out the direction utilities.

Options: 

.d-flex
.d-inline-flex
.d-sm-flex
.d-sm-inline-flex
.d-md-flex
.d-md-inline-flex
.d-lg-flex
.d-lg-inline-flex
.d-xl-flex
.d-xl-inline-flex
.d-xxl-flex
.d-xxl-inline-flex




# Direction

`!direction`

Usage:
flex${1|\b-,-sm-,-md-,-lg-,-xl-,-xxl-|}${2|row-,row-reverse,column,column-reverse|}

.flex-row
.flex-row-reverse
.flex-column
.flex-column-reverse
.flex-sm-row
.flex-sm-row-reverse
.flex-sm-column
.flex-sm-column-reverse
.flex-md-row
.flex-md-row-reverse
.flex-md-column
.flex-md-column-reverse
.flex-lg-row
.flex-lg-row-reverse
.flex-lg-column
.flex-lg-column-reverse
.flex-xl-row
.flex-xl-row-reverse
.flex-xl-column
.flex-xl-column-reverse
.flex-xxl-row
.flex-xxl-row-reverse
.flex-xxl-column
.flex-xxl-column-reverse


Description:

Options: 

