# Course material for Data Exploration and Visualisation 
### 2025 spring semester

This course is part of the [Scientific Data Analytics and Modelling Programme](https://datascience.elte.hu/en/Default.aspx#top).
The aim of the course is that students gain practical skills in **accessing large databases/datasets**, handling **data stored in different formats**, **exploring/cleaning these data** and **presenting** the gathered information. During the course students will come across databases used in various scientific fields. Completing of the several projects allows students to gain useful experiences that will give a firm foundation for later courses on theoretical datamining and advanced computing laboratories.
In this course we intend to introduce **state of the art tools and methods** for data exploration and visualization. A library in a given programming language that we use today might become obsolete in a year or become the standard for a longer time. This field evolves rapidly and therefore the emphasis is not on the exact tool for solving a task, but the notions and algorithms. 

There is a useful tutorial into python and some data transformation/analysis methods http://bokae.web.elte.hu/numerical_methods.html), which gives a wide background knowledge, that comes handy. Also for those who prefer the language R there are several tutorials.

During the course every sample code will be shown in **jupyter notebooks**, which can be accessed on the [K8plex Edu platform](https://k8plex-edu.elte.hu) and in this Github repository.

The course is held in the **North Building** in computer lab **5.56** every **Tuesday between 12:15-14:45**.
  
#### Course info
Neptun code: 	**dsexplorf20vm** <br>
Instructor: 	**[Dávid Visontai](http://benedek.web.elte.hu/)**<br>
Semester: 	spring <br>
Type: 	Lecture + Practice <br>
Credit points: 	6 <br>
Prerequisites: 	programming in either **python**, **R** - using Jupyter notebooks or RMarkdown<br>

Each occasion starts with approximately a twenty minute of introduction into the current topic. After that everyone can work on the assignments and the consultants will be available for help with the any related problems and questions. For those who lack experience in either programming or data analysis it is highly recommended to attend the lecture and practice sessions. There are many tricks and tips that can be learned much quicker from personal discussions.

### The schedule of the course 
1,  11.02.2025. **[Introduction to K8plex Edu](https://k8plex-edu.elte.hu/hub)**, **[Jupyter Notebooks](https://jupyter.org/)**, **Requirements for the course**,
                **[Timeseries analysis](Lectures/Timeseries/02-Timeseries.pdf)** and **[USGS water discharge statistics](Assignments/Timeseries)**<br>
2,  18.02.2025. **[Maps, shapes, coordinates](Lectures/Shapes-Maps-Coordinates)** <br>
3,  25.02.2025. **[Review the basics, Python, Pandas, etc.](Basics_Python_pandas)** <br>
4,  04.03.2025. **[Image exploration](Lectures/Image_Exploration)**  <br>
5,  11.03.2025. **[Network exploration](Lectures/Networks)** <br>
6,  18.03.2025. **[SQL queries](Lectures/SQL)** <br>
7,  25.03.2025. **[Natural Language Processing](Lectures/NLP)** <br>
8,  01.04.2025. **[Datacleaning, and Filtering, Reproducibility](Lectures/Datacleaning-reproducibility)** <br>
9,  08.04.2025. **[Interactive Visualization](Lectures/Interactive_Visualization)** <br>
10, 15.04.2025. **[REST services](Lectures/HTTP-REST-API)** <br>
11, 29.04.2025. **[Working with large datasets](Lectures/LargeData)**<br>
12, 06.05.2025. **Away for conference, no lecture** <br>
13, 13.05.2025. **Consultation only** <br>

<!-- **[NoSQL - Elasticsearch and Kibana, GraphQL](Lectures/L-NoSQL-ES)** -->

### Covered topics

 * Datatypes, images, tables, graphs, textual data
 * Standards of file- and dataformats ([csv](https://www.computerhope.com/issues/ch001356.htm), [hdf5](https://en.wikipedia.org/wiki/Hierarchical_Data_Format), [netcdf](https://en.wikipedia.org/wiki/NetCDF))
 * Raw and processed data, metadata, data cleaning 
 * Access data locally and through the web ([API](https://restfulapi.net/)s, [HTTP protocol](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol))
 * Access of scientific databases, Usage of relational databases ([SQL](https://www.w3schools.com/sql/))
 * Transforming data, sorting, combining [pandas](https://pandas.pydata.org/)
 * Basics of timeseries analysis
 * Handling datasets with geolocation ([shapely](https://shapely.readthedocs.io/en/stable/manual.html), [folium](https://python-visualization.github.io/folium/), [geoviews](https://geoviews.org/))
 * Basics of image processing ([opencv](https://opencv.org/))
 * Dimension reduction, clustering
 * Processing textual data, logs ([natural language processing](https://www.nltk.org/))
 * Infographics, visualisation (html, css, javascript libraries)
 * Interactive dataexplorative tools ([ipywidgets](https://ipywidgets.readthedocs.io/), [bokeh](https://bokeh.org/), [holoviews](http://holoviews.org/))
 * Creating applications with [Streamlit](https://streamlit.io/)
 * Developing open source softwares, reproducible research ([OSF](https://osf.io/))

### Assignments, the expected output format and the name of the corrector

1. **[Following John Snow](Assignments/Shapes-Maps-Coordinates)**- HTML - Ágnes Becsei
2. **[USGS water discharge statistics](Assignments/Timeseries)** - HTML - Dávid Visontai
3. SQL queries
   * **a)** **[NBA database](Assignments/SQL-A-Basketball)** NBA 2008-2009 season - HTML - Dávid Visontai
   * **b)** **[Biological database](Assignments/SQL-B-Coveo)** Analysis of SARS-COV-2 mutation database - HTML - Anikó Mentes
  
4. Interactive Visualization
   * **a) [ATLO.info reproduction](Assignments/InteractiveVisualizations)**  - HTML or Hosted App - Krisztián Papp
   * **b) [Finding the culprit bacteria, analysis of a nanopore sequencing result](Assignments/InteractiveVisualizations)

5. Application
   * **a) [REST API](Assignments/HTTP-REST-API)** - (REST service/API) - Dávid Visontai
   * **b) **
6. **[Network exploration](Assignments/Networks)** - HTML - Dávid Visontai
7. **[Data extraction from images](Assignments/Image_Exploration)** - HTML - József Stéger
8. **[Natural Language Processing on tweets](Assignments/NLP)** - HTML - !!! Ex 7. and 8. is optional. - Eszter Bokányi

You have to submit **8 assignment** (choose one from each topic)
All assigments should be converted into HTML unless stated otherwise!

The submitted results should look like a **report**, which can be generated from the notebooks. This will be explained on the [lecture](1-createreport). All figures should have *labels*, *title*, each exercise should end with a descriptive *conclusion* and explanatory comments should be inserted into the code. These are **must have features** of a work that is intended for presentation.

<span id="deadline"></span>
### (Final) Submission deadline
The assignments/projects will be released in the first couple of weeks, which you have to submit after the end of the course **17th June 1PM (this is the last deadline)**. Each submitted assignment will be corrected and a feedback will be given. After that you may resubmit your assignment **once more** but before the final deadline.

### Where to work on the assignments?
https://k8plex-edu.elte.hu/hub is where the notebooks will be handed out. It is available for all students with a valid **Neptun** or **caesar** account. Once you launch your environment you will find a folder with the course material. The notebooks will be available in this Github repository as well.
We will explain how to use the portal on the first lecture.
In case there is any problem with the portal you can run a notebook server locally on any other computer and upload your work later.

### Grading

Each assignment will be corrected after submission and a maximum of **20 points** will be given for it. **10** for all the **completed tasks**, **10** for the **quality** of the submitted report (look, clarity and comments). 
The final grades will be given according to the following point system:<br>
0 - 50: failed<br>
51 - 70: 2<br>
71 - 94: 3<br>
95 - 115: 4<br>
116 - : 5<br>

### Folder structure of the working environment

* Assignments will be visible in `/v/courses/dataexvis.assignments`
* Example Datasets will be in the `/v/courses/dataexvis.public/Datasets` directory you will find datasets, that you can work with.
* Other lecture materials will be in `/v/courses/dataexvis.public/<lecture_name>` and on this github page

### Learning materials
* Python tutorial: http://bokae.web.elte.hu/numerical_methods.html (translated from the BSc course "numerical methods in physics I" by Eszter Bokányi, work in progress )
* SQL tutorial: https://www.w3schools.com/sql/ 
* RESTful service: https://en.wikipedia.org/wiki/Representational_state_transfer
* Networkx: https://networkx.github.io/

#### Recommended readings

* Wes McKinney: Python for Data Analysis, (O’Reilly 2013)
* Joel Grus: Data Science from Scratch (O’Reilly 2015)

### Simulation and data visualizations
* https://www.washingtonpost.com/graphics/2020/world/corona-simulator/

## List of tutors
* Ágnes Becsei
* Anikó Mentes
* Krisztián Papp
* József Stéger
* Dávid Visontai

