### EXPLORATOTY DATA ANALYSIS

### Lesson 1: Principles of Analytic Graphs
# Book: "Beautiful Evidence" - Edward Tufte
# www.edwardtufte.com

#analytic graphing principles:
#1 + show comparisons
#2 + show causality, mechanism, explanation
#3 + show multivariate data = >2 variables
#4 + integrating evidence
#5 + describing + documenting the evidence with sources + appropriate labels + scales
#6 + Content is king!

#Simpson's paradox / the Yule-Simpson effect:
# a trend that appears in different groups of data disappears when these groups are combined


### Lesson 2: Exploratory Graphs
#usage:
# + understand data properties
# + find patterns in data
# + suggest modeling strategies
# + help debug analyses
# + DON'T use to communicate results


## 1-dimensional graph:
# summary()
# boxplot()
# hist()
# barplot()

summary()
quantile()
boxplot()

abline() #adds one or more straight lines through the current plot
abline(v = median(ppm),col = "magenta", lwd = 4)

hist(data, col = "green",break = 100)
rug()

reg <- table(pollution$region)
> reg
east west 
 442  134
 
barplot(reg, col = "wheat", main = "Number of Counties in Each Region")

## 2-dimensional graph
# scatterplot
# multiple graphs

## >2-dimensional graph
# overlayed/multiple 2-dimensional plot
# spinning plots

boxplot(pm25~region,pollution, col = "red")

par(mfrow=c(2,1), mar=c(4,4,2,1)) #plot window 2 rows, 1 col + margin = 4,4,2,1 - bottom,left,top,right
hist(subset(pollution, region=="west")$pm25,col = "green")

with()
with(pollution, plot(latitude, pm25))
plot(pollution$latitude,ppm,col=pollution$region)

### Lesson 3: Graphic devices in R
?Devices
dev.cur() #show current plotting devices

pdf(file="myplot.pdf")  #create the pdf file 'myplot.pdf' in working directory
dev.off() # [IMPORTATN] close the device
dev.set('integer') #every open graphics device -> assigned an integer >= 2
# dev.set() change active graphic device 
dev.copy()      #copy a plot from one device to another
dev.copy2pdf()  #copy a plot to a PDF file


## file device - 2 basic file:
# vector: line drawing + plots with solid colors using a modest number of point
# bitmap: plots with a large number of points / natural scenes / web-based plots

## vector format (4):
# pdf: + line-type graphic + paper
#      + resize well
#      + portable
#      + NOT efficient if plot has many objects/points
# svg: + XML-based scalable vector graphic
#      + support animation + interactivity
#      + web-based plots
# win.metafile
# postscript

## bitmap format (4):
# png: + Portable Network Graphics
#      + [good]line drawings/ images with solid colors
#      + lossless compression
#      + [good] plot with many points
#      + NOT resize well
#jpeg: + lossy compression -> [good]plot with many points
#      + [good]photograph + natural scenes
#      + NOT resize well
#      + [not good] line drawing
# tiff
# bmp

with(faithful,plot(eruptions,waiting))
title(main = "Old Faithful Geyser data")
dev.copy(png,file = "geyserplot.png")
dev.off()



### Lesson 4: Plotting systems
## Base plotting system
# 'Artist's palette' model = start with a blank canvas -> buitl the plot up step by step
# [disadvantage] CANT go back once a plot has started

with(cars, plot(speed, dist))
text(mean(cars$speed), max(cars$dist),"SWIRL rules!")

## Lattice system
# create plot with single function call
# margin + spacing are set automatically
# [useful]: + conditioning plot = display how y changes with x across levels of z (z~categorial variable of data)
#            -> examine same kind of plot under many different conditions
#           + put many plots on a screen at once
# [disadvantage]: + difficult to specify entire plot in a single function call
#                 + ____________ use panel functions + subscripts
#                 + CANT "add" anything to created plot

xyplot(Life.Exp~Income | region, data = state, layout = c(4,1))

## ggplot2 (gg= 'grammar of graphics' = user can control aesthetic of plot)
# = 'Lattice' + 'Base'
# = automatically deal with spacing, text, titles + adding to a created plot

qplot(displ,hwy,data = mpg)


### Lesson 5: Base plotting system
# = 'base' + 'grDevice' = function (plot, hist, etc) + (pdf, png, etc)

range(airquality$Ozone,na.rm = TRUE)

boxplot(Ozone~Month, data= airquality,xlab = "Month", ylab = "Ozone (ppb)", col.axis = "blue", col.lab = "red")

par()$pin  # current plot dimensions, (width, height), in inches
par("pin") 
par('pin')

colors()

dev.off()  #reset to the defaults
plot.new() #_____________________

# las: orientation of the axis labels on the plot
# bg : background color
# mar: margin size
# oma: outer margin size
# mfrow - mfcol: number of plots per row - column
#mfrow -> fill the rows first 
#mfcol -> fills the columns first

text()    #adds text labels to a plot using specified x, y coordinates
title()   #include x- + y- axis labels / title / subtitle / outer margin
points()
lines() 
mtext()   #adds arbitrary text to outer / inner margins of the plot
axis()    #adds axis ticks + labels
legend()  

#-----Eg.-------
plot(airquality$Wind,airquality$Ozone,type = "n")  #set up the plot but not put data in it
title(main="Wind and Ozone in NYC" )
may <- subset(airquality,Month ==5)
points(may$Wind,may$Ozone,col="blue",pch=17)       #solid blue triangle
notmay <- subset(airquality,Month !=5)
points(notmay$Wind,notmay$Ozone,col="red",pch=8)   #red snowflakes
legend("topright",pch=c(17,8),col=c("blue","red"),legend=c("May","Other Months"))
abline(v = median(airquality$Wind),lty = 2, lwd = 2)

par(mfrow = c(1, 3), mar = c(4, 4, 2, 1),oma = c(0, 0, 2, 0))
mtext("Ozone and Weather in New York City",outer = TRUE)


### Lesson 6: Lattice plotting system
# lattice system = 'lattice' + 'grid'
## 'lattice' function
xyplot()     #scatterplot
bwplot()     #box-and-whisker plot = boxplot
histogram()  
stripplot()  #boxplot with actual points
dotplot()    #plot dots on 'violin strings'
splom()      #scatterplot matrix = pairs() ('base' system)
levelplot() / contourplot()  #plotting 'image' data


xyplot(y~x | f * g, data) 
# formula y~x
#[optional] f * g = conditioning variables -> * = interaction between 2 variables

xyplot(Ozone ~ Wind, data = airquality, pch=8, col="red", main="Big Apple Data")
xyplot(Ozone ~ Wind | as.factor(Month), data = airquality,layout=c(5,1))

## Lattice's result = object of class 'Trellis'
p <-xyplot(Ozone~Wind,data = airquality)
print(p)
names(p)

> p[["formula"]]
Ozone ~ Wind

## Panel function
p <- xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...)  ## First call the default panel function for 'xyplot'
  panel.abline(h = median(y), lty = 2)  ## Add a horizontal line at the median
})
print(p)
invisible()

# save above panel function in 'Plot1.R'
# Run
source(pathtofile("plot1.R"), local = TRUE) #automatically plot command in 'Plot1.R'

p2 <- xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...)  ## First call default panel function
  panel.lmline(x, y, col = 2)  ## Overlay a simple linear regression line
})
print(p2)
invisible()

----Eg.----
table(diamonds$color,diamonds$cut)
xyplot(price~carat | color*cut,data=diamonds,strip = FALSE,pch=20,xlab = myxlab,ylab = myylab,main=mymain)
#35 panels, one for each combination of color and cut
#The dots (pch=20) show how prices for the diamonds in each category (panel) vary depending on carat


### Lesson 7: Working with Colors
colors()           # list 657 colors can be used in any plotting function
colorRamp()        #takes a palette of colors (arguments) -> returns a function (arguments = 0-1)
# 0 - 1: extremes of color palette
# 0-value-1: value = blend of 0-1 extreme

colorRampPalette() #takes a palette of colors (arguments) -> returns a function (arguments = interger)

pal <- colorRamp(c("red","blue")) #create function 'pal' 
pal(0)   # result = red - no green - no blue = (255,0,0)
pal(0.5) # result = palette of red + blue    = (127.5,0,127.5)
# red-green-blue = 255 - 255 - 255

> pal(seq(0,1,len=6))  # i-th vector = pal(i/5) [i=0,...,5]
     [,1] [,2] [,3]
[1,]  255    0    0
[2,]  204    0   51
[3,]  153    0  102
[4,]  102    0  153
[5,]   51    0  204
[6,]    0    0  255




### Lesson: GGPlot2
## gg = 'grammar of graphic

qplot()
ggplot()

## basic component of a ggplot2 Plot
# data frame
# aesthetic mapping: color, size
# geoms            : points, lines, shapes
# facets           : for conditional plots
# stats            : statistical transformation (binning, quantiles, smoothing)
# scales           : what scale an aesthetic map uses (eg: male=red, female=blue)
# coordinate system

## how to built plot with ggplot2
#buitl up plot in layers: + plot the data
#                         + overlay a summary
#                         + metadata + annotation
