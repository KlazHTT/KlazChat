local addon, ns = ...
local L = {}
ns.L = L

--------------------------------------------------------------------------------
-- // CORE > LOCALIZATION
--------------------------------------------------------------------------------

setmetatable(L, { __index = function(t, k)
  local v = tostring(k)
  t[k] = v
  return v
end })

-- ## ENGLISH
--------------------------------------------------------------------------------

L.SHORT_INSTANCE = 'I'
L.SHORT_INSTANCE_LEADER = 'IL'
L.SHORT_PARTY = 'P'
L.SHORT_PARTY_LEADER = 'PL'
L.SHORT_WHISPER_FROM = 'From'
L.SHORT_GUILD = 'G'
L.SHORT_OFFICER = 'O'
L.SHORT_RAID = 'R'
L.SHORT_RAID_LEADER = 'R'
L.SHORT_RAID_WARNING = 'RW'

L.SHORT_FLAG_AFK = '[AFK]'
L.SHORT_FLAG_DND = '[DND]'
L.SHORT_FLAG_GM = '[GM]'

L.SHORT_STATUS_ONLINE = '|cff00ff00+|r'
L.SHORT_STATUS_OFFLINE = '|cffff0000-|r'

local locale = GetLocale()
if locale == 'en_GB' or locale == 'en_US' then return end -- ENGLISH

-- ## OTHER
--------------------------------------------------------------------------------

-- if locale == 'esMX' then return end  -- SPANISH (MEXICO)
-- if locale == 'pt_BR' then return end -- PORTUGEUSE
-- if locale == 'de_DE' then return end  -- GERMAN
-- if locale == 'es_ES' then return end  -- SPANISH (SPAIN)
-- if locale == 'fr_FR' then return end  -- FRENCH
-- if locale == 'it_IT' then return end -- ITALIAN
-- if locale == 'ru_RU' then return end  -- RUSSIAN
-- if locale == 'ko_KR' then return end -- KOREAN
-- if locale == 'zh_TW' then return end  -- CHINESE (TRADITIONAL)
-- if locale == 'zh_CN' then return end  -- CHINESE (SIMPLIFIED)
