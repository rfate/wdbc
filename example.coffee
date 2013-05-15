#!/usr/bin/env coffee

DBC = require 'wdbc'
outfits = new DBC('CharStartOutfit.dbc.bak', 'CharStartOutfit')

for record in outfits.data.records
  record['item_id_1'] = 18231 # Sleeveless T-Shirt

outfits.save 'CharStartOutfit.dbc'