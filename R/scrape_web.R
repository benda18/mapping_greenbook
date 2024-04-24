library(renv)
library(dplyr)
library(jsonlite)
library(rvest)
library(xml2)
library(htmltools)

renv::snapshot()

rm(list=ls());cat('\f')

url.nc <- "https://justice.tougaloo.edu/location/north-carolina/"

html.nc <- rvest::read_html(url.nc)

View(html.nc)

# xml_child(html.nc, 2) %>% class
# 
# ?xml_child

View(xml_child(html.nc, 2))

child.xpath <- "/html/body/div[1]/div[2]/div/div/main/div/article[1]/div/div/header/h2/a"
child.out.html <- "<a href=\"https://justice.tougaloo.edu/sundowntown/bakersville-nc/\" rel=\"bookmark\">Bakersville</a>"

child.node.url <- html_element(x = xml_child(html.nc, 2), 
              xpath = child.xpath)


html_element(x = xml_child(html.nc, 2), 
             css = "html body.archive.tax-location.term-north-carolina.term-59.wp-custom-logo.ehf-footer.ehf-template-astra.ehf-stylesheet-history-sj-astra-child.ast-page-builder-template.ast-no-sidebar.astra-3.7.7.ast-header-custom-item-inside.ast-full-width-primary-header.ast-inherit-site-logo-transparent.elementor-default.elementor-kit-417.ast-desktop.e--ua-firefox.ast-mouse-clicked div#page.hfeed.site div#content.site-content div.ast-container div#primary.content-area.primary main#main.site-main div.ast-row article#post-6119.post-6119.sundowntown.type-sundowntown.status-publish.hentry.location-north-carolina.ast-col-sm-12.ast-article-post div.ast-post-format-.ast-no-thumb.blog-layout-1 div.post-content.ast-col-md-12 header.entry-header h2.entry-title a")
html_element(child.out.html)
