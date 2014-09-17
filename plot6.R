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
        
        SCC <- readRDS("Source_Classification_Code.rds")
        # 
        # head(SCC)
        # SCC Data.Category                                                                 Short.Name
        # 1 10100101         Point                   Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal
        # 2 10100102         Point Ext Comb /Electric Gen /Anthracite Coal /Traveling Grate (Overfeed) Stoker
        # 3 10100201         Point       Ext Comb /Electric Gen /Bituminous Coal /Pulverized Coal: Wet Bottom
        
        # EI.Sector Option.Group Option.Set               SCC.Level.One       SCC.Level.Two
        # 1 Fuel Comb - Electric Generation - Coal                         External Combustion Boilers Electric Generation
        # 2 Fuel Comb - Electric Generation - Coal                         External Combustion Boilers Electric Generation
        # 3 Fuel Comb - Electric Generation - Coal                         External Combustion Boilers Electric Generation
        
        # SCC.Level.Three                                SCC.Level.Four Map.To Last.Inventory.Year Created_Date
        # 1               Anthracite Coal                               Pulverized Coal     NA                  NA             
        # 2               Anthracite Coal             Traveling Grate (Overfeed) Stoker     NA                  NA             
        # 3 Bituminous/Subbituminous Coal Pulverized Coal: Wet Bottom (Bituminous Coal)     NA                  NA             
        
        # Revised_Date Usage.Notes
        # 1                         
        # 2                         
        # 3                         
        
        #Baltimore City, Maryland (fips == 24510) | Los Angeles County, California (fips == 06037)
        NEI_Baltimore_LA<-NEI[NEI$fips == "24510" | NEI$fips =="06037", ]
        #test<-SCC[,c("EI.Sector" ,"Option.Group" ,"Option.Set", "SCC.Level.One" , "SCC.Level.Two")]
        #head(test)
       
        
        NEI_Baltimore_LA$city[NEI_Baltimore_LA$fips=="24510"]<-"Baltimore"
        NEI_Baltimore_LA$city[NEI_Baltimore_LA$fips=="06037"]<-"LA City"
        
        # Subset only for Motor Vehicle
        motor_vh<-as.data.frame(SCC[grepl("Vehicles",SCC$EI.Sector,ignore.case=TRUE),1])
        colnames(motor_vh)<-"SCC"
        
        NEI_BM_LA_MVH<-merge(  NEI_Baltimore_LA, motor_vh, by="SCC" )
        
              
        # Get total from all sources for each year
        
        require("plyr")
        #library(plyr)
        #total_PM25$NEI <- as.factor(total_PM25$NEI)
        
        # We need to summarize by bothe year and type
        total_PM25<-ddply(NEI_BM_LA_MVH, .(year, city), summarize, total_emission=sum(Emissions))
        head(total_PM25)
        
        # Plot Years ~ Total Emissions in Baltimore City, Maryland for each Type
        # require ggplot2 package
        library(ggplot2)
        
        png("plot6.png")
        ggplot(data=total_PM25, aes(x=year, y=total_emission, group=city, shape=city, colour=city)) + geom_line() + geom_point() + labs(title=" Baltimore ~ LA: PM2.5 Emissions from Sources Related to Motor Vehicle")
        dev.off()
        
        
        
        # End