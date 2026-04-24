#!/usr/bin/wpexec

--[[ 
########## usb_card_links.lua ###################

]]

local port_name = {}

----------- Port names and card pattern ----------

port_name.left = os.getenv('PORT_L')
port_name.right = os.getenv('PORT_R')
card_nick = os.getenv('CARD_NICK')

default_name = 'Default-Output'

-------------------------------------------------


local sink_node
local default_node
local default_port = {}
local sink_port = {}
local links = {}

local clock = os.clock

function sleep(n)
    local t0 = clock()
    while clock() - t0 <= n do end
end

function destroy_link( pout, pin )

    local pout_id = pout.properties['object.id']
    local pin_id = pin.properties['object.id']
    link_om = ObjectManager {
        Interest {
            type = 'link',
            Constraint { 'link.input.node', 'equals', sink_node['bound-id'] },
        },
    }
    link_om:connect('object-added', function(om, link)
        if sink_port.left and sink_port.right then
            if link.properties['link.output.port'] == pout_id and link.properties['link.input.port'] == pin_id then
                if sink_port.left.properties['object.id'] ~= pin_id and sink_port.right.properties['object.id'] ~= pin_id then
                    print( pout.properties['port.alias'] .. ' (' .. pout_id .. ') x---x ' .. pin.properties['port.alias'] .. ' (' .. pin_id .. ')' )
                    link:request_destroy()
                end
            end
        end
    end)
    link_om:activate()
    
end


function create_link( pout, pin )

    local pout_id = pout.properties['object.id']
    local pin_id = pin.properties['object.id']
    local link = Link("link-factory", {
        ["link.output.port"] = pout_id,
        ["link.input.port"] = pin_id,
    })
    link:activate(Features.ALL)
    local key = pout_id .. '.' .. pin_id
    links[key] = link
    print( pout.properties['port.alias'] .. '(' .. pout_id .. ') >---> ' .. pin.properties['port.alias'] .. '(' .. pin_id .. ')' )
    
end


function get_ports( node )

    sink_port_om = ObjectManager {
        Interest {
            type = 'port',
            Constraint { 'node.id', 'equals', node.properties['object.id'] },
        },
    }
    sink_port_om:connect('object-added', function( om, port )

        sink_port.left = node:lookup_port{ Constraint { 'port.name', 'equals', port_name.left }, }
        sink_port.right = node:lookup_port{ Constraint { 'port.name', 'equals', port_name.right }, }

        destroy_link( default_port.left, port )
        destroy_link( default_port.right, port )

        
        if sink_port.left == port then
            create_link( default_port.left, sink_port.left )
        elseif sink_port.right == port then
            create_link( default_port.right, sink_port.right )
        end
    end)
    sink_port_om:activate()
    
end


--- Manage Objects --------------------------
function manage_objects()

    card_om = ObjectManager {
        Interest {
            type = 'node',
            Constraint { 'node.nick', 'equals', card_nick },
            Constraint { 'media.class', 'equals', 'Audio/Sink' },
        },
    }

    default_om = ObjectManager {
        Interest {
            type = 'node',
            Constraint { 'node.name', 'equals', 'output.' .. default_name },
        },
    }

    default_port_om = ObjectManager {
        Interest {
            type = 'port',
            Constraint { 'port.alias', 'matches', default_name .. ':output_*' },
        },
    }

    ----- OM connection ---------------------
    card_om:connect('object-added', function( om, node )
        sink_node = card_om:lookup()
        default_node = default_om:lookup()
       
        if default_node then print( 'Default Node: ' .. default_node['bound-id'] ) end
        if sink_node then print( 'Sink Node: ' .. sink_node['bound-id'] ) end
        sleep(0.5)
        get_ports( sink_node )
    end)

    ----- OM connection ---------------------
    default_port_om:connect('object-added', function( om, port )
        if port.properties['port.name'] == 'output_L' then
            default_port.left = port
        end
        if port.properties['port.name'] == 'output_R' then
            default_port.right = port
        end
    end)

    default_om:activate()
    default_port_om:activate()
    card_om:activate()
    
end


if card_nick then 
    manage_objects()
    print( card_nick )
end










