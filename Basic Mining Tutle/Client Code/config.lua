-- Configuration File ~ v0.1 --

-- will attempt to start the Miner program automatically when starting up
automatic_startup = false

-- will attempt to pick where it left off before being broken.
-- This will also work with server restarts.
automatic_continuation = false

-- Send and recieve rednet signals
rednet_enabled = false

FuelSources = {
    Charcoal = "Charcoal",
    Coal = "Coal",
    CoalBlocks = "CoalBlocks",
    Lava = "Lava"
}

selected_fuel = FuelSources.Lava