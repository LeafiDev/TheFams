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
    DETERMINATION = new_arbituary_font("drut/fonts/DTM-Sans.ttf", 24, "mono")
}

G.UT_ENEMIES = {
    --TEST
    {
        spr = G.UT_IMAGES.testEnemy,
        attacks = {},
        health = 10,

        initialText = "* He's here!"
    }
}

local utCanvas = love.graphics.newCanvas(640, 480);
local currentSong = nil;
local activeEnemies = {
    G.UT_ENEMIES[1]
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

                G.UT_MENUS[soul.menu].init();
                soul.toggle_opt(soul.menuOpt + 1, false);
            end
        end

        soul.x = 52 + (146 * soul.menuOpt)
        soul.y = 438;
    else
        G.UT_MENUS[soul.menu].update(dt);
    end

    soul.leftHeld = love.keyboard.isDown("left");
    soul.rightHeld = love.keyboard.isDown("right");
    soul.selectHeld = love.keyboard.isDown("z");
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
    end
}

local boxSize = {
    x = 544,
    y = 140,

    targetX = 544,
    targetY = 140,

    speed = 75
}

G.UT_MENUS = {
    fight = {
        time = 0,

        init = function()
            G.UT_MENUS.fight.time = -1;
            boxSize.targetX = 560;
        end,
        
        update = function(dt)
            G.UT_MENUS.fight.time = G.UT_MENUS.fight.time + dt;
            soul.x = -1000;
            soul.y = -1000;
        end,

        draw = function()
            love.graphics.draw(G.UT_IMAGES.battleThing, 45, 255);
            love.graphics.draw(G.UT_IMAGES.battleBar, (G.UT_MENUS.fight.time * boxSize.x / 2) + 320, 255);
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

    if not (soul.inBox) then soul.OOB_mode(dt);
    else soul.modes[soul.mode](dt); end
end

G.play_encounter_music = function()
    currentSong = G.UT_MUSIC.anticipation
    currentSong:play();
end

G.fams_draw = function()
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

            love.graphics.rectangle( "line", 320 - (boxSize.x / 2), 319 - (boxSize.y / 2), boxSize.x, boxSize.y );
            love.graphics.draw(G.UT_IMAGES.battleOpt, soul.fight, 45, 426);
            love.graphics.draw(G.UT_IMAGES.battleOpt, soul.act, 191, 426);
            love.graphics.draw(G.UT_IMAGES.battleOpt, soul.item, 337, 426);
            love.graphics.draw(G.UT_IMAGES.battleOpt, soul.mercy, 483, 426);
        
            love.graphics.draw( G.UT_IMAGES.soul, soul.quad, soul.x, soul.y);
            if (soul.menu ~= "") then
                G.UT_MENUS[soul.menu].draw();
            else
                love.graphics.setFont(G.UT_FONTS.DETERMINATION);
                love.graphics.print("* Testicles", 60, 267, 0);
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