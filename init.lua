local to_compress = {
	"default:clay",
	"default:desert_stone",
	"default:desert_sand",
	"default:stone",
	"default:sand",
	"default:silver_sand",
	"default:dry_dirt",
	"default:gravel",
	"default:ice",
	"default:permafrost",
	"default:obsidian",
	"default:snowblock",
	"default:coalblock",
	"wool:white",
}

compression.register_compressed_nodes(to_compress)
compression.compressed_nodes = table.copy(to_compress) 

local moreblocks_available = minetest.get_modpath("moreblocks")
local max_compression_level = tonumber(minetest.settings:get("max_compression_level") or 10)

local mod = ""
local moreblocks_stone_output = ""
local moreblocks_desert_stone_output = ""

if moreblocks_available then
	compression.register_compressed_tiers("moreblocks:cobble_compressed")
	compression.register_compressed_tiers("moreblocks:desert_cobble_compressed")
	compression.register_compressed_tiers("moreblocks:dirt_compressed")

    if max_compression_level > 0 then
        moreblocks_stone_output, moreblocks_desert_stone_output = "compression:default_stone_compressed_level_1", "compression:default_desert_stone_compressed_level_1"
    else
        moreblocks_stone_output, moreblocks_desert_stone_output = "default:stone 9", "default:desert_stone 9"
    end

	minetest.register_craft({
        type = "cooking",
        recipe = "moreblocks:cobble_compressed",
        output = moreblocks_stone_output,
        cooktime = 9,
    })
	minetest.register_craft({
        type = "cooking",
        recipe = "moreblocks:desert_cobble_compressed",
        output = moreblocks_desert_stone_output,
        cooktime = 9,
    })

    mod = "moreblocks"
else
	compression.register_compressed_tiers("default:cobble")
	compression.register_compressed_tiers("default:desert_cobble")
	compression.register_compressed_tiers("default:dirt")

    mod = "default"
end

for level = 1, max_compression_level, 1 do
    minetest.register_craft({
        type = "cooking",
        recipe = "compression:"..mod.."_cobble_compressed_level_"..level,
        output = "compression:default_stone_compressed_level_"..level,
        cooktime = 3^level,
    })
    minetest.register_craft({
        type = "cooking",
        recipe = "compression:"..mod.."_desert_cobble_compressed_level_"..level,
        output = "compression:default_desert_stone_compressed_level_"..level,
        cooktime = 3^level,
    })
    if level < 8 then
        minetest.register_craft({
            type = "fuel",
            recipe = "compression:default_coalblock_compressed_level_"..level,
            burntime = 370*(9^level),
        })
    end
end
