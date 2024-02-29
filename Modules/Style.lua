--------------------------------------------------------------------------------
-- # MODULES > STYLE
--------------------------------------------------------------------------------

-- add additional font sizes
CHAT_FONT_HEIGHTS = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}

-- fade chat frame and tabs
CHAT_FRAME_FADE_TIME = .5
CHAT_TAB_SHOW_DELAY = 0
CHAT_TAB_HIDE_DELAY = .5
CHAT_FRAME_FADE_OUT_TIME = .5
CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = .2
CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = .8
CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA = 1

local f = CreateFrame('Frame')
f:RegisterEvent('PLAYER_ENTERING_WORLD')
f:SetScript('OnEvent', function(self, event)

  -- hide social button
  QuickJoinToastButton:HookScript('OnShow', QuickJoinToastButton.Hide)
  QuickJoinToastButton:Hide()

  -- hide shortcut button for emotes/languages/etc
  ChatFrameMenuButton:HookScript('OnShow', ChatFrameMenuButton.Hide)
  ChatFrameMenuButton:Hide()

  -- hide voice deafen button
  ChatFrameToggleVoiceDeafenButton:HookScript('OnShow', ChatFrameToggleVoiceDeafenButton.Hide)
  ChatFrameToggleVoiceDeafenButton:Hide()

  -- hide voice mute button
  ChatFrameToggleVoiceMuteButton:HookScript('OnShow', ChatFrameToggleVoiceMuteButton.Hide)
  ChatFrameToggleVoiceMuteButton:Hide()
  ChatFrameChannelButton:HookScript('OnShow', ChatFrameChannelButton.Hide)
  ChatFrameChannelButton:Hide()

  -- keep track of frames we have already seen
  local frames = {}

  local function SkinChatFrames(frame)
    if frames[frame] then return end
    local name = frame:GetName()
    local editbox = _G[name..'EditBox']

    -- hide button frame
    _G[name..'ButtonFrame']:Hide()

    -- strip edit box textures
    for k = 3, 8 do
      select(k, editbox:GetRegions()):SetTexture(nil)
    end

    -- allow arrow keys in edit box
    editbox:SetAltArrowKeyMode(false)

    -- create backdrop for edit box
    Mixin(editbox, BackdropTemplateMixin)
    editbox:SetBackdrop( {
      bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
      edgeFile = "Interface\\Buttons\\WHITE8x8",
      tile = true,
      tileEdge = true,
      tileSize = 8,
      edgeSize = 1,
      insets = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    editbox:SetBackdropColor(0, 0, 0, .5)
    editbox:SetBackdropBorderColor(0, 0, 0, .8)

    -- adjust edit box border based on active chat channel
    hooksecurefunc("ChatEdit_UpdateHeader", function(editBox)
      local chatType = editBox:GetAttribute("chatType")
      if not chatType then
        return
      end

      local info = ChatTypeInfo[chatType]
      editbox:SetBackdropBorderColor(info.r, info.g, info.b, .5)
    end)

    -- reposition edit box
    editbox:ClearAllPoints()
    editbox:SetPoint('TOPLEFT', ChatFrame1, 'BOTTOMLEFT', -3, -8)
    editbox:SetPoint('TOPRIGHT', ChatFrame1, 'BOTTOMRIGHT', 16, -8)

    -- hide chat tabs textures
    local tab = _G[name..'Tab']
    for i = 1, select('#', tab:GetRegions()) do
      local texture = select(i, tab:GetRegions())
      if texture and texture:GetObjectType() == 'Texture' then
          texture:SetTexture(nil)
      end
    end

    frames[frame] = true
  end

  -- retrieve all permanent chat windows and apply skin
  for i = 1, NUM_CHAT_WINDOWS do
    SkinChatFrames(_G['ChatFrame' .. i])
  end

  -- set up a dirty hook to catch temporary windows to apply skin on them
  local old_OpenTemporaryWindow = FCF_OpenTemporaryWindow
  FCF_OpenTemporaryWindow = function(...)
    local frame = old_OpenTemporaryWindow(...)
    SkinChatFrames(frame)
    return frame
  end
end)
