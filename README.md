# Project 2: Shiny App Development

### [Project Description](doc/project2_desc.md)

Term: Spring 2023

![preview](doc/figs/map1.jpg)

In this second project of GR5243 Applied Data Science, we develop a *Exploratory Data Analysis and Visualization* shiny app on the work of a **NYC government agency/program** of your choice using NYC open data released on the [NYC Open Data By Agency](https://opendata.cityofnewyork.us/data/) website. In particular, many agencies have adjusted their work or rolled out new programs due to COVID, your app should provide ways for a user to explore quantiative measures of how covid has impacted daily life in NYC from different prospectives. See [Project 2 Description](doc/project2_desc.md) for more details.

The **learning goals** for this project is:

-   business intelligence for data science
-   data cleaning
-   data visualization
-   systems development/design life cycle
-   shiny app/shiny server

\*The above general statement about project 2 can be removed once you are finished with your project. It is optional.

## Project Title: LibGo

Term: Spring 2023

-   Team - Group 4
    -   Liang Hu
    -   Kejun Liu
    -   Yunfan Liu
    -   Han Wang
    -   Jingshu Zhang
    -   Renqi Zhang
-   **Project summary**: We develop a shiny app on the Queens public libraries using NYC open data released on the <https://data.cityofnewyork.us/Education/Queens-Library-Branches/kh3d-xhq7> website, in order to provide a clear guide for residents and students who need libraries to study.

First, we have map functions: location map and popularity map, which show the location of libraries that are open every day and the population density of this community, respectively. Obviously, the more populated the community is, the more libraries are established.

Second, we use data visualization to analyze how many libraries are open in each time period and how many people are served by each library in the community.

Finally, we have a general search function, which allows us to search for the corresponding library based on input keywords such as zip codes, regions, and names.

This app is a convenient and quick access to information for all those who need libraries.

-   **Contribution statement**: ([default](doc/a_note_on_contributions.md))\
    All team members contributed equally in all stages of this project. All team members approve our work presented in this GitHub repository including this contribution statement.

Liang Hu is responsible for creating the general search engine. Also, testing and deploying the app.

Kejun Liu is responsible for creating the general search engine

Yunfan Liu is responsible for creating the interactive location map across different days.

Han Wang is responsible for creating map and pop-up in location map, and create the map of popularity.

Jingshu Zhang is responsible for plotting the interactive graph across day in every week

Renqi Zhang is responsible for plotting the interactive graph across the city and zipcode.

Following suggestions by RICH FITZJOHN (@richfitz). This folder is organized as follows.

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

    proj/
    ├── app/
    ├── lib/
    ├── data/
    ├── doc/
    └── output/

Please see each subfolder for a README file.
