local json = require('json/json')
local base64 = require('base64')

local options = nil
if pcall(vim.api.nvim_get_var, 'neofy_options') then
	options = vim.api.nvim_get_var('neofy_options')
else
	vim.api.nvim_err_writeln('NeoFy: Options for NeoFy are not defined, type :help neofy.nvim for more details')
	return
end

local CLIENT_ID = options['client_id']
local CLIENT_SECRET = options['client_secret']
local access_token = nil


if (type(CLIENT_ID) == nil or type(CLIENT_SECRET) == nil) then
	vim.api.nvim_err_writeln('NeoFy: client_id and/or client_secret are not defined , type :help neofy.nvim for more detais')
end

local function getAccessToken (CLIENT_ID, CLIENT_SECRET)
	local client_credentials = base64.encode(CLIENT_ID..':'..CLIENT_SECRET)
	local response = io.popen(
		'curl -s -d grant_type=client_credentials '..
		'-H \'Authorization: Basic '..client_credentials..'\' '..
		'-H \'Content-Type: application/x-www-form-urlencoded\' '..
		'-X POST https://accounts.spotify.com/api/token'
	):read('a')

	local parsed_response = json.decode(response)

-- Method:	|POST
-- URL:		|https://accounts.spotify.com/api/token
-- Headers:	|'Authorization' : 'Basic <base64 encoded CLIENT_ID:CLIENT_SECRET'
--			|'Content-Type' : 'application/x-www-form-urlencoded
-- Body:	|'grant_type' : 'client_credentials'
end
