vim.opt.shell = "/bin/bash"
vim.opt.shellcmdflag = "-lc"
vim.o.guifont = "JetBrains Mono:h12"
vim.opt.clipboard = "unnamedplus"

require("config.leader")
require("config.lazy")
