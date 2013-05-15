#something is terribly wrong here

module.exports = [
  ['int', 'id']
  ['string', 'sRefCon']
  ['uint', 'type'] #0=norm; 1=dungeon; 2=raid; 3=battleground
  ['uint', 'unk0'] #boolean
  ['string', 'name']
  ['int', 'min_level']
  ['int', 'max_level']
  ['int', 'max_players']
  ['float', 'unk2']
  ['float', 'unk3']
  ['uint', 'area']
  ['string', 'horde_description']
  ['localization']
  ['string', 'alliance_description']
  ['localization']
  ['int', 'loading_screen']
  ['int', 'unk4'] # Increment in level per battlefield instance
  ['uint', 'unk5'] # bool. All 1 except for Blackfathom Deeps
  ['float', 'unk6']
  ['int', 'unk1']
]