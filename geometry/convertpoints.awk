BEGIN{i=1}
{
    if (NR%10==0) {print "Point(",i++,")={",$5,",",$6,", 0.0};"}
}
#END{
#    for (j=1; j<i-1; j++){
#	print "Line(",j,")={",j,",",j+1"};"
#    }
#}
