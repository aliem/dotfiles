export _ANTIGEN_CACHE_ENABLED=true
source ~/.zsh/antigen.zsh

# Antigen Bundles
antigen bundles < ~/.zsh/plugins.conf


# Tell Antigen that we're done.
antigen apply
