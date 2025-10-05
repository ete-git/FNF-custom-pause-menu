-- 現在の曲名と難易度を取得
-- local songTitle = getProperty("songName")
-- local difficulty = getProperty("storyDifficulty")


-- 選択肢のインデックス
curOption = 1
-- 使用するオプション
options = {"Resume", "Restart Song", "Exit to Menu"}

function onPause()
    playSound("cancelMenu")
    setProperty("inCutscene", true)
    openCustomSubstate("custom_pause_menu", true)
    return Function_Stop
end

--見た目の設定
function onCustomSubstateCreate(name)
    if name == "custom_pause_menu" then
        --ポーズ用の背景
        makeLuaSprite("pauseBG", "", 0, 0)
        makeGraphic("pauseBG", screenWidth, screenHeight, "000000")
        setObjectCamera("pauseBG", "other")
        setProperty("pauseBG.alpha", 0.7)
        addLuaSprite("pauseBG", true)

        -- pauseの文字
        makeLuaText("pauseTitle", "PAUSED", 0, 1250, 40)
        setTextSize("pauseTitle", 98)
        setObjectCamera("pauseTitle", "other")
        addLuaText("pauseTitle")

        -- キャラクターの追加
        makeLuaSprite("pauseChar","pausemenu/pause_resume",550,100)
        setObjectCamera("pauseChar","other")
        setProperty("pauseChar.scale.x", 0.65)
        setProperty("pauseChar.scale.y", 0.65)
        setProperty('pauseChar.antialiasing', true)
        addLuaSprite("pauseChar", true)

        -- 選択肢を追加
        for i = 1, #options do
            makeLuaText("option"..i, "", 0, -400, 35 + (i * 160))
            setTextSize("option"..i, 68)
            setObjectCamera("option"..i, "other")
            addLuaText("option"..i)
        end

        -- スライドして出現
        doTweenX("titleSlide", "pauseTitle", 850, 2, "expoOut")
        doTweenY("charSlide", "pauseChar", 0, 2, "expoOut")
        for i = 1, #options do
            doTweenX("optionSlide"..i, "option"..i, screenWidth/2 - 600, 2, "expoOut")
        end
        
        updateOptions()
        
    end
end

-- 選択肢に応じて画像を更新
function updateCharacterImage()
    if curOption == 1 then
        loadGraphic("pauseChar", "pausemenu/pause_resume")
    elseif curOption == 2 then
        loadGraphic("pauseChar", "pausemenu/pause_restart")
    elseif curOption == 3 then
        loadGraphic("pauseChar", "pausemenu/pause_exit")
    end
end

-- 選択肢の見た目を更新
function updateOptions()
    for i = 1, #options do
        -- 選択されている文字の前に">"を追加させる
        if i == curOption then
            setTextString("option"..i, " > " .. options[i])
        else
            setTextString("option"..i, "  " .. options[i])
        end
    end   
end



function onCustomSubstateUpdate(name, elapsed)
    if name == "custom_pause_menu" then
        -- 上を押されたら選択肢のインデックスを1減らす
        if keyJustPressed("up") or getPropertyFromClass("flixel.FlxG", "keys.justPressed.W") then
            curOption = curOption - 1
            playSound("scrollMenu")
            if curOption < 1 then 
                curOption = #options
            end
            updateOptions()
            updateCharacterImage()

        -- 上を押されたら選択肢のインデックスを1増やす
        elseif keyJustPressed("down") or getPropertyFromClass("flixel.FlxG", "keys.justPressed.S") then
            curOption = curOption + 1
            playSound("scrollMenu")
            if curOption > #options then
                curOption = 1
            end
            updateOptions()
            updateCharacterImage()
        
        -- エンターやスペースが押されたら実行
        elseif keyJustPressed("accept") then
            -- 曲再開する
            if curOption == 1 then 
                closePauseMenu()
            
            -- 曲を最初からスタートする
            elseif curOption == 2 then 
                restartSong(false)
            
            -- 曲をやめる
            elseif curOption == 3 then 
                exitSong(false)
            
            end
        end
    end
end

-- Pauseを解除されたときにUIを消す
function closePauseMenu()
    closeCustomSubstate()
    setProperty("inCutscene", false)

    -- UI削除
    removeLuaSprite("pauseBG", true)
    removeLuaText("pauseTitle", true)
    removeLuaSprite("pauseChar", true)
    for i = 1, #options do
        removeLuaText("option"..i, true)
    end

end


