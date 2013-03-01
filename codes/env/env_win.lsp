;; env_ubuntu.lsp
(context 'envex)

;; save the environment variable into /etc/environment
;; need root permission
;; also export the environment for subsequently executed commands
(define (set-sys-env str-name str-value)
  (env str-name str-value)
  (exec (append "setx " str-name " \"" str-value "\" /m"))
  )


