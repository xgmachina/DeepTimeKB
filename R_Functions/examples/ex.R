gts.list("international") # international should be the latest isc
gts.list("international", "Epoch")
gts.list("North America", "Epoch")
gts.list(region = 2) # error
gts.list(region = "international", "non") # error


gts.range("Jurassic")
gts.range("Harju")
gts.range("Wordian")
gts.range("Wordian", region = "North America")
gts.range("Wordian", region = "international")
gts.range("Wordian", region = "2018")
gts.range("Wordian", region = "New Zealand") # warning

