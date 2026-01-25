G.COINS = new_arbituary_image("drut/coins.png");
G.UT_SPRITES = {
    love.graphics.newQuad(0, 0, 34, 34, 714, 170),
    love.graphics.newQuad(0, 34, 34, 34, 714, 170),
    love.graphics.newQuad(0, 68, 34, 34, 714, 170),
    love.graphics.newQuad(0, 102, 34, 34, 714, 170),
    love.graphics.newQuad(0, 136, 34, 34, 714, 170),
}

G.UT_SOUNDS = {
    welcome = new_arbituary_sound("drut/sounds/welcome.ogg", true),
    loveit = new_arbituary_sound("drut/sounds/loveit.ogg", true),
    wakeup = new_arbituary_sound("drut/sounds/wakeup.ogg", true),
    tone1 = new_arbituary_sound("drut/sounds/tone1.ogg", true),
    tone2 = new_arbituary_sound("drut/sounds/tone2.ogg", true),
    tone3 = new_arbituary_sound("drut/sounds/tone3.ogg", true),
    tone4 = new_arbituary_sound("drut/sounds/tone4.ogg", true),
    tone5 = new_arbituary_sound("drut/sounds/tone5.ogg", true),
    tone6 = new_arbituary_sound("drut/sounds/tone6.ogg", true),
    tone7 = new_arbituary_sound("drut/sounds/tone7.ogg", true),
    tone8 = new_arbituary_sound("drut/sounds/tone8.ogg", true),
    tone9 = new_arbituary_sound("drut/sounds/tone9.ogg", true),
}

function playSoundish(soundName)
    local sound = G.UT_SOUNDS[soundName];
    if not (sound) then return; end

    sound:setVolume((G.SETTINGS.SOUND.game_sounds_volume / 100) * (G.SETTINGS.SOUND.volume / 100));
    sound:play();
end

G.UT_WIDTH = 11;

local down = false;
local clicked = false;
local oldT = 6.986;

G.ut_end = function(loss)
    G.GAME.big_money = false;
    G.GAME.ut_toAdd = 0;

    if (G.hand) then
        G.hand.T.y = oldT or 6.986;
    end

    --Make the chips explode
    G.GAME.ut_vanish = 10.0;
    for y = 0,11,1 do
        for x = 0,G.GAME.ut_widthS,1 do
            local tile = G.GAME.ut_tilemap[(y * G.GAME.ut_width + x) + 1];
            if (tile > 0) then
                if (pseudorandom("big_money") > 0.5) then
                    table.insert(G.GAME.ut_flyingChips, {
                        vx = math.max(0.2, pseudorandom("big_money")) * 5,
                        vy = 5 + (pseudorandom("big_money") * 5),
                        x = x,
                        y = y,
                        spr = tile
                    });
                else
                    table.insert(G.GAME.ut_flyingChips, {
                        vx = math.max(0.2, pseudorandom("big_money")) * -5,
                        vy = 5 + (pseudorandom("big_money") * 5),
                        x = x,
                        y = y,
                        spr = tile
                    });
                end
            end
        end
    end

    G.GAME.ut_tilemap = nil;

    if (loss) then playSoundish("wakeup");
    else playSoundish("loveit"); end
    
    G.STATE = G.STATES.HAND_PLAYED
    G.STATE_COMPLETE = true
    end_round()
end

G.ut_update = function(dt)
    if (G.GAME.big_money) then
        for i, quad in pairs(G.UT_SPRITES) do
            x, y, w, h = quad:getViewport( )
            quad:setViewport(math.floor(((love.timer.getTime() / 2) % 1) * 21) * 34, y, w, h);
        end

        G.STATE = G.STATES.HAND_PLAYED;
        if not G.GAME.ut_tilemap then
            G.GAME.ut_tilemap = {};
            G.GAME.ut_offsetMap = {};
            G.GAME.ut_velocityMap = {};
            G.GAME.ut_horizMap = {};
            G.GAME.ut_bottomrow = {};
            G.GAME.ut_flyingChips = {};
            G.GAME.ut_width = G.UT_WIDTH;
            G.GAME.ut_widthS = G.GAME.ut_width - 1;
            G.GAME.ut_toAdd = 0;
            G.GAME.ut_slide = 0;
            G.GAME.ut_vanish = 0;

            playSoundish("welcome");

            for y = 0,11,1 do
                for x = 0,G.GAME.ut_widthS,1 do
                    if (y < 6) then table.insert(G.GAME.ut_tilemap, math.floor(pseudorandom("big_money") * 5) + 1);
                    else table.insert(G.GAME.ut_tilemap, 0) end;

                    table.insert(G.GAME.ut_offsetMap, 0);
                    table.insert(G.GAME.ut_velocityMap, 0);
                    table.insert(G.GAME.ut_horizMap, 0);
                end
            end

            for x = 0,G.GAME.ut_widthS,1 do
                table.insert(G.GAME.ut_bottomrow, math.floor(pseudorandom("big_money") * 5) + 1);
            end

            if (G.hand) then
                oldT = G.hand.T.y;
            end

            G.GAME.SELECTED = -1;
            G.GAME.NEIGHBORING = {};
        end

        clicked = (not down) and (love.mouse.isDown(1));
        down = love.mouse.isDown(1);

        --Animate parts
        for y = 11,0,-1 do
            for x = 0,G.GAME.ut_widthS,1 do
                local tileID = (y * G.GAME.ut_width + x) + 1;
                local tile = G.GAME.ut_tilemap[tileID];
                if (tile > 0) then
                    G.GAME.ut_offsetMap[tileID] = G.GAME.ut_offsetMap[tileID] + (G.GAME.ut_velocityMap[tileID] * dt);
                    G.GAME.ut_horizMap[tileID] = G.GAME.ut_horizMap[tileID] * (0.8 ^ (30 * dt));
                    if (G.GAME.ut_offsetMap[tileID] > 0) then
                        G.GAME.ut_velocityMap[tileID] = G.GAME.ut_velocityMap[tileID] - (dt * 18);
                    else
                        if (G.GAME.ut_offsetMap[tileID] < -1) then G.GAME.ut_offsetMap[tileID] = -1 end

                        if (G.GAME.ut_offsetMap[tileID] < 0) then 
                            G.GAME.ut_offsetMap[tileID] = G.GAME.ut_offsetMap[tileID] + (dt); 
                            if (G.GAME.ut_offsetMap[tileID] > 0) then G.GAME.ut_offsetMap[tileID] = 0; end
                        end
                        G.GAME.ut_velocityMap[tileID] = G.GAME.ut_velocityMap[tileID] / -2;
                    end

                end
            end
        end

        if (G.GAME.ut_toAdd > 0) then
            local toAdd = G.GAME.ut_toAdd;
            if (toAdd > 50000) then
                G.GAME.chips = G.GAME.chips + 10000;
                G.GAME.ut_toAdd = G.GAME.ut_toAdd - 10000;
            elseif (toAdd > 5000) then
                G.GAME.chips = G.GAME.chips + 1000;
                G.GAME.ut_toAdd = G.GAME.ut_toAdd - 1000;
            elseif (toAdd > 500) then
                G.GAME.chips = G.GAME.chips + 100;
                G.GAME.ut_toAdd = G.GAME.ut_toAdd - 100;
            elseif (toAdd > 50) then
                G.GAME.chips = G.GAME.chips + 10;
                G.GAME.ut_toAdd = G.GAME.ut_toAdd - 10;
            else
                G.GAME.chips = G.GAME.chips + 1;
                G.GAME.ut_toAdd = G.GAME.ut_toAdd - 1;
            end
        end

        if (G.hand) then
            G.hand.T.y = 10000;
        end

        if (G.GAME.chips >= G.GAME.blind.chips) then
            G.ut_end();
        end

        if (not G.OVERLAY_MENU) then
            if (G.GAME.ut_action) then
                G.GAME.ut_slide = G.GAME.ut_slide + (dt / 8);
            else
                G.GAME.ut_slide = G.GAME.ut_slide + (dt / 24);
            end
        end

        --Add incoming when time
        if (G.GAME.ut_slide >= 1) then
            for y = 11,0,-1 do
                for x = 0,G.GAME.ut_widthS,1 do
                    local tileID = (y * G.GAME.ut_width + x) + 1;
                    if (G.GAME.ut_tilemap[tileID] == 0) then G.GAME.ut_offsetMap[tileID] = 0; end
                    G.GAME.ut_offsetMap[tileID] = G.GAME.ut_offsetMap[tileID] - 1;
                end
            end

            for x = G.GAME.ut_width,1,-1 do
                table.insert(G.GAME.ut_tilemap, 1, G.GAME.ut_bottomrow[x]);
            end

            for y = 11,0,-1 do
                for x = 0,G.GAME.ut_widthS,1 do
                    local tileID = (y * G.GAME.ut_width + x) + 1;
                    local prev = tileID - G.GAME.ut_width;

                    if (y > 0) then
                        if (G.GAME.ut_tilemap[tileID] > 0) then 
                            G.GAME.ut_offsetMap[tileID] = G.GAME.ut_offsetMap[prev]; 
                            G.GAME.ut_velocityMap[tileID] = G.GAME.ut_velocityMap[prev]; 
                            G.GAME.ut_horizMap[tileID] = G.GAME.ut_horizMap[prev]; 
                        end
                    else
                        G.GAME.ut_offsetMap[tileID] = -1
                        G.GAME.ut_velocityMap[tileID] = 0
                        G.GAME.ut_horizMap[tileID] = 0
                    end
                end
            end

            --Probably really bad code but I'm too tired to think of anything else.
            G.GAME.ut_bottomrow = {};
            for x = 0,G.GAME.ut_widthS,1 do
                table.insert(G.GAME.ut_bottomrow, math.floor(pseudorandom("big_money") * 5) + 1);
            end

            --Check top row
            for x = 0,G.GAME.ut_widthS,1 do
                if (G.GAME.ut_tilemap[x + (G.GAME.ut_widthS * 11) + 1] > 0) then
                    G.ut_end(true);
                    return;
                end;
            end

            --Delete top row
            for x = 0,G.GAME.ut_widthS,1 do
                table.remove(G.GAME.ut_tilemap, x + (G.GAME.ut_widthS * 11) + 1);
            end

            G.GAME.ut_slide = 0;
        end
    else
        if (G.GAME.ut_flyingChips) then
            for i, v in pairs(G.GAME.ut_flyingChips) do
                G.GAME.ut_flyingChips[i].x = v.x + (v.vx * dt)

                G.GAME.ut_flyingChips[i].vy = G.GAME.ut_flyingChips[i].vy - (18 * dt);
                G.GAME.ut_flyingChips[i].y = v.y + (v.vy * dt)
                if (G.GAME.ut_flyingChips[i].y < 0) then
                    G.GAME.ut_flyingChips[i].y = 0;
                    G.GAME.ut_flyingChips[i].vy = G.GAME.ut_flyingChips[i].vy / -1.05;
                end
            end

            G.GAME.ut_vanish = G.GAME.ut_vanish - dt;
        end
    end
end

G.ut_scan_tilemap = function(x, y, target)
    local tileID = (y * G.GAME.ut_width) + x + 1;
    if (G.GAME.NEIGHBORING[tileID]) then return; end
    if (x < 0 or x > G.GAME.ut_widthS) or (y < 0 or y > G.GAME.ut_widthS) then return; end

    local tile = G.GAME.ut_tilemap[tileID];
    if (tile > 0) and (tile == target) then
        G.GAME.NEIGHBORING[tileID] = true;

        G.ut_scan_tilemap(x - 1, y, target);
        G.ut_scan_tilemap(x + 1, y, target);
        G.ut_scan_tilemap(x, y - 1, target);
        G.ut_scan_tilemap(x, y + 1, target);
    end
end

G.ut_apply_gravity = function()
    for y = 1,11,1 do
        for x = 0,G.GAME.ut_widthS,1 do
            local tileID = (y * G.GAME.ut_width) + x + 1;
            local tile = G.GAME.ut_tilemap[tileID];
            local bTile = G.GAME.ut_tilemap[tileID - G.GAME.ut_width];
            if (bTile == 0) then
                local fallenDist = 0;

                G.GAME.ut_tilemap[tileID] = 0;

                while (bTile == 0) and (tileID > G.GAME.ut_width) do
                    fallenDist = fallenDist + 1;
                    tileID = tileID - G.GAME.ut_width;
                    bTile = G.GAME.ut_tilemap[tileID - G.GAME.ut_width];
                end

                G.GAME.ut_offsetMap[tileID] = fallenDist;
                G.GAME.ut_velocityMap[tileID] = 0;
                G.GAME.ut_tilemap[tileID] = tile;
            end
        end
    end
    
    --Push
    for x = G.GAME.ut_widthS - 1,0,-1 do
        local tileID = x + 1;
        if (G.GAME.ut_tilemap[tileID + 1] == 0) then
            for y = 0,11,1 do
                tileID = (y * G.GAME.ut_width) + x + 1;
                local tile = G.GAME.ut_tilemap[tileID];

                G.GAME.ut_tilemap[tileID] = 0;

                tileID = tileID + 1;
                G.GAME.ut_tilemap[tileID] = tile;
                G.GAME.ut_offsetMap[tileID] = G.GAME.ut_offsetMap[tileID - 1];
                G.GAME.ut_velocityMap[tileID] = G.GAME.ut_velocityMap[tileID - 1];
                G.GAME.ut_horizMap[tileID] = G.GAME.ut_horizMap[tileID - 1] - 1;
            end
        end

        tileID = (G.GAME.ut_widthS - x) + 1;
        if (G.GAME.ut_tilemap[tileID - 1] == 0) then
            for y = 0,11,1 do
                tileID = (y * G.GAME.ut_width) + (G.GAME.ut_widthS - x) + 1;
                local tile = G.GAME.ut_tilemap[tileID];

                G.GAME.ut_tilemap[tileID] = 0;

                tileID = tileID - 1;
                G.GAME.ut_tilemap[tileID] = tile;
                G.GAME.ut_offsetMap[tileID] = G.GAME.ut_offsetMap[tileID + 1];
                G.GAME.ut_velocityMap[tileID] = G.GAME.ut_velocityMap[tileID + 1];
                G.GAME.ut_horizMap[tileID] = G.GAME.ut_horizMap[tileID + 1] + 1;
            end
        end
    end
end

G.ut_draw = function()
    local width, height, flags = love.window.getMode();
    local widthMul = width / 640;
    local heightMul = height / 480;

    local finalMul = widthMul;

    if (widthMul > heightMul) then finalMul = heightMul; end
    
    local ox = G.ARGS.eased_cursor_pos.x * finalMul * 2;
    local oy = G.ARGS.eased_cursor_pos.y * finalMul * 2;

    if (G.GAME.big_money) then
        love.graphics.setColor(1, 1, 1, 1);
        
        local mx = love.mouse.getX();
        local my = love.mouse.getY();

        local stepMul = 34 * finalMul;
        local horizontalOffset = (width / 2) - (stepMul * G.GAME.ut_width / 2) + ox;
        local verticalOffset = height - (stepMul * 2) + oy;

        local hovered = false;

        love.graphics.setColor(0.225, 0.25, 0.25, 0.25);
        love.graphics.rectangle("fill",horizontalOffset, verticalOffset - (9 * stepMul), stepMul * G.GAME.ut_width, 10 * stepMul)
        love.graphics.setColor(0.725, 0.55, 0.25, 0.25);
        love.graphics.rectangle("fill",horizontalOffset, verticalOffset + stepMul, stepMul * G.GAME.ut_width, 0.2 * stepMul)
        love.graphics.setColor(0.225, 0.25, 0.25, 0.25);
        love.graphics.rectangle("fill",horizontalOffset, verticalOffset + (1.2 * stepMul), stepMul * G.GAME.ut_width, 2 * stepMul)
        love.graphics.setColor(1, 1, 1, 1);

        --Draw main tilemap
        for y = 11,0,-1 do
            for x = 0,G.GAME.ut_widthS,1 do
                local tileID = (y * G.GAME.ut_width + x) + 1;
                local tile = G.GAME.ut_tilemap[tileID];
                if (tile > 0) then
                    local sx = ((x + G.GAME.ut_horizMap[tileID]) * stepMul) + horizontalOffset;
                    local sy = (((y + G.GAME.ut_offsetMap[tileID]) * stepMul) * -1) + verticalOffset;

                    love.graphics.draw(G.COINS, G.UT_SPRITES[tile], sx, sy, 0, finalMul, finalMul);
                    if (mx > sx and mx < sx + stepMul) and (my > sy and my < sy + stepMul) then
                        hovered = true;
                        if (G.GAME.SELECTED ~= tileID) then
                            G.GAME.NEIGHBORING = {};
                            G.ut_scan_tilemap(x, y, tile);
                        end
                        G.GAME.SELECTED = tileID;
                    end
                end
            end
        end

        --Draw incoming
        for x = 0,G.GAME.ut_widthS,1 do
            local tileID = x + 1;
            local tile = G.GAME.ut_bottomrow[tileID];
            if (tile > 0) then
                local sx = (x * stepMul) + horizontalOffset;
                local sy = verticalOffset - (G.GAME.ut_slide * stepMul) + (stepMul * 2);

                love.graphics.draw(G.COINS, G.UT_SPRITES[tile], sx, sy, 0, finalMul, finalMul);
            end
        end

        if (not hovered) then
            G.GAME.selected = -1;
            G.GAME.NEIGHBORING = {};
        end


        --Quick and dirty.
        local count = 0;
        for i, v in pairs(G.GAME.NEIGHBORING) do count = count + 1; end

        if (count >= 3 and not G.OVERLAY_MENU) then
            local mode, alphamode = love.graphics.getBlendMode();

            for i, v in pairs(G.GAME.NEIGHBORING) do
                local x = (i - 1) % G.GAME.ut_width;
                local y = math.floor((i - 1) / G.GAME.ut_width);

                local tileID = (y * G.GAME.ut_width + x) + 1;
                local tile = G.GAME.ut_tilemap[tileID];

                local sx = ((x + G.GAME.ut_horizMap[tileID]) * stepMul) + horizontalOffset;
                local sy = (((y + G.GAME.ut_offsetMap[tileID]) * stepMul) * -1) + verticalOffset;
                
                love.graphics.setColor(1, 1, 1, 0.25);
                love.graphics.setBlendMode("add", "premultiplied")
                love.graphics.draw(G.COINS, G.UT_SPRITES[tile], sx, sy, 0, finalMul, finalMul);
                love.graphics.setColor(1, 1, 1, 1);
            end

            love.graphics.setBlendMode(mode, alphamode);

            if (clicked) then
                for i, v in pairs(G.GAME.NEIGHBORING) do
                    local x = (i - 1) % G.GAME.ut_width;
                    local y = math.floor((i - 1) / G.GAME.ut_width);
                    G.GAME.ut_toAdd = G.GAME.ut_toAdd + (10 ^ (0.75 + (getAnte() / 4)));

                    G.GAME.ut_tilemap[(y * G.GAME.ut_width) + x + 1] = 0;
                end

                if not (G.GAME.ut_action) then G.GAME.ut_slide = G.GAME.ut_slide + 0.25; end

                playSoundish("tone".. math.min(count - 2, 9));

                G.GAME.SELECTED = -1;
                G.GAME.NEIGHBORING = {};
                G.ut_apply_gravity();
            end
        end
    else
        if (G.GAME.ut_flyingChips) then
            if (G.GAME.ut_vanish <= 0) then
                G.GAME.ut_flyingChips = {};
                return;
            end

            love.graphics.setColor(1, 1, 1, math.min(G.GAME.ut_vanish / 2, 1));

            local stepMul = 34 * finalMul;
            local horizontalOffset = (width / 2) - (stepMul * G.GAME.ut_width / 2) + ox;
            local verticalOffset = height - (stepMul * 2) + oy;

            for i, v in pairs(G.GAME.ut_flyingChips) do
                local sx = (v.x * stepMul) + horizontalOffset;
                local sy = (v.y * stepMul * -1) + verticalOffset;

                love.graphics.draw(G.COINS, G.UT_SPRITES[v.spr], sx, sy, 0, finalMul, finalMul);
            end

            love.graphics.setColor(1, 1, 1, 1);
        end
    end
end