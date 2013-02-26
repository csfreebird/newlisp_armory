;; env.lsp
(context 'envex)

;; an exception will be thrown out if the OS is neither Linux nor Windows
;; note: only Ubuntu and Windows 7 are supported for now
(define (load-env-tool)
  (if
   (= ostype "Linux") (load "env_ubuntu.lsp")
   (= ostype "Win32") (load "env_win.lsp")
   (throw-error (append "env tool doesn't support this OS for now, ostype:" ostype))
   ))

