local neogit = require('neogit')

neogit.setup {}

local nmap = require('mappings').nmap

nmap('<leader>gs', ':Neogit<Cr>')
nmap('<leader>gc', ':Neogit commit<Cr>')
