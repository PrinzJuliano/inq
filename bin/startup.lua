local bedrockPath='/' if OneOS then OneOS.LoadAPI('/System/API/Bedrock.lua', false)elseif fs.exists(bedrockPath..'/Bedrock')then os.loadAPI(bedrockPath..'/Bedrock')else if http then print('Downloading Bedrock...')local h=http.get('http://pastebin.com/raw.php?i=0MgKNqpN')if h then local f=fs.open(bedrockPath..'/Bedrock','w')f.write(h.readAll())f.close()h.close()os.loadAPI(bedrockPath..'/Bedrock')else error('Failed to download Bedrock. Is your internet working?') end else error('This program needs to download Bedrock to work. Please enable HTTP.') end end if Bedrock then Bedrock.BasePath = bedrockPath Bedrock.ProgramPath = shell.getRunningProgram() end

--variables
local program = Bedrock:Initialise()
local ctrlMask = false --pressed CTRL?

--functions
local OnResetCTRLMask = function()
	ctrlMask = false
end
local OnCTRLDownMask = function()
	ctrlMask = true
	program:StartTimer(OnResetCTRLMask, 0.9)
end

local OnExit = function()
	program:LoadView("exit")
	--TODO save
	errror()
end

--event registers
program:RegisterEvent("key", function(self, event, key)
	if key == keys.leftCtrl or key == keys.rightCtrl then
		OnCTRLDownMask()
	end
	if ctrlMask and key == "q" then
		OnExit()
	end
end)

program:Run(function()
	program:LoadView("editor")
	program:GetObject("CaptionLabel").Text = "helloWorld.lua"
end)
