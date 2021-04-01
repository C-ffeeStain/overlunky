local module = {}
pot_cbs = {}

items = {ENT_TYPE.MONS_SNAKE, ENT_TYPE.MONS_SPIDER, ENT_TYPE.MONS_HANGSPIDER, ENT_TYPE.MONS_GIANTSPIDER,
         ENT_TYPE.MONS_BAT, ENT_TYPE.MONS_CAVEMAN, ENT_TYPE.MONS_SKELETON, ENT_TYPE.MONS_REDSKELETON,
         ENT_TYPE.MONS_SCORPION, ENT_TYPE.MONS_HORNEDLIZARD, ENT_TYPE.MONS_MOLE, ENT_TYPE.MONS_MANTRAP,
         ENT_TYPE.MONS_TIKIMAN, ENT_TYPE.MONS_MOSQUITO, ENT_TYPE.MONS_MONKEY, ENT_TYPE.MONS_MAGMAMAN,
         ENT_TYPE.MONS_ROBOT, ENT_TYPE.MONS_FIREBUG_UNCHAINED, ENT_TYPE.MONS_IMP, ENT_TYPE.MONS_VAMPIRE,
         ENT_TYPE.MONS_VLAD, ENT_TYPE.MONS_CROCMAN, ENT_TYPE.MONS_COBRA, ENT_TYPE.MONS_SORCERESS,
         ENT_TYPE.MONS_CATMUMMY, ENT_TYPE.MONS_NECROMANCER, ENT_TYPE.MONS_JIANGSHI, ENT_TYPE.MONS_FEMALE_JIANGSHI,
         ENT_TYPE.MONS_FISH, ENT_TYPE.MONS_OCTOPUS, ENT_TYPE.MONS_HERMITCRAB, ENT_TYPE.MONS_UFO, ENT_TYPE.MONS_ALIEN,
         ENT_TYPE.MONS_YETI, ENT_TYPE.MONS_PROTOSHOPKEEPER, ENT_TYPE.MONS_SHOPKEEPERCLONE, ENT_TYPE.MONS_OLMITE_HELMET,
         ENT_TYPE.MONS_OLMITE_BODYARMORED, ENT_TYPE.MONS_OLMITE_NAKED, ENT_TYPE.MONS_BEE, ENT_TYPE.MONS_AMMIT,
         ENT_TYPE.MONS_FROG, ENT_TYPE.MONS_FIREFROG, ENT_TYPE.MONS_GRUB, ENT_TYPE.MONS_TADPOLE, ENT_TYPE.MONS_JUMPDOG,
         ENT_TYPE.MONS_SCARAB, ENT_TYPE.MONS_SHOPKEEPER, ENT_TYPE.MONS_MERCHANT, ENT_TYPE.MONS_YANG,
         ENT_TYPE.MONS_SISTER_PARSLEY, ENT_TYPE.MONS_SISTER_PARSNIP, ENT_TYPE.MONS_SISTER_PARMESAN,
         ENT_TYPE.MONS_OLD_HUNTER, ENT_TYPE.MONS_THIEF, ENT_TYPE.MONS_MADAMETUSK, ENT_TYPE.MONS_BODYGUARD,
         ENT_TYPE.MONS_HUNDUNS_SERVANT, ENT_TYPE.MONS_GOLDMONKEY, ENT_TYPE.MONS_LEPRECHAUN, ENT_TYPE.MONS_MEGAJELLYFISH,
         ENT_TYPE.MONS_GHOST_SMALL_SURPRISED,
         ENT_TYPE.MONS_GHOST_SMALL_HAPPY, ENT_TYPE.MONS_CRITTERDUNGBEETLE, ENT_TYPE.MONS_CRITTERBUTTERFLY,
         ENT_TYPE.MONS_CRITTERSNAIL, ENT_TYPE.MONS_CRITTERFISH, ENT_TYPE.MONS_CRITTERCRAB, ENT_TYPE.MONS_CRITTERLOCUST,
         ENT_TYPE.MONS_CRITTERPENGUIN, ENT_TYPE.MONS_CRITTERFIREFLY, ENT_TYPE.MONS_CRITTERDRONE,
         ENT_TYPE.MONS_CRITTERSLIME, ENT_TYPE.ITEM_BOMB, ENT_TYPE.ITEM_PASTEBOMB, ENT_TYPE.ITEM_IDOL,
         ENT_TYPE.ITEM_MADAMETUSK_IDOL, ENT_TYPE.ITEM_MADAMETUSK_IDOLNOTE, ENT_TYPE.ITEM_ROCK, ENT_TYPE.ITEM_WEB,
         ENT_TYPE.ITEM_WOODEN_ARROW, ENT_TYPE.ITEM_BROKEN_ARROW, ENT_TYPE.ITEM_METAL_ARROW, ENT_TYPE.ITEM_LIGHT_ARROW,
         ENT_TYPE.ITEM_SCEPTER_ANUBISSPECIALSHOT, ENT_TYPE.ITEM_CHEST, ENT_TYPE.ITEM_VAULTCHEST, ENT_TYPE.ITEM_KEY,
         ENT_TYPE.ITEM_LOCKEDCHEST, ENT_TYPE.ITEM_LOCKEDCHEST_KEY, ENT_TYPE.ITEM_CRATE, ENT_TYPE.ITEM_BOOMBOX,
         ENT_TYPE.ITEM_TORCH, ENT_TYPE.ITEM_PRESENT, ENT_TYPE.ITEM_BROKEN_MATTOCK, ENT_TYPE.ITEM_PUNISHBALL,
         ENT_TYPE.ITEM_COFFIN, ENT_TYPE.ITEM_FLY, ENT_TYPE.ITEM_LANDMINE, ENT_TYPE.ITEM_CURSING_CLOUD,
         ENT_TYPE.ITEM_USHABTI, ENT_TYPE.ITEM_HONEY, ENT_TYPE.ITEM_DIE, ENT_TYPE.ITEM_ANUBIS_COFFIN,
         ENT_TYPE.ITEM_AXOLOTL_BUBBLESHOT, ENT_TYPE.ITEM_POTOFGOLD, ENT_TYPE.ITEM_FROZEN_LIQUID,
         ENT_TYPE.ITEM_SNAP_TRAP, ENT_TYPE.ITEM_POT, ENT_TYPE.ITEM_CURSEDPOT, ENT_TYPE.ITEM_SKULL, ENT_TYPE.ITEM_BONES,
         ENT_TYPE.ITEM_COOKFIRE, ENT_TYPE.ITEM_LAVAPOT, ENT_TYPE.ITEM_SCRAP, ENT_TYPE.ITEM_EGGPLANT,
         ENT_TYPE.ITEM_GOLDBAR, ENT_TYPE.ITEM_GOLDBARS, ENT_TYPE.ITEM_DIAMOND, ENT_TYPE.ITEM_EMERALD,
         ENT_TYPE.ITEM_SAPPHIRE, ENT_TYPE.ITEM_RUBY, ENT_TYPE.ITEM_NUGGET, ENT_TYPE.ITEM_GOLDCOIN,
         ENT_TYPE.ITEM_EMERALD_SMALL, ENT_TYPE.ITEM_SAPPHIRE_SMALL, ENT_TYPE.ITEM_RUBY_SMALL,
         ENT_TYPE.ITEM_NUGGET_SMALL, ENT_TYPE.ITEM_PICKUP_ROPE, ENT_TYPE.ITEM_PICKUP_ROPEPILE,
         ENT_TYPE.ITEM_PICKUP_BOMBBAG, ENT_TYPE.ITEM_PICKUP_BOMBBOX, ENT_TYPE.ITEM_PICKUP_ROYALJELLY,
         ENT_TYPE.ITEM_PICKUP_COOKEDTURKEY, ENT_TYPE.ITEM_PICKUP_GIANTFOOD, ENT_TYPE.ITEM_PICKUP_ELIXIR,
         ENT_TYPE.ITEM_PICKUP_CLOVER, ENT_TYPE.ITEM_PICKUP_SEEDEDRUNSUNLOCKER, ENT_TYPE.ITEM_PICKUP_SPECTACLES,
         ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES, ENT_TYPE.ITEM_PICKUP_PITCHERSMITT, ENT_TYPE.ITEM_PICKUP_SPRINGSHOES,
         ENT_TYPE.ITEM_PICKUP_SPIKESHOES, ENT_TYPE.ITEM_PICKUP_PASTE, ENT_TYPE.ITEM_PICKUP_COMPASS,
         ENT_TYPE.ITEM_PICKUP_SPECIALCOMPASS, ENT_TYPE.ITEM_PICKUP_PARACHUTE, ENT_TYPE.ITEM_PICKUP_UDJATEYE,
         ENT_TYPE.ITEM_PICKUP_KAPALA, ENT_TYPE.ITEM_PICKUP_HEDJET, ENT_TYPE.ITEM_PICKUP_CROWN,
         ENT_TYPE.ITEM_PICKUP_EGGPLANTCROWN, ENT_TYPE.ITEM_PICKUP_TRUECROWN, ENT_TYPE.ITEM_PICKUP_ANKH,
         ENT_TYPE.ITEM_PICKUP_TABLETOFDESTINY, ENT_TYPE.ITEM_PICKUP_SKELETON_KEY, ENT_TYPE.ITEM_PICKUP_PLAYERBAG,
         ENT_TYPE.ITEM_CAPE, ENT_TYPE.ITEM_VLADS_CAPE, ENT_TYPE.ITEM_JETPACK, ENT_TYPE.ITEM_TELEPORTER_BACKPACK,
         ENT_TYPE.ITEM_HOVERPACK, ENT_TYPE.ITEM_POWERPACK, ENT_TYPE.ITEM_WEBGUN, ENT_TYPE.ITEM_SHOTGUN,
         ENT_TYPE.ITEM_FREEZERAY, ENT_TYPE.ITEM_CROSSBOW, ENT_TYPE.ITEM_CAMERA, ENT_TYPE.ITEM_TELEPORTER,
         ENT_TYPE.ITEM_MATTOCK, ENT_TYPE.ITEM_BOOMERANG, ENT_TYPE.ITEM_MACHETE, ENT_TYPE.ITEM_EXCALIBUR,
         ENT_TYPE.ITEM_BROKENEXCALIBUR, ENT_TYPE.ITEM_PLASMACANNON, ENT_TYPE.ITEM_SCEPTER, ENT_TYPE.ITEM_CLONEGUN,
         ENT_TYPE.ITEM_HOUYIBOW, ENT_TYPE.ITEM_WOODEN_SHIELD, ENT_TYPE.ITEM_METAL_SHIELD, ENT_TYPE.ACTIVEFLOOR_BOULDER,
         ENT_TYPE.ACTIVEFLOOR_PUSHBLOCK, ENT_TYPE.ACTIVEFLOOR_POWDERKEG, ENT_TYPE.ACTIVEFLOOR_CRUSH_TRAP,
         ENT_TYPE.ACTIVEFLOOR_ELEVATOR, ENT_TYPE.FX_EXPLOSION, ENT_TYPE.FX_POWEREDEXPLOSION, ENT_TYPE.MOUNT_TURKEY,
         ENT_TYPE.MOUNT_ROCKDOG, ENT_TYPE.MOUNT_AXOLOTL}
tools = {ENT_TYPE.ITEM_LIGHT_ARROW, ENT_TYPE.ITEM_PRESENT, ENT_TYPE.ITEM_PICKUP_BOMBBOX,
         ENT_TYPE.ITEM_PICKUP_ROYALJELLY, ENT_TYPE.ITEM_PICKUP_COOKEDTURKEY, ENT_TYPE.ITEM_PICKUP_GIANTFOOD,
         ENT_TYPE.ITEM_PICKUP_ELIXIR, ENT_TYPE.ITEM_PICKUP_CLOVER, ENT_TYPE.ITEM_PICKUP_SPECTACLES,
         ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES, ENT_TYPE.ITEM_PICKUP_PITCHERSMITT, ENT_TYPE.ITEM_PICKUP_SPRINGSHOES,
         ENT_TYPE.ITEM_PICKUP_SPIKESHOES, ENT_TYPE.ITEM_PICKUP_PASTE, ENT_TYPE.ITEM_PICKUP_COMPASS,
         ENT_TYPE.ITEM_PICKUP_SPECIALCOMPASS, ENT_TYPE.ITEM_PICKUP_PARACHUTE, ENT_TYPE.ITEM_PICKUP_UDJATEYE,
         ENT_TYPE.ITEM_PICKUP_KAPALA, ENT_TYPE.ITEM_PICKUP_HEDJET, ENT_TYPE.ITEM_PICKUP_CROWN,
         ENT_TYPE.ITEM_PICKUP_EGGPLANTCROWN, ENT_TYPE.ITEM_PICKUP_TRUECROWN, ENT_TYPE.ITEM_PICKUP_ANKH,
         ENT_TYPE.ITEM_PICKUP_SKELETON_KEY, ENT_TYPE.ITEM_PICKUP_PLAYERBAG, ENT_TYPE.ITEM_CAPE,
         ENT_TYPE.ITEM_VLADS_CAPE, ENT_TYPE.ITEM_JETPACK, ENT_TYPE.ITEM_TELEPORTER_BACKPACK, ENT_TYPE.ITEM_HOVERPACK,
         ENT_TYPE.ITEM_POWERPACK, ENT_TYPE.ITEM_WEBGUN, ENT_TYPE.ITEM_SHOTGUN, ENT_TYPE.ITEM_FREEZERAY,
         ENT_TYPE.ITEM_CROSSBOW, ENT_TYPE.ITEM_CAMERA, ENT_TYPE.ITEM_TELEPORTER, ENT_TYPE.ITEM_MATTOCK,
         ENT_TYPE.ITEM_BOOMERANG, ENT_TYPE.ITEM_MACHETE, ENT_TYPE.ITEM_EXCALIBUR, ENT_TYPE.ITEM_BROKENEXCALIBUR,
         ENT_TYPE.ITEM_PLASMACANNON, ENT_TYPE.ITEM_SCEPTER, ENT_TYPE.ITEM_CLONEGUN, ENT_TYPE.ITEM_HOUYIBOW,
         ENT_TYPE.ITEM_METAL_SHIELD}
pot_done = {}

function pot_replaced(id)
    for i, v in pairs(pot_done) do
        if v == id then
            return true
        end
    end
    return false
end

function module.start()
    pot_cbs[#pot_cbs+1] = set_callback(function()
        pot_done = {}

        set_interval(function()
            if #players < 1 then
                return
            end
            x, y, l = get_position(players[1].uid)
            -- randomize pots
            pots = get_entities_at(ENT_TYPE.ITEM_POT, 0, x, y, l, 10)
            for i, v in ipairs(pots) do
                if not pot_replaced(v) then
                    item = items[math.random(#items)]
                    e = get_entity(v):as_container()
                    e.inside = item
                end
                pot_done[#pot_done + 1] = v
            end

            -- randomize crates
            crates = get_entities_at(ENT_TYPE.ITEM_CRATE, 0, x, y, l, 10)
            for i, v in ipairs(crates) do
                if not pot_replaced(v) then
                    item = tools[math.random(#tools)]
                    e = get_entity(v):as_container()
                    e.inside = item
                end
                pot_done[#pot_done + 1] = v
            end

            -- randomize coffins
            coffins = get_entities_at(ENT_TYPE.ITEM_COFFIN, 0, x, y, l, 10)
            for i, v in ipairs(coffins) do
                if not pot_replaced(v) then
                    item = math.random(ENT_TYPE.CHAR_ANA_SPELUNKY, ENT_TYPE.CHAR_EGGPLANT_CHILD)
                    if item == ENT_TYPE.CHAR_CLASSIC_GUY + 1 then
                        item = ENT_TYPE.CHAR_HIREDHAND
                    end
                    e = get_entity(v):as_container()
                    e.inside = item
                end
                pot_done[#pot_done + 1] = v
            end
        end, 30)
    end, ON.LEVEL)
end

function module.stop()
    for i,v in ipairs(pot_cbs) do
        clear_callback(v)
    end
    pot_cbs = {}
end

return module
