        ## Assignment Goal:
        ## ==============
        
        # The overall goal of this assignment is to explore the National Emissions Inventory database and 
        # see what it say about fine particulate matter pollution in the United states over the 10-year 
        # period 1999-2008. You may use any R package you want to support your analysis.
        
        # Problem Statement 3:
        #---------------------
        # Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
        #which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
        #Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make
        #a plot answer this question.
        
        
        ## Variable Descriptions - SummarySCC+PM25.rds:
        #------------------------------------------------
        # fips: A five-digit number (represented as a string) indicating the U.S. county
        # SCC: The name of the source as indicated by a digit string (see source code classification table)
        # Pollutant: A string indicating the pollutant
        # Emissions: Amount of PM2.5 emitted, in tons
        # type: The type of source (point, non-point, on-road, or non-road)
        # year: The year of emissions recorded
        ##--------------------------------------------------------------
        
        # set working directory right
        
        #setwd("C:\\coursera\\Data Analysis\\Project2")
        
        # Load Data from working directory
        NEI <- readRDS("summarySCC_PM25.rds")
        
        #head(NEI)
        # fips      SCC Pollutant Emissions  type year
        # 4  09001 10100401  PM25-PRI    15.714 POINT 1999
        # 8  09001 10100404  PM25-PRI   234.178 POINT 1999
        # 12 09001 10100501  PM25-PRI     0.128 POINT 1999
        
        
        #plot showing the total PM2.5 emission from all sources for 
        # each of the years 1999, 2002, 2005, and 2008 only for  
        #Baltimore City, Maryland (fips == 24510) 
        NEI_Maryland<-NEI[NEI$fips == 24510,]
        
        # Get total from all sources for each year
        
        require("plyr")
        #library(plyr)
        #total_PM25$NEI <- as.factor(total_PM25$NEI)
        
        # We need to summarize by bothe year and type
        total_PM25<-ddply( NEI_Maryland, .(year,type), summarize, total_emission=sum(Emissions))
        head(total_PM25)
        
        # Plot Years ~ Total Emissions in Baltimore City, Maryland for each Type
        # require ggplot2 package
        library(ggplot2)
        
        png("plot3.png")
        ggplot(data=total_PM25, aes(x=year, y=total_emission, group=type, shape=type, colour=type)) + geom_line() + geom_point()
        dev.off()
        
        
        
        # End