local boxSize = {
    x = 544,
    y = 140,

    targetX = 544,
    targetY = 140,

    speed = 75
}

function get_box_bounds()
    local width = (boxSize.x / 2);
    local height = (boxSize.y / 2);
    local y = 319 - math.max(0, height - 140);

    return 320 - width, y - height, 320 + width, y + height;
end

G.UT_IMAGES = {
    soul = new_arbituary_image("drut/soul.png"),
    battleOpt = new_arbituary_image("drut/battleOpts.png"),
    
    testEnemy = new_arbituary_image("drut/enemy_test.png"),
    battleThing = new_arbituary_image("drut/johnAttack.png"),
    battleBar = new_arbituary_image("drut/attackBar.png")
}

G.UT_SOUNDS = {
    switch = new_arbituary_sound("drut/sounds/menuSwitch.ogg", true),
    use = new_arbituary_sound("drut/sounds/menuUse.ogg", true),
}

G.UT_MUSIC = {
    anticipation = new_arbituary_sound("drut/music/anticipation.ogg", true, true),
}

G.UT_FONTS = {
    TBTD = new_arbituary_font("drut/fonts/TroubleBeneathTheDome.ttf", 24, "mono"),
    DETERMINATION = new_arbituary_font("drut/fonts/DTM-Sans.ttf", 24, "mono"),
    DETERMINATION_MONO = new_arbituary_font("drut/fonts/DTM-Mono.ttf", 24, "mono")
}

local projectiles = {};

function new_enemy(data)
    local ent = {
        attacks = {},
        actOptions = {
            {
                text = "Yup, that's an act",
                mercy = 1
            },
            {
                text = "2, but overlap",
                mercy = 1
            },
            {
                text = "3, but overlap",
                mercy = 1
            }
        },
        
        health = 0,
        maxHealth = 0,
        
        atkShake = 0,
        sparePercentage = 0,

        initialText = "",
        name = "Enemy mc enemy"
    };

    for key, val in pairs(data) do
        ent[key] = val;
    end

    if (ent.health > ent.maxHealth) then
        ent.maxHealth = ent.health;
    end

    return ent;
end

G.UT_ENEMIES = {
    --TEST
    new_enemy({
        spr = G.UT_IMAGES.testEnemy,
        attacks = {
            {
                wantedWidth = 140,
                wantedHeight = 140,
                initilize = function(attack, dt)
                    
                end,

                update = function(attack, dt)
                    
                end
            }
        },

        --actOptions = {},
        
        health = 10,

        initialText = "* He's here!",
        name = "Testy mc Test Face"
    })
}

function inst_enemy(enemyID)
    local enemy = G.UT_ENEMIES[enemyID];
    local created = {};

    for key, value in pairs(enemy) do
        created[key] = value;
    end

    return created;
end

local utCanvas = love.graphics.newCanvas(640, 480);
local currentSong = nil;
local activeEnemies = {
    inst_enemy(1),
    inst_enemy(1)
};

function playSoundish(soundName)
    local sound = G.UT_SOUNDS[soundName];
    if not (sound) then return; end

    sound:setVolume((G.SETTINGS.SOUND.game_sounds_volume / 100) * (G.SETTINGS.SOUND.volume / 100));
    sound:play();
end

local soul = {
    x = 0,
    y = 0,
    mode = 1,
    introAnimation = 0,

    quad = love.graphics.newQuad(0, 0, 20, 20, 140, 20),

    fight = love.graphics.newQuad(112, 0, 112, 44, 224, 176),
    act = love.graphics.newQuad(0, 44, 112, 44, 224, 176),
    item = love.graphics.newQuad(0, 88, 112, 44, 224, 176),
    mercy = love.graphics.newQuad(0, 132, 112, 44, 224, 176),

    order = {
        "fight",
        "act",
        "item",
        "mercy"
    },

    leftHeld = false,
    rightHeld = false,
    selectHeld = false,

    menuOpt = 0,
    menu = "",
    inBox = false
};

soul.toggle_opt = function(optID, on)
    local _x, y, w, h = soul[soul.order[optID]]:getViewport();

    if (on) then soul[soul.order[optID]]:setViewport(112, y, w, h);
    else soul[soul.order[optID]]:setViewport(0, y, w, h); end
end

soul.OOB_mode = function(dt)
    if (soul.menu == "") then
        if (love.keyboard.isDown("left") and not soul.leftHeld) then 
            soul.toggle_opt(soul.menuOpt + 1, false);
            soul.menuOpt = soul.menuOpt - 1;

            soul.menuOpt = soul.menuOpt % 4;
            soul.toggle_opt(soul.menuOpt + 1, true);
            playSoundish("switch");
        end
        
        if (love.keyboard.isDown("right") and not soul.rightHeld) then 
            soul.toggle_opt(soul.menuOpt + 1, false);
            soul.menuOpt = soul.menuOpt + 1;
            
            soul.menuOpt = soul.menuOpt % 4;
            soul.toggle_opt(soul.menuOpt + 1, true);
            playSoundish("switch");
        end

        if (love.keyboard.isDown("z") and not soul.selectHeld) then
            if (G.UT_MENUS[soul.order[soul.menuOpt + 1]]) then
                playSoundish("use");
                soul.menu = soul.order[soul.menuOpt + 1];

                G.UT_MENUS[soul.menu].init(G.UT_MENUS[soul.menu]);
                soul.toggle_opt(soul.menuOpt + 1, false);
            end
        end

        soul.x = 52 + (146 * soul.menuOpt)
        soul.y = 438;
    else
        G.UT_MENUS[soul.menu].update(G.UT_MENUS[soul.menu], dt);
    end

    soul.leftHeld = love.keyboard.isDown("left");
    soul.rightHeld = love.keyboard.isDown("right");
    soul.upHeld = love.keyboard.isDown("up");
    soul.downHeld = love.keyboard.isDown("down");
    soul.selectHeld = love.keyboard.isDown("z");
    soul.cancelHeld = love.keyboard.isDown("x");
end

soul.collide = function()
    local left, top, right, bottom = get_box_bounds();
    if (soul.x < left) then soul.x = left;
    elseif ((soul.x + 20) > right) then soul.x = right - 20; end
    
    if (soul.y < top) then soul.y = top;
    elseif ((soul.y + 20) > bottom) then soul.y = bottom - 20; end
end

soul.modes = {
    --Red
    function(dt)
        local speed = 100;
        if (love.keyboard.isDown("x")) then speed = 50; end


        speed = speed * dt;
        if (love.keyboard.isDown("up")) then soul.y = soul.y - speed; end
        if (love.keyboard.isDown("down")) then soul.y = soul.y + speed; end
        if (love.keyboard.isDown("left")) then soul.x = soul.x - speed; end
        if (love.keyboard.isDown("right")) then soul.x = soul.x + speed; end

        soul.collide();
    end
}

G.UT_MENUS = {
    fight = {
        time = 0,
        target = 0,
        subMenu = false,

        init = function(self)
            self.time = -1;
            self.target = 0;
            self.subMenu = false;
        end,
        
        update = function(self, dt)
            if (self.subMenu) then
                boxSize.targetX = 560;

                self.time = self.time + dt;
                soul.x = -1000;
                soul.y = -1000;

                if (self.time >= 1) then
                    soul.inBox = true;
                    soul.x = 310;
                    soul.y = 309;
                end

                if (love.keyboard.isDown("z") and not soul.selectHeld) then
                    activeEnemies[self.target + 1].health = activeEnemies[self.target + 1].health - (10 * (1 - math.abs(self.time)));
                    activeEnemies[self.target + 1].atkShake = 3;

                    soul.inBox = true;
                    soul.x = 310;
                    soul.y = 309;
                end
            else
                soul.x = 60;
                soul.y = 272 + (self.target * 25);

                if (love.keyboard.isDown("down") and not soul.downHeld) then 
                    self.target = self.target + 1;

                    if (self.target > #activeEnemies - 1) then
                        self.target = #activeEnemies - 1;
                    else
                        playSoundish("switch");
                    end
                end

                if (love.keyboard.isDown("up") and not soul.upHeld) then 
                    self.target = self.target - 1;

                    if (self.target < 0) then
                        self.target = 0;
                    else
                        playSoundish("switch");
                    end
                end

                if (love.keyboard.isDown("x") and not soul.cancelHeld) then
                    soul.menu = "";
                    soul.toggle_opt(soul.menuOpt + 1, true);
                end

                if (love.keyboard.isDown("z") and not soul.selectHeld) then
                    self.subMenu = true;
                    playSoundish("use");
                end
            end
        end,

        draw = function(self)
            if (self.subMenu) then
                love.graphics.draw(G.UT_IMAGES.battleThing, 47, 255);
                love.graphics.draw(G.UT_IMAGES.battleBar, (self.time * boxSize.x / 2) + 320, 255);
            else
                for id, ent in pairs(activeEnemies) do
                    love.graphics.print(" * ".. ent.name, 80, 267 + ((id - 1) * 25), 0);

                    love.graphics.setColor( 1, 0, 0, 1 );
                    love.graphics.rectangle( "fill", 420, 276 + ((id - 1) * 25), 100, 16);

                    love.graphics.setColor( 0, 1, 0, 1 );
                    love.graphics.rectangle( "fill", 420, 276 + ((id - 1) * 25), (ent.health / ent.maxHealth) * 100, 16);

                    love.graphics.setColor( 1, 1, 1, 1 );
                end
            end
        end
    },

    act = {
        time = 0,
        target = 0,
        subMenu = false,

        init = function(self)
            self.time = -1;
            self.target = 0;
            self.actOption = 0;
            self.subMenu = false;
        end,
        
        update = function(self, dt)
            if (self.subMenu) then
                soul.x = 60 + ((self.actOption % 2) * 232);
                soul.y = 272 + (math.floor(self.actOption / 2) * 25);
                
                local actOptions = activeEnemies[self.target + 1].actOptions;

                if (love.keyboard.isDown("down") and not soul.downHeld) then 
                    self.actOption = self.actOption + 2;

                    if (self.actOption > #actOptions - 1) then
                        self.actOption = #actOptions - 1;
                    else
                        playSoundish("switch");
                    end
                end

                if (love.keyboard.isDown("left") and not soul.leftHeld) then 
                    if (self.actOption % 2 == 1) then
                        self.actOption = self.actOption - 1;
                        if (self.actOption < 0) then
                            self.actOption = 0;
                        else
                            playSoundish("switch");
                        end
                    end
                end

                if (love.keyboard.isDown("right") and not soul.rightHeld) then 

                    if (self.actOption % 2 == 0) then
                        self.actOption = self.actOption + 1;
                        if (self.actOption > #actOptions - 1) then
                            self.actOption = #actOptions - 1;
                        else
                            playSoundish("switch");
                        end
                    end
                end

                if (love.keyboard.isDown("up") and not soul.upHeld) then 
                    self.actOption = self.actOption - 2;

                    if (self.actOption < 0) then
                        self.actOption = 0;
                    else
                        playSoundish("switch");
                    end
                end

                if (love.keyboard.isDown("x") and not soul.cancelHeld) then
                    self.subMenu = false;
                end

                if (love.keyboard.isDown("z") and not soul.selectHeld) then
                    playSoundish("use");
                    activeEnemies[self.target + 1].sparePercentage = activeEnemies[self.target + 1].sparePercentage + actOptions[self.actOption + 1].mercy;
                    
                    soul.inBox = true;
                    soul.x = 310;
                    soul.y = 309;
                end
            else
                soul.x = 60;
                soul.y = 272 + (self.target * 25);

                if (love.keyboard.isDown("down") and not soul.downHeld) then 
                    self.target = self.target + 1;

                    if (self.target > #activeEnemies - 1) then
                        self.target = #activeEnemies - 1;
                    else
                        playSoundish("switch");
                    end
                end

                if (love.keyboard.isDown("up") and not soul.upHeld) then 
                    self.target = self.target - 1;

                    if (self.target < 0) then
                        self.target = 0;
                    else
                        playSoundish("switch");
                    end
                end

                if (love.keyboard.isDown("x") and not soul.cancelHeld) then
                    soul.menu = "";
                    soul.toggle_opt(soul.menuOpt + 1, true);
                end

                if (love.keyboard.isDown("z") and not soul.selectHeld) then
                    self.subMenu = true;
                    playSoundish("use");
                end
            end
        end,

        draw = function(self)
            if (self.subMenu) then
                for id, action in pairs(activeEnemies[self.target + 1].actOptions) do
                    love.graphics.print(" * ".. action.text, 80 + ((id - 1) % 2 * 232), 267 + (math.floor((id - 1) / 2) * 25), 0);
                end
            else
                for id, ent in pairs(activeEnemies) do
                    love.graphics.print(" * ".. ent.name, 80, 267 + ((id - 1) * 25), 0);

                    love.graphics.setColor( 1, 0, 0, 1 );
                    love.graphics.rectangle( "fill", 420, 276 + ((id - 1) * 25), 100, 16);

                    love.graphics.setColor( 1, 1, 0, 1 );
                    love.graphics.rectangle( "fill", 420, 276 + ((id - 1) * 25), ent.sparePercentage * 100, 16);

                    love.graphics.setColor( 1, 1, 1, 1 );
                end
            end
        end
    }
};

local curProfile = {};

G.ut_update = function(dt)
    --Resizing the middle box
    if (boxSize.x < boxSize.targetX) then
        boxSize.x = boxSize.x + boxSize.speed * dt;
        if (boxSize.x > boxSize.targetX) then boxSize.x = boxSize.targetX; end
    elseif (boxSize.x > boxSize.targetX) then
        boxSize.x = boxSize.x - boxSize.speed * dt;
        if (boxSize.x < boxSize.targetX) then boxSize.x = boxSize.targetX; end
    end

    if (boxSize.y < boxSize.targetY) then
        boxSize.y = boxSize.y + boxSize.speed * dt;
        if (boxSize.y > boxSize.targetY) then boxSize.y = boxSize.targetY; end
    elseif (boxSize.y > boxSize.targetY) then
        boxSize.y = boxSize.y - boxSize.speed * dt;
        if (boxSize.y < boxSize.targetY) then boxSize.y = boxSize.targetY; end
    end

    if (soul.introAnimation < 1) then
        soul.introAnimation = soul.introAnimation + dt * 2;
        if (soul.introAnimation > 1) then 
            G.play_encounter_music(); 

            for i=1,#G.PROFILES,1 do
                if (G.PROFILES[i].name) then
                    curProfile = G.PROFILES[i];
                    break;
                end
            end
        end
        
        soul.x = 62 + (146 * soul.menuOpt);
        soul.y = 438;

        return;
    end

    if (boxSize.x == boxSize.targetX and boxSize.y == boxSize.targetY) then
        if not (soul.inBox) then soul.OOB_mode(dt);
        else soul.modes[soul.mode](dt); end
    end

    for id, ent in pairs(activeEnemies) do
        if (ent.atkShake > 0) then
            ent.atkShake = ent.atkShake - dt;
            if (ent.atkShake < 0) then
                ent.atkShake = 0;
            end
        end
    end
end

G.play_encounter_music = function()
    currentSong = G.UT_MUSIC.anticipation
    currentSong:play();
end

G.ut_draw = function()
    if (G.GAME.dr_boss) then
        local prevFont = love.graphics.getFont();
        if (currentSong) then currentSong:setVolume((G.SETTINGS.SOUND.music_volume / 100) * (G.SETTINGS.SOUND.volume / 100)); end

        local width, height, flags = love.window.getMode();

        love.graphics.setColor( 0, 0, 0, 1 );
        love.graphics.rectangle( "fill", 0, 0, width, height);

        utCanvas:renderTo(function()
            love.graphics.rectangle( "fill", 0, 0, width, height);
            love.graphics.setColor( 1, 1, 1, 1 );
            love.graphics.setLineWidth(4);

            if (soul.introAnimation < 1) then
                love.graphics.draw( G.UT_IMAGES.soul, soul.quad, 312 + (soul.x - 312) * soul.introAnimation, 232 + (soul.y - 232) * soul.introAnimation);
                return;
            end

            local left, top, right, bottom = get_box_bounds();
            love.graphics.rectangle("line", left, top, right - left, bottom - top);
            love.graphics.draw(G.UT_IMAGES.battleOpt, soul.fight, 45, 426);
            love.graphics.draw(G.UT_IMAGES.battleOpt, soul.act, 191, 426);
            love.graphics.draw(G.UT_IMAGES.battleOpt, soul.item, 337, 426);
            love.graphics.draw(G.UT_IMAGES.battleOpt, soul.mercy, 483, 426);

            love.graphics.setFont(G.UT_FONTS.DETERMINATION_MONO);
        
            love.graphics.draw( G.UT_IMAGES.soul, soul.quad, soul.x, soul.y);
            if (not soul.inBox) then
                if (soul.menu ~= "") then
                    G.UT_MENUS[soul.menu].draw(G.UT_MENUS[soul.menu]);
                else
                    love.graphics.print("* Big Boner Up the Lane", 60, 267, 0);
                end
            end

            local offset = 320 - (((#activeEnemies - 1) * 0.5) * 200);
            for id, ent in pairs(activeEnemies) do
                local imgType = type(ent.spr);

                if (imgType == "function") then
                    
                else 
                    local width, height = ent.spr:getDimensions();
                    love.graphics.draw(ent.spr, (offset - width / 2) + math.sin(ent.atkShake * 90) * (ent.atkShake * 1.5), 128 - height / 2);
                    
                    --Draw the health bar
                    if (ent.atkShake > 0) then
                        love.graphics.setColor(1, 0, 0, 1);
                        love.graphics.rectangle("fill", offset - 32, 220, 64, 12);

                        love.graphics.setColor(0, 1, 0, 1);
                        love.graphics.rectangle("fill", offset - 32, 220, (ent.health / ent.maxHealth) * 64, 12);

                        love.graphics.setColor(1, 1, 1, 1);
                    end
                end

                offset = offset + 200;
            end

            love.graphics.setFont(G.UT_FONTS.TBTD);
            love.graphics.print((curProfile.name or "uknwn").. "  ANT ".. G.GAME.round_resets.blind_ante, 48, 400, 0);
        end)

        local widthMul = width / 640;
        local heightMul = height / 480;
        if (width > height) then
            love.graphics.draw( utCanvas, (width / 2) - (640 * heightMul / 2), 0, 0, heightMul, heightMul);
        else
            love.graphics.draw( utCanvas, 0, (height / 2) - (480 * widthMul / 2), 0, widthMul, widthMul);
        end

        love.graphics.setFont(prevFont);
    end
end