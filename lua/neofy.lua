local base64 = require('base64/base64')
local json = require('json/json')

local options = {}

-- Verifies if the configs are set properly
if pcall(vim.api.nvim_get_var, 'neofy_options') then
	options = vim.api.nvim_get_var('neofy_options')
else
	vim.api.nvim_err_writeln('NeoFy: Options for NeoFy are not defined, type :help neofy.nvim for more details')
	return
end

local CLIENT_ID = options['client_id']
local CLIENT_SECRET = options['client_secret']

if (type(CLIENT_ID) == nil or type(CLIENT_SECRET) == nil) then
	vim.api.nvim_err_writeln('NeoFy: client_id and/or client_secret are not defined , type :help neofy.nvim for more detais')
end

-- Authenticate with the Spotify Web API

local ACCESS_TOKEN = nil

local function authenticate (CLIENT_ID, CLIENT_SECRET)
	local client_credentials = base64.encode(CLIENT_ID..':'..CLIENT_SECRET)

	-- Make the request for the access token
	local response = io.popen(
		'curl -s -d grant_type=client_credentials '..
		'-H \'Authorization: Basic '..client_credentials..'\' '..
		'-H \'Content-Type: application/x-www-form-urlencoded\' '..
		'-X POST https://accounts.spotify.com/api/token'
	):read('a')

	local parsed_response = json.decode(response)

	-- Verifies if an error occurs
	if (parsed_response['error'] ~= nil) then
		vim.api.nvim_err_writeln('NeoFy: While authenticating an error has occurred\nNeoFy: error details: '..parsed_response['error_description']..'\nNeoFy: Check the setup guide on GitHub for some help')

		return
	end
	ACCESS_TOKEN = parsed_response['access_token']
end

