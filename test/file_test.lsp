#!/usr/bin/newlisp

(println "-------------------------------------")
(println "test none environment variable ...")
(unless (catch (load "../codes/file/file.lsp") 'result)
	(println (append "catch error: " result))
	(println "test succeeded"))
(println "-------------------------------------")
(println)

(env "NEWLISP_ARMORY_HOME" "/opt/def/abc/hij")
(println "test home folder does not exist ...")
(unless (catch (load "../codes/file/file.lsp") 'result)
	(println (append "catch error: " result))
	(println "test succeeded"))
(println "-------------------------------------")
(println)

(env "NEWLISP_ARMORY_HOME" (real-path "./file_test.lsp"))
(println "test home folder is file instead of folder ...")
(unless (catch (load "../codes/file/file.lsp") 'result)
	(println (append "catch error: " result))
	(println "test succeeded"))
(println "-------------------------------------")
(println)

;; the following test cases are under valid environment variable
(env "NEWLISP_ARMORY_HOME" (real-path "../"))
(println (append "Correct NEWLISP_ARMORY_HOME: " (env "NEWLISP_ARMORY_HOME")))
(unless (catch (load "../codes/file/file.lsp") 'result)
	(println (append "catch error: " result))
	(println "test failed"))
(println "load file.lsp succeeded")
(println "-------------------------------------")
(println)


(exit)