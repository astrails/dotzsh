# setup ruby
if chruby_auto > /dev/null; then
  function _ruby_setup() {
    chruby_auto
  }
else
  function _ruby_setup() {
    :
  }
fi
_ruby_setup
