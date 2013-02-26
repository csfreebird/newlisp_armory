;; env_ubuntu.lsp
(context 'envex)

;; save the environment variable into /etc/environment
;; need root permission
;; also export the environment for subsequently executed commands
(define (set-sys-env str-name str-value)
  (env str-name str-value)
  (unless (regex str-name (read-file "/etc/environment"))
 	  (unless (append-file "/etc/environment" (append "\n" str-name "=\"" str-value "\"\n"))
 		  (throw-error (append "write /etc/environment failed, error:" (string (sys-error)))))
 	  )
  )


