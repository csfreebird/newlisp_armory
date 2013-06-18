#!/usr/bin/newlisp

(define (print-seperator-line)
  (println "-------------------------------------")
  (println)
  )

(println "-------------------------------------")
(println "test none environment variable ...")
(unless (catch (load "../codes/file/file.lsp") 'result)
	(println (append "catch error: " result))
	(println "test succeeded"))
(print-seperator-line)


(env "NEWLISP_ARMORY_HOME" "/opt/def/abc/hij")
(println "test home folder does not exist ...")
(unless (catch (load "../codes/file/file.lsp") 'result)
	(println (append "catch error: " result))
	(println "test succeeded"))
(print-seperator-line)


(env "NEWLISP_ARMORY_HOME" (real-path "./file_test.lsp"))
(println "test home folder is file instead of folder ...")
(unless (catch (load "../codes/file/file.lsp") 'result)
	(println (append "catch error: " result))
	(println "test succeeded"))
(print-seperator-line)


;; the following test cases are under valid environment variable
(env "NEWLISP_ARMORY_HOME" (real-path "../"))
(println (append "Correct NEWLISP_ARMORY_HOME: " (env "NEWLISP_ARMORY_HOME")))
(unless (catch (load "../codes/file/file.lsp") 'result)
	(println (append "catch error: " result))
	(println "test failed"))
(println "load file.lsp succeeded")
(print-seperator-line)

(println "test file-name function now ...")
(println "apply file-name to folder")
(unless (catch (file:file-name (real-path)) 'result)
	(println (append "catch error: " result))
	(println "test succeeded"))
(print-seperator-line)

(println "apply file-name to file")
(unless (catch (set 'fname (file:file-name (real-path "./file_test.lsp"))) 'result)
	(println (append "catch error: " result))
	(println "test failed"))
(println (append "file-name test succeeded, file name is: " fname))
(print-seperator-line)

(exit)