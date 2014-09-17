        ## Assignment Goal:
        ## ==============
        
        # The overall goal of this assignment is to explore the National Emissions Inventory database and 
        # see what it say about fine particulate matter pollution in the United states over the 10-year 
        # period 1999-2008. You may use any R package you want to support your analysis.
        
        # Problem Statement 1:
        #---------------------
        # Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
        # Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for 
        # each of the years 1999, 2002, 2005, and 2008.
        
        
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
        
        setwd("C:\\Users\\TCS Profile\\Desktop\\coursera\\Data Analysis\\Project2")
        
        # Load Data from working directory
        NEI <- readRDS("summarySCC_PM25.rds")
        
        #head(NEI)
        # fips      SCC Pollutant Emissions  type year
        # 4  09001 10100401  PM25-PRI    15.714 POINT 1999
        # 8  09001 10100404  PM25-PRI   234.178 POINT 1999
        # 12 09001 10100501  PM25-PRI     0.128 POINT 1999
        
        
        #plot showing the total PM2.5 emission from all sources for 
        # each of the years 1999, 2002, 2005, and 2008
        
        # Get total from all sources for each year
        
        require("plyr")
        #library(plyr)
        #total_PM25$NEI <- as.factor(total_PM25$NEI)
        
        total_PM25<-ddply(NEI, .(year), summarize, total_emission=sum(Emissions))
        
        # Alternate option
        #total_PM25<- as.data.frame(aggregate(NEI$Emissions, by=list( Year=NEI$year), sum, na.rm=TRUE))
        #colnames(total_PM25) <- c("year","total_emissions")
        
        head(total_PM25)
        
        # Plot Years ~ Total Emissions
        png("plot1.png")
        plot(total_PM25$year, total_PM25$total_emission, type="l", col="red", 
             xlab="Year",ylab="Total PM2.5 Emission (all sources)", main="National PM2.5 Emission Trends (All Sources)")
        lines(total_PM25$year,total_PM25$total_emission, col="red")
        dev.off()
        
        # End