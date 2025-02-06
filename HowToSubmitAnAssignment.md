## Why not to submit a notebook?
All assignments are a piece of work, that explains a story (almost). Therefore it needs to be clear, descriptive and preferably interactive as well for the viewer.

There are multiple ways to create an output in which the results/figures can be emphasized and not the code itself, that generated it as it is in a notebook.

## 1. Convert it to an HTML file
jupyter offers an easy way to convert a notebook into a (semi)static HTML file:
``` bash
jupyter nbconvert HowToSubmitAnAssignment.ipynb
```
[This Tutorialspoint site](https://www.tutorialspoint.com/jupyter/jupyter_converting_notebooks.htm) will give you more tips about conversions.

One can also define the styling, colors or use a template

### Useful options
 * --execute: executes all cells, it might be needed, to create the right image for the fiven file format
 * --no-input: exclude input cells (code cells)

## 2. Convert it into another format
Same as before but one can set the `--to` parameter to *pdf*, *latex*, *slides* etc...

## 3. Create an output with visualization modules
There are several modules that is intended for nicely formatted output and offers a structured layout


* [Bokeh](https://docs.bokeh.org/en/latest/)
* [Holoviews](https://holoviews.org/) a higher level wrapper for many modules
* [Pyviz](https://pyviz.org/) a collection of modules using various engines (matplotlib, bokeh, plotly)

* [Plotly](https://plotly.com/) for both python and R users

or 

* [R shiny](https://shiny.rstudio.com/) for R users (but python code can be included as well)

# Advanced codes
As we will see on the [Interactive Visualization](Lecture/L-04-Interactive_Visualization/) lecture, all visualizations that can be revealed in a browser is a mixture of HTML, CSS, JS etc. codes. When using the jupyter notebook we are working in an environment that is defined by these coding languages.

There is always a way to directly change these codes and change the outlook of the enviroment or the output.
In the [presentationtricks](presentationtricks) folder there is collection of codes, that showcase how can one modify the default environment.


