[filter "lfs"]
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
	required = true
[user]
	name = {{ op://Dotfiles/Me/Identification/first name }} {{ op://Dotfiles/Me/Identification/last name }}
	email = {{ op://Dotfiles/Me/Internet Details/email }}
[core]
	autocrlf = input
