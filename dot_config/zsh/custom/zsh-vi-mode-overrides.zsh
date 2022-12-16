function zvm_after_lazy_keybindings() {
  # Bind Vi j/k keys to mimic up and down
  zvm_bindkey vicmd 'k' up-line-or-search
  zvm_bindkey vicmd 'j' down-line-or-search
}
