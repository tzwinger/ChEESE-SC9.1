awk -F, '{print "Point(",287 + i++,")={",$1,",",$2,", 0.0, lcc};"}' floodpaths.csv  > floodpaths.geo
