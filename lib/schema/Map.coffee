#something is still wrong here

module.exports = [
  ['int', 'id']
  ['string', 'internal_name']
  ['uint', 'type'] #0=norm; 1=dungeon; 2=raid; 3=battleground
  ['uint', 'unk0'] #boolean, isBattleground?
  ['string', 'name']
  ['localization']
  ['float', 'unk2']
  ['int', 'min_level']
  ['int', 'max_level']
  ['int', 'max_players']
  ['float', 'unk2']
  ['float', 'unk3']
  ['uint', 'area']
  ['int', 'horde_description']
  ['localization']
  ['int', 'alliance_description']
  ['localization']
  ['int', 'loading_screen']
  # ['int', 'unk1']
  ['int', 'unk4'] # Increment in level per battlefield instance
  ['uint', 'unk5'] # bool. All 1 except for Blackfathom Deeps
  ['float', 'unk6']
]