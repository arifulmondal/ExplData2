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