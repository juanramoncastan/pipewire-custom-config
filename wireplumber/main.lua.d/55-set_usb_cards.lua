#!/usr/bin/wpexec

-------- Rules for USB Audio Cards -----------------------------------
----------------------------------------------------------------------
-- [ Key=Nick ] = Val=Pattern

local USB_card_patterns = {
['Fireface_UFXII'] = 'RME_Fireface_UFX_II',
['Midas_MR18'] = 'MIDAS_MR18',
['Midas_M32'] = 'DN32-LIVE',
['Soundcraft_Signature12'] = 'Soundcraft_Signature_12',
['Soundcraft_Signature22'] = 'Soundcraft_Signature_22',
['Mackie_Onyx12'] = 'Onyx12',
['Focusrite_Scarlett'] = 'Focusrite_Scarlett',
['MAudio_FastTrack'] = 'M-Audio_FastTrack',
['AllenHeath_CQ12'] = 'Allen_Heath_Ltd_CQ12T',
['Behringer_UMC204'] = 'BEHRINGER_UMC204HD',
}

-------- Rules for Node -----------------------------------
for key, val in pairs(USB_card_patterns) do
    local name = key
    local pattern = val

    rule = {
        matches = {
            {
              { 'device.name', 'matches', 'alsa_card.usb*' .. pattern .. '*' },
            },
        },
        apply_properties = {
            ['device.nick'] = name,
            ['device.description'] = name,
            ['device.profile'] = 'pro-audio',
            ['device.profile.pro'] = 'true',
            --['priority.driver'] = '1011',
            --['priority.session'] = '1011',
        },
    }
    table.insert(alsa_monitor.rules,rule)
    
    rule = {
        matches = {
            {
              { 'node.name', 'matches', 'alsa*' .. pattern .. '*' },
            },
        },
        apply_properties = {
            ['node.pasive'] = 'true',
            ['audio.position'] = '1,2',
            ['item.features.monitor'] = 'false',
            ['node.autoconnect'] = "false",
            ['node.dont-reconnect'] = 'true',
            --['object.linger'] = 'false',
            --['api.alsa.disable-batch'] = 'true',
        },
    }
    table.insert(alsa_monitor.rules,rule)
end





