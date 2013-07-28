;; file_ubuntu.lsp
(context 'file)

;; @syntax (file:file-name folder-path)
;; @param full-path The full path of one file.
;; @return Return the file name
;; @throw Throw error if file-path points to one folder or non-existing file
(define (file-name full-path)
  (unless (file? full-path) (throw-error (append "file doesn't exist, full-path:" full-path)))
  (if (directory? full-path) (throw-error (append "full-path can't be a folder path, full-path:" full-path)))
  (first (regex "[^/]*$" full-path)))

;; @syntax (file:remove-last-seperator path)
;; @param path The full path
;; @return Return the full path which is not ended with file-seperator, e.g /opt
(define (remove-last-seperator path)
  (if (ends-with path "/")
      (replace "/$" path "" 0) path))


;; @syntax (file:remove-folder dest)
;; @param dest The full path of folder
;; @throw Throw error if dest is invalid
(define (remove-folder dest)
  (unless (file? dest) (throw-error (append "dest folder doesn't exist, dest:" dest)))
  (unless (directory? dest) (throw-error (append "dest is not a directory, dest:" dest)))
  (exec (append "rm -rf " dest)))


;; @syntax (file:copy-folder src dest)
;; @param src The full path of src folder
;; @param dest The full path of dest folder
;; @throw Throw error either src or dest is not valid folder
;; @note it doesn't matter whether src and dest arguments are ended with file-seperator or not
;; if dest/src does exist before copying, it will be removed first
(define (copy-folder src dest)
  (unless (file? src) (throw-error (append "src folder doesn't exist, src:" src)))
  (unless (directory? src) (throw-error (append "src is not a directory, src:" src)))
  (unless (file? dest) (throw-error (append "dest folder doesn't exist, dest:" dest)))
  (unless (directory? dest) (throw-error (append "dest is not a directory, dest:" dest)))
  (let (d (append dest "/" (folder-name src)))
    (if (file? d)
	(remove-folder d)))
  (exec (append "cp -r " src " " dest)))


(define (create-link src dest)
  (if (file? dest) (rm dest)
      (exec (append "ln -s " src " " dest))))

;; @syntax (file:file-seperator)
;; @note the value is different on Windows and Ubuntu
;; Windows "\\"
;; Ubuntu "/"
(set 'file-seperator "/")

;; @syntax (file:clean-folder folder-path)
;; @param full-path The full path of one file.
;; @throw Throw error if file-path points to one folder or non-existing file
;; @note only implement Ubuntu version for now
(define (clean-folder folder-path)
  (unless (file? folder-path) (throw-error (append "folder-path folder doesn't exist, folder-path:" folder-path)))
  (unless (directory? folder-path) (throw-error (append "folder-path is not a directory, folder-path:" folder-path)))
  (exec (append "rm -rf " folder-path "/*")))
