# NeoFy
A NeoVim integration with Spotify via Web API

## Requirements
+ cURL
+ [json.lua](https://github.com/rxi/json.lua) >= 0.1.2
+ [lbase64](https://github.com/iskolbin/lbase64) >= 1.5

## Instalation
* [vim-plug](https://github.com/junegunn/vim-plug)
```vim
Plug 'https://github.com/C0deBr3ak3r/neofy.nvim'
```
## Setup
## Processes IDs
+ A001: User authentication
+ U001: Fetch user's playlist
+ U002: Fetch user's saved songs
+ U003: Fetch user's saved albuns
+ U004: Fetch user's saved shows
+ U005: Fetch user's saved episodes

## Notes
<p>
Right now this is basically useless, the only part who fully functions as I planned is the error check. The authentication works but it can't access endpoints who requires user authentication, so because the application moves around of control users features through the Web API I must use another method of users authenticatio
<br>  Yes, I was a little inattentive. Remember, always read documentations carefully
<p>
## TODO
+ Re-implement user authentication through Authentication Code Flow
+ Processes U001 and beyond
+ Display data in a buffer
+ Asynchronusly fetch songs/episodes in a playlist/shows
+ Make the code more readable and easier to implent new functionalities
+ Help page and documentation

## Possibilities
+ Integrate with some status line plugins
+ Use icons such as [devicons](https://github.com/kyazdani42/nvim-web-devicons) to make the UI prettier (not sure if has a good icon for what I'm doing)
+ Port the help page and documentation for another language (probably portuguese)

