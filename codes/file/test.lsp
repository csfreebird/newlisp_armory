#!/usr/bin/newlisp
(load "file.lsp")

(file:load-file-tool)
;;(file:copy-folder "/opt/y/" "/opt/t/")

;;(file:copy-folder "c:\\y" "c:\\t")

(println (file:file-name "/opt/resources/images/account.png"))
(exit)