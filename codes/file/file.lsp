;; file.lsp
(context 'file)

;; an exception will be thrown out if the OS is neither Linux nor Windows
;; note: only Ubuntu and Windows 7 are supported for now
(define (init)
  (unless (env "NEWLISP_ARMORY_HOME")
	  (throw-error "NEWLISP_ARMORY_HOME does not exist"))
  (unless (file? (env "NEWLISP_ARMORY_HOME"))
	  (throw-error "NEWLISP_ARMORY_HOME points to a non-existing file"))
  (unless (directory? (env "NEWLISP_ARMORY_HOME"))
	  (throw-error "NEWLISP_ARMORY_HOME points to a file instead of directory"))
  (set 'file-folder (append (env "NEWLISP_ARMORY_HOME") "/codes/file"))
  (if
   (= ostype "Linux") (load (append file-folder "/file_ubuntu.lsp"))
   (= ostype "Win32") (load (append file-folder "/file_win.lsp"))
   (throw-error (append "file tool doesn't support this OS for now, ostype:" ostype))
   ))

(init)