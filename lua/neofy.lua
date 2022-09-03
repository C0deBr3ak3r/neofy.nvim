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

-- Verifies if and error occurs in the call with API
local function checkForAPIErrors(response, process_id)
-- Parameters: response(table), process_id(string)
-- Return: nil(if an error has occurred), response(if no error)
-- Description: Verify if has an error in the response table and display an error message

local error = response['error']

	if (error) then
		if response['error'] == 'invalid_client' then
			vim.api.nvim_err_writeln('NeoFy: an error while authenticating has occurred'..
			'\nNeoFy: error details: '..response['error_description']..
			'\nNeoFy: check the GitHub page for some help')

			return nil
		end

		vim.api.nvim_err_writeln('NeoFy: an error has occurred, process id: '..process_id..
		'\nNeoFy: status code: '..error['status']..
		'\n NeoFy: error details: '..error['message'])

		return nil
	end

	return response

end

-- Authentication with Spotify Web API
local ACCESS_TOKEN = nil

local function authenticate(CLIENT_ID, CLIENT_SECRET)
--	Parameters: CLIENT_ID(string), CLIENT_SECRET(string)
--	Return: nothing
--	Description: Authenticate the user to the Spotify Web API and updates the access token

	local client_credentials = base64.encode(CLIENT_ID..':'..CLIENT_SECRET)

	-- Make the request for the access token
	local res_json = io.popen(
		'curl -s -d grant_type=client_credentials '..
		'-H \'Authorization: Basic '..client_credentials..'\' '..
		'-H \'Content-Type: application/x-www-form-urlencoded\' '..
		'-X POST https://accounts.spotify.com/api/token'
	):read('a')

	-- Verifies if an error has occurred
	local res_table = checkForAPIErrors(json.decode(res_json), 'A001')

	if (res_table == nil) then
		return
	end

	ACCESS_TOKEN = res_table['access_token']
end
