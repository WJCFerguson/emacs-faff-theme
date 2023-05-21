.PHONY: test

test:
	emacs -Q -nw -L . --eval \
		'(condition-case nil (progn (load-file "faff-theme.el") (load-theme (quote faff) t) (kill-emacs 0)) (error (kill-emacs 1)))'
