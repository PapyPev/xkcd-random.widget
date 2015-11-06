
# Appearance
width        = '367px'
barHeight    = '36px'
labelColor   = '#fff'
usedColor    = '#d7051d'
freeColor    = '#525252'
bgColor      = '#fff'
borderRadius = '3px'
bgOpacity    = 0.9

command: "last=$(curl --silent http://xkcd.com/info.0.json | sed -e 's/[{}]/''/g' | awk -v k=\"text\" '{n=split($0,a,\",\"); for (i=1; i<=n; i++) print a[i]}' | grep '\"num\":' | sed 's/:/ /1' | awk -F \" \" '{ print $2 }') && newid=$((RANDOM%$last+1)) && curl --silent http://xkcd.com/$newid/info.0.json"

# Set the refresh frequency (milliseconds) to every 10 min
refreshFrequency: 600000

style: """

  // Align contents left or right
  widget-align = left
  
  // Position where you want
  top: 280px
  left: 400px
  
  // Statics text settings
  color: #fff
  font-family Helvetica Neue
  background rgba(#000, .5)
  padding 10px 10px 15px
  border-radius 5px
  
  // Style
  .container
    width: 500px
    text-align: widget-align
    position: relative
    clear: both

  .container:not(:first-child)
    margin-top: 20px

  .widget-title
    text-align: widget-align

  .stats-container
    margin-bottom 5px
    border-collapse collapse

  td
    font-size: 14px
    font-weight: 300
    color: rgba(#fff, .9)
    text-shadow: 0 1px 0px rgba(#000, .7)
    text-align: widget-align

  td.pctg
    float: right
	
  img
    width: 330px

  p
    font-size 11px
    width: 300px

  .widget-title
    font-size 10px
    text-transform uppercase
    font-weight bold

  .label
    font-size 8px
    text-transform uppercase
    font-weight bold


"""

# Render the output.
render: (output) -> """
  <div id='container'>
  <div>
"""

update: (output, domEl) -> 
  xkcd = JSON.parse(output)
  container = $(domEl).find('#container')
  content = 
    """
	<div class="widget-title">#{xkcd.title}</div>
	<p>#{xkcd.alt}</p>
    <img src="#{xkcd.img}"/>
    """
  $(container).html content
