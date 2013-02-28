;; env.lsp
(context 'envex)

;; an exception will be thrown out if the OS is neither Linux nor Windows
;; note: only Ubuntu and Windows 7 are supported for now
(define (load-env-tool)
  ;; (println (append "path:" (string (real-path "env_ubuntu.lsp"))))
  (set 'env-folder (append (env "NEWLISP_ARMORY_HOME") "codes/env"))
  (if
   (= ostype "Linux") (load (append env-folder "/env_ubuntu.lsp"))
   (= ostype "Win32") (load (append env-folder "/env_win.lsp"))
   (throw-error (append "env tool doesn't support this OS for now, ostype:" ostype))
   ))

