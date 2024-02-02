package.path = mp.command_native({ "expand-path", "~~/script-modules/?.lua;" }) .. package.path
local mp = require("mp")
local input = require("user-input-module")
local utils = require("mp.utils")
local md5 = require("md5")

local noteDir = "/home/nox/Documents/garden/Cards/"

local isYoutubeVideo = function(filename)
	local pattern = "watch%?v=%w+"

	-- Use string.match to check if the filename matches the pattern
	return string.match(filename, pattern) ~= nil
end

local fileExists = function(filePath)
	local fileInfo = utils.file_info(filePath)
	if fileInfo then
		return fileInfo["is_file"]
	else
		return false
	end
end

local writeYoutubeNote = function(text, filename, timeInSeconds, noteTitle)
	local author = mp.get_property("metadata/by-key/uploader")
	local source = "https://www.youtube.com/" .. filename
	local title = mp.get_property("media-title")
	local date = os.date("%Y-%m-%d")

	local timestamp = source .. "?t=" .. timeInSeconds
	local highlight = string.format("\n\n[View Highlight](%s)\n\n---\n", timestamp)

	local noteFile = utils.join_path(noteDir, noteTitle .. ".md")

	if fileExists(noteFile) then
		local file = io.open(noteFile, "a")
		file:write("\n**Note**:: " .. text)
		file:write(highlight)

		-- Close the file
		file:close()
	else
		local file = io.open(noteFile, "w")

		file:write("---\n")
		file:write(string.format("title: %s\n", title))
		file:write(string.format('author: "[[%s]]"\n', author))
		file:write('tags: "#youtube"\n')
		file:write(string.format("source: %s\n", source))
		file:write(string.format('date: "[[%s]]"\n', date))
		file:write("---\n")
		file:write("# Highlights\n")

		-- Write text to the file
		file:write("\n**Note**:: " .. text)
		file:write(highlight)

		-- Close the file
		file:close()
	end
end

local writeLocalFileNote = function(text, filename, timeInSeconds, noteTitle)
	local minutes = math.floor(timeInSeconds / 60)
	local seconds = timeInSeconds % 60
	local date = os.date("%Y-%m-%d")

	local timestamp = string.format("%s %02d:%02d", filename, minutes, seconds)
	local highlight = string.format("\n\n%s\n\n---\n", timestamp)
	local noteFile = utils.join_path(noteDir, noteTitle .. ".md")

	if fileExists(noteFile) then
		local file = io.open(noteFile, "a")
		file:write("\n**Note**:: " .. text)
		file:write(highlight)

		-- Close the file
		file:close()
	else
		local file = io.open(noteFile, "w")

		file:write("---\n")
		file:write(string.format("title: %s\n", noteTitle))
		file:write(string.format('author: "[[%s]]"\n', author))
		file:write('tags: "#video"\n')
		file:write(string.format('date: "[[%s]]"\n', date))
		file:write("---\n")
		file:write("# Highlights\n")

		-- Write text to the file
		file:write("\n**Note**:: " .. text)
		file:write(highlight)

		-- Close the file
		file:close()
	end
end

local getNoteTitle = function(propertyFile)
	local file = io.open(propertyFile, "r")
	-- Read the entire content of the file into a string
	local title = file:read("*a")
	-- Close the file when you're done with it
	file:close()

	return title
end

local takeNote = function(filename, propertyFile)
	mp.set_property("pause", "yes")

	local text, err = input.get_user_input(function(text, err)
		if err then
			return
		end
		mp.set_property("pause", "no")

		local timeInSeconds = math.floor(mp.get_property_number("time-pos"))
		local noteTitle = getNoteTitle(propertyFile)

		if isYoutubeVideo(filename) then
			writeYoutubeNote(text, filename, timeInSeconds, noteTitle)
		else
			writeLocalFileNote(text, filename, timeInSeconds, noteTitle)
		end
	end, { request_text = "Enter note:" })
end

local setNoteTitle = function()
	local filename = mp.get_property("filename")
	local md5_hash = string.upper(md5.sumhexa(filename))
	local propertyFile = utils.join_path("/home/nox/.local/state/mpv/note_title/", md5_hash)

	mp.set_property("pause", "yes")

	if fileExists(propertyFile) then
		takeNote(filename, propertyFile)
		return
	end

	input.get_user_input(function(title, err)
		if err then
			title = filename
		end
		mp.set_property("pause", "no")

		local file = io.open(propertyFile, "w")
		file:write(title)
		-- Close the file when you're done with it
		file:close()
		takeNote(filename, propertyFile)
	end, { request_text = "Enter note title:", default_input = filename, cursor_pos = filename:find("$") })
end

local updateNoteTitle = function()
	local filename = mp.get_property("filename")
	local md5_hash = string.upper(md5.sumhexa(filename))
	local propertyFile = utils.join_path("/home/nox/.local/state/mpv/note_title/", md5_hash)

	mp.set_property("pause", "yes")

	if isYoutubeVideo(filename) then
		filename = mp.get_property("media-title")
	end

	input.get_user_input(function(title, err)
		mp.set_property("pause", "no")
		if err then
			return
		end

		local file = io.open(propertyFile, "w")
		file:write(title)
		-- Close the file when you're done with it
		file:close()
	end, { request_text = "Enter note title:", default_input = filename, cursor_pos = filename:find("$") })
end

mp.add_key_binding("n", "take_note", setNoteTitle)
mp.add_key_binding("N", "update_note_title", updateNoteTitle)
