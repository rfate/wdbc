# WDBC

WDBC is a basic CoffeeScript (deal with it) DBC manipulation library for World of Warcraft, aimed at full 1.12.1 schema support.

## Warning
Back up your shit, safety ain't guaranteed.

## Simple Example
```coffeescript
DBC = require 'wdbc'
outfits = new DBC('CharStartOutfit.dbc.bak', 'CharStartOutfit')

for record in outfits.data.records
  record['item_id_1'] = 18231 # Sleeveless T-Shirt

outfits.save 'CharStartOutfit.dbc'
```
