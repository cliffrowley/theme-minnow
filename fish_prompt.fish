# name: minnow

function _ruby_gemset
  set -l ruby_version
  if type rvm-prompt >/dev/null 2>&1
    set ruby_version (rvm-prompt i v g)
  else if type rbenv >/dev/null 2>&1
    set ruby_version (rbenv version-name)
  end
  set isgemset (string match --regex ".*@.*" $ruby_version)
  [ -z "$isgemset" ]; and return
  [ -z "$ruby_version" ]; and return
  echo -n -s $ruby_version | cut -d- -f2-
end

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l normal (set_color normal)
  set -l gray (set_color 666)
  set -l orange (set_color ffb300)

  set -l cwd $cyan(basename (prompt_pwd))

  if [ (_ruby_gemset) ]
    set -l ruby_gemset (_ruby_gemset)
    set ruby_info "$red|$orange$ruby_gemset"
  end

  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)
    set git_info "$red|$green$git_branch"

    if [ (_is_git_dirty) ]
      set -l dirty "$yellow✗"
      set git_info "$git_info$dirty"
    end
  end

  echo -n -s $cwd $ruby_info $git_info $normal ⇒ ' ' $normal
end
