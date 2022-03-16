;; [[file:kcConfig.org::*org =export=][org =export=:1]]
(setq org-export-default-language "en"
      org-export-html-extension "html"
      org-export-with-timestamps nil
      org-export-with-section-numbers nil
      org-export-with-tags 'not-in-toc
      org-export-skip-text-before-1st-heading nil
      org-export-with-sub-superscripts '{}
      org-export-with-LaTeX-fragments t
      org-export-with-archived-trees nil
      org-export-highlight-first-table-line t
      org-export-latex-listings-w-names nil
      org-html-head-include-default-style nil
      org-html-head ""
      org-export-htmlize-output-type 'css
      org-export-allow-bind-keywords t
      org-publish-list-skipped-files t
      org-publish-use-timestamps-flag t
      org-export-use-babel nil
      org-confirm-babel-evaluate nil
      org-export-with-broken-links t)

(setq worg-base "/home/krupal/Documents/projects/worg_Export")
(setq worg-htmlroot "/home/krupal/Documents/projects/krvpal.github.io/")
(setq worg-base-directory worg-base)
(setq worg-base-style-directory (concat worg-base "style/"))
(setq worg-base-code-directory (concat worg-base "code/"))
(setq worg-base-color-themes-directory (concat worg-base "code/elisp/"))
(setq worg-base-images-directory (concat worg-base "images/"))
(setq worg-publish-directory worg-htmlroot)
(setq worg-publish-style-directory (concat worg-htmlroot "style/"))

(defun set-org-publish-project-alist ()
  "Set publishing projects for Orgweb and Worg."
  (interactive)
  (setq org-publish-project-alist
	`(("worg" :components ("worg-org-faq" "worg-pages" "worg-code" "worg-files" "worg-sources"))
	  ("worg-org-faq"
	   :base-directory ,worg-base-directory
	   :base-extension "dummy"
	   :include ("org-faq.org")
	   :html-extension "html"
	   :publishing-directory ,worg-publish-directory
	   :publishing-function (org-html-publish-to-html)
	   :section-numbers nil
	   :table-of-contents nil
	   :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"src/readtheorg_theme/css/htmlize.css\"/>
 <link rel=\"stylesheet\" type=\"text/css\" href=\"src/readtheorg_theme/css/readtheorg.css\"/>
 <script type=\"text/javascript\" src=\"src/lib/js/jquery.min.js\"></script>
 <script type=\"text/javascript\" src=\"src/lib/js/bootstrap.min.js\"></script>
 <script type=\"text/javascript\" src=\"src/lib/js/jquery.stickytableheaders.min.js\"></script>
 <script type=\"text/javascript\" src=\"src/readtheorg_theme/js/readtheorg.js\"></script>"
	   :recursive t
     )
	  ("worg-pages"
	   :base-directory ,worg-base-directory
	   :base-extension "org"
	   :exclude "FIXME"
	   :makeindex t
	   :auto-sitemap t
	   :sitemap-ignore-case t
	   :html-extension "html"
	   :publishing-directory ,worg-publish-directory
	   :publishing-function (org-html-publish-to-html org-org-publish-to-org)
	   :htmlized-source t
	   :section-numbers nil
	   :table-of-contents nil
	   :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"src/readtheorg_theme/css/htmlize.css\"/>
 <link rel=\"stylesheet\" type=\"text/css\" href=\"src/readtheorg_theme/css/readtheorg.css\"/>
 <script type=\"text/javascript\" src=\"src/lib/js/jquery.min.js\"></script>
 <script type=\"text/javascript\" src=\"src/lib/js/bootstrap.min.js\"></script>
 <script type=\"text/javascript\" src=\"src/lib/js/jquery.stickytableheaders.min.js\"></script>
 <script type=\"text/javascript\" src=\"src/readtheorg_theme/js/readtheorg.js\"></script>"
	   :recursive t
     )
	  ("worg-code"
	   :base-directory ,worg-base-code-directory
	   :base-extension "html\\|css\\|png\\|js\\|bz2\\|el\\|sty\\|awk\\|pl\\|texi\\|xcf\\|po\\|pot\\|inc\\|sh"
	   :publishing-directory "/home/krupal/Documents/projects/krvpal.github.io/code"
	   :recursive t
	   :publishing-function org-publish-attachment)
	  ("worg-sources"
	   :base-directory ,worg-base-directory
	   :base-extension "org"
	   :publishing-directory "/home/krupal/Documents/projects/krvpal.github.io/sources"
	   :recursive t
	   :publishing-function org-publish-attachment)
	  ("worg-files"
	   :base-directory ,worg-base-directory
	   :base-extension "png\\|jpg\\|gif\\|pdf\\|csv\\|tex\\|texi"
	   :publishing-directory ,worg-publish-directory
	   :recursive t
	   :publishing-function org-publish-attachment)
    )))

(set-org-publish-project-alist)

(defun worg-fix-symbol-table ()
  (when (string-match "org-symbols\\.html" buffer-file-name)
    (goto-char (point-min))
    (while (re-search-forward "<td>&amp;\\([^<;]+;\\)" nil t)
      (replace-match (concat "<td>&" (match-string 1)) t t))))

(defun publish-worg nil
  "Publish Worg."
  (interactive)
  (add-hook 'org-publish-after-export-hook 'worg-fix-symbol-table)
  (let ((org-format-latex-signal-error nil)
	(worg-base-directory worg-base)
	(worg-base-code-directory (concat worg-base "code/"))
	(worg-base-color-themes-directory (concat worg-base "code/elisp/"))
	(worg-base-images-directory (concat worg-base "images/"))
	(worg-publish-directory worg-htmlroot))
    (set-org-publish-project-alist)
    (message "Emacs %s" emacs-version)
    (org-version)
    (org-publish-project "worg")))
;; org =export=:1 ends here
