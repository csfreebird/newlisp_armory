#!/usr/bin/newlisp
(load "file.lsp")

(file:load-file-tool)
(file:copy-folder "/opt/y/" "/opt/t/")

(exit)