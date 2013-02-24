					;file.lsp
(context 'file)

; an exception will be thrown out if the OS is neither Linux nor Windows
; note: only Ubuntu and Windows 7 are supported for now
(define (load-file-tool)
  (if
   (= ostype "Linux") (load "file_ubuntu.lsp")
   (= ostype "Win32") (load "file_win.lsp")
   (throw-error (append "file tool doesn't support this OS for now, ostype:" ostype))
   ))

