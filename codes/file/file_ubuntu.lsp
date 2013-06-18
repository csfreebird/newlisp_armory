;; file_ubuntu.lsp
(context 'file)

;; get the file name without path
;; throw error if file does not exist or is one folder instead of file
(define (file-name full-path)
  (unless (file? full-path) (throw-error (append "file doesn't exist, full-path:" full-path)))
  (if (directory? full-path) (throw-error (append "full-path can't be a folder path, full-path:" full-path)))
  (first (regex "[^/]*$" full-path)))

(define (remove-last-seperator path)
  (if (ends-with path "/")
      (replace "/$" path "" 0) path))

;; throw error if dest is invalid
(define (remove-folder dest)
  (unless (file? dest) (throw-error (append "dest folder doesn't exist, dest:" dest)))
  (unless (directory? dest) (throw-error (append "dest is not a directory, dest:" dest)))
  (exec (append "rm -rf " dest)))

;; copy the src folder to dest/src recursively
;; both src and dest must be existing folders, otherwise an exception will be thrown out
;; it doesn't matter whether src and dest arguments are ended with / or not
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


