#!/usr/bin/wpexec

---- .local/share/wireplumber/scripts/snd_link_devices.lua

local virtual_sink  = "Default-Output"
--local args = component.arguments or {}

function linkPorts(source_node, source_port, sink_node, sink_port)
    -- Pipewire and wireplumber start port index with 0, so we substract 1
    print("Port: " .. sink_port )
    sink_port = sink_port - 1
    local link_args = {
        ["link.input.node"] = sink_node,
        ["link.input.port"] = sink_port,
        ["link.output.node"] = source_node,
        ["link.output.port"] = source_port,
        ["object.linger"] = true,
    }
    local link = Link("link-factory", link_args)
    link:activate(Features.ALL)
end

function setlinksForDevice(node, port_left, port_right)
    local default_port = {}
    default_port.left = 0
    default_port.right = 1
    local node_id = node.properties["object.id"]
    local node_nick = node.properties["node.nick"]
    print( "Node: " .. node_nick )
    -- Create L and R default links
    linkPorts(virtual_sink, default_port.left, node_id, port_left)
    linkPorts(virtual_sink, default_port.right , node_id, port_right)
end

-- Filter to dquire Objects
om_devices = ObjectManager {
    Interest {
        type = "node",
        Constraint { 'media.class', 'equals', 'Audio/Sink' },
        Constraint { 'node.name', 'matches', "alsa_output.*" },
    },
}

om_devices:connect("object-added", function (om, node)
    local sink_port = {}
    local node_nick = node.properties["node.nick"]
    
    --[[
    Definiciones de dispositivos
    Copia el siguiente bloque "if then end" y cambia el valor de node_nick
    y los puertos a los que quieres que se conecte virtual_sink
    --]]
    
    -- Fireface UFXII - Main
    if node_nick == "Fireface_UFXII" then
        sink_port.left = 1
        sink_port.right = 2
        setlinksForDevice(node, sink_port.left, sink_port.right)
    end
    
    -- Fireface UFXII - Phones 1
    if node_nick == "Fireface_UFXII" then
        sink_port.left = 9
        sink_port.right = 10
        setlinksForDevice(node, sink_port.left, sink_port.right)
    end 
    
    -- Signature 12
    if node_nick == "Signature_12" then
        sink_port.left = 11
        sink_port.right = 12
        setlinksForDevice(node, sink_port.left, sink_port.right)
    end

    -- M-Audio_FastTrack_A 
    if node_nick == "M-Audio_FastTrack_A" then
        sink_port.left = 1
        sink_port.right = 2
        setlinksForDevice(node, sink_port.left, sink_port.right)
    end
    print("")
end)

om_devices:activate()