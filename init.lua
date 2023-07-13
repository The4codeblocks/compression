local to_compress = {
	"default:clay"
	"default:desert_stone"
	"default:desert_sandstone"
	"default:stone"
	"default:sandstone"
	"default:silver_sandstone"
	"default:dry_dirt"
	"default:gravel"
	"default:ice"
	"default:permafrost"
	"default:obsidian"
	"default:snowblock"
	"wool:white"
}
compression.register_compressed_nodes(to_compress)

if minetest.get_modpath("moreblocks") then
	compression.register_compressed_tiers("moreblocks:cobble_compressed")
	compression.register_compressed_tiers("moreblocks:desert_cobble_compressed")
	compression.register_compressed_tiers("moreblocks:dirt_compressed")
else
	compression.register_compressed_tiers("moreblocks:cobble")
	compression.register_compressed_tiers("moreblocks:desert_cobble")
	compression.register_compressed_tiers("moreblocks:dirt")
end