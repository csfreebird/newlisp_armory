#!/usr/bin/newlisp
(load "env.lsp")

(envex:load-env-tool)
(envex:set-sys-env "NAME1" "B")
(exit)