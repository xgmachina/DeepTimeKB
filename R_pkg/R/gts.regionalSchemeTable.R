gts.regionalSchemeTable = function(){
  region = c("West Europe", "Tethyan", "N-E Siberia",     "South China", "Russia Platform", "New Zealand", "North China", "North America","Kazakhstan", "Japan", "Iberian-Morocco", "California", "Britain", "Boreal", "Baltoscania" ,"East Avalonian", "Australia"  )
  scheme = c("tswe",   "tste",   "tssi",   "tssc",   "tsru",   "tsnz",   "tsnc",   "tsna",   "tska",   "tsjp", "tsibmo", "tsca",   "tsbr",   "tsbo",   "tsba",   "tsav",   "tsau")
  result = data.frame(region, scheme)
  return(result)
}
