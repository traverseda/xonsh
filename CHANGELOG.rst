====================
Xonsh Change Log
====================

.. current developments

v0.6.0
====================

**Added:**

* Added an alias command, matching bash's implementation, available as part of bashisms.
* New ``$AUTO_SUGGEST_IN_COMPLETIONS`` environment variable that enables/disables
  whether the auto-suggestion result appears in the tab completions.
* Added ``__add__()`` and ``__radd__()`` methods to ``EnvPath``.
* Xonsh now supports f-strings, as in Python v3.6+.
* Added ``ipython`` as unthreadable in command cache threadabilty predictors.
* Added ``whole_word_jumping`` xontrib
* Added ``$XONSH_APPEND_NEWLINE`` environment variable
* Support for PEP 515: Underscores in Numeric Literals
*  ``xonsh.color_tools.make_palette()``

   Simple rename of the pre-existing
   ``xonsh.color_tools.make_pallete()`` function.

*  ``xonsh.tools.decorator()`` function/method decorator.

   This allows for an API function to be annotated with a
   decorator that documents deprecation, while also tying in
   functionality that will warn a user that the function has
   been deprecated, and, raise an ``AssertionError`` if the
   function has passed its expiry date.
* New xontrib ``schedule`` (Xonsh Task Scheduler)


**Changed:**

* ``on_pre_prompt`` is now fired before prompt calculations are made, allowing modifications to the prompt.
* ``emacsclient`` will now return false in the threadable predictors.
* Improved the autopair behavior to match that of popular code editors.
* Moved the lazy ``pkg_resources`` package back to its original
  place. The will hopefully address some of the slowdown issues
  experiances on some platforms.
* When xonsh is used to run an ``xsh`` script, the ``xonshrc`` is not loaded
* Change in the behavior of the default predictor with binary analysis. The pattern ``libgpm`` is use, assuming when ``gpm`` is used the program is not threadable. This change solves issues with programs as ``links``.
* Error messages added to the ``source`` command if it is used with a language
  that is not xonsh or Python.


**Deprecated:**

*  ``xonsh.color_tools.make_pallette()``

   Deprecated in release 0.5.10 and will be removed in release 0.6.0.


**Fixed:**

* Now f-strings can be used inside @() without explicit enclosing command in ![]
* Fix for ``x, y, *z = ...`` unpacking.
* Git branch detection now correctly passes the environment down to the subprocess
  call.  This allows for branch detection when git is installed into a non-standard
  location.
* Escape regex characters in ``path_complete`` to avoid regex parsing errors for
  certain combinations of characters in path completer
* gistatus: Fixed hash not being shown when in detaced HEAD and there are no tags
* Fix branch colorization when ``git`` or ``hg`` are aliases.
* Fixed leftover ``.git/index.lock`` in ``gitstatus``
* Made JSON history loading more robust to corrupt files.
* Starting a new command with an open parentheses will no longer
  throw a traceback when ``$UPDATE_COMPLETIONS_ON_KEYPRESS`` is
  ``True``.
* Automatically wrapping subprocess calls would sometimes include
  semincolons and other line-ending tokens, rather than stopping at them.
  This has been fixed.
*  Numerous spelling errors in documentation, docstrings/comments, text
   strings and local variable names.

*  Spelling error in the ``xonsh.color_tools.make_pallete()`` public
   function declaration. This was fixed by renaming the function to
   ``xonsh.color_tools.make_palette()`` while maintaining a binding
   of ``make_pallete()`` to the new ``make_palette()`` in case users
   are already used to this API.
* Fixed issue with starting triple quote strings being run as a command.
* Fixed a problem with escaping charet (^) character for cmd.exe in the source-cmd function.
* ``EOF in multi-line statement`` errors were misreported as being on line 0.
  Now they are correctly reported as being on the last line of the file.




v0.5.12
====================

**Fixed:**

* Fixed ``release.xsh`` to prevent it from dirtying the repo on release and
  leading to an unwanted ``.dev`` suffix on the version number




v0.5.11
====================

**Added:**

* ``release.xsh`` creates a github release with the merged news entries as the
  release body


**Fixed:**

* ``xonfig`` now displays the proper value for "on linux"


v0.5.10
====================

**Added:**

* Added ``xclip`` and ``repo`` to default threadable predictors (Issues #2355
  and #2348)
* Pretty printing of the $PATH variable
* Add "fzf-widgets" xontrib which provides fuzzy search productivity widgets
  with on custom keybindings to xontrib list.
* New ``free_cwd`` xontrib for Windows, which prevent the current directory from being locked when the prompt is shown.
  This allows the other programs or Windows explorer to delete the current or parent directory. This is accomplished by 
  resetting the CWD to the users home directory temporarily while the prompt is displayed. The directory is still locked
  while any commands are processed so xonsh still can't remove it own working directory.


**Changed:**

* Codecov threshold to 2%


**Removed:**

* On Windows environments variables in wrapped like``%foo%`` are no longer expanded automatically.


**Fixed:**

* Fixed the ``--rc`` option so it now runs xonsh with the specified rc file
* ``@$`` operator now functions properly when returned command is an alias
* Correct line continuation would not work on Windows if the line continuations were used
  in the ``xonshrc`` file.
* Fixed a regression in the Windows ``sudo`` command, that allows users to run elevated commands in xonsh.
* Fix echo command from xoreutils.
* Fixed a bug on Windows which meant xonsh wasn't using PATH environment variable but instead relying on a default
  value from the windows registry.




v0.5.9
====================

**Added:**

* Add ``Alt .`` keybinding to ``bashisms-xontrib`` to insert last argument of
  previous command into current buffer


**Fixed:**

* Fix crash when openSSH version of bash is on PATH on Windows.
* Added missing ensurers to make sure that ``bool`` env_vars are bools and
  ``int`` env_vars are integers:

  * ``DIRSTACK_SIZE``
  * ``EXPAND_ENV_VARS``
  * ``PUSHD_MINUS``
  * ``PUSHD_SILENT``
  * ``SUGGEST_COMMANDS``
  * ``SUGGEST_MAX_NUM``
  * ``SUGGEST_THRESHOLD``




v0.5.8
====================

**Changed:**

* The ``xonsh.platform.os_environ`` wrapper is  now case-insensitive and
  case-preserving on Windows.
* The private ``_TeeStd`` class will no longer attempt to write to a
  standard buffer after the tee has been 'closed' and the standard
  buffer returned to the system.


**Fixed:**

* Fixed a bug on py34 where os.scandir was used by accident.
* Line continuations (``\\``) is subproc mode will no longer consume the
  surrounding whitespace.
* Fixed a bug if foreign_shell name was not written in lower case in 
  the static configuration file ``config.json``
* Fixed a regression on Windows where caused ``which`` reported that the
  ``PATH`` environment variable could not be found.
* Fixed issue with foregrounding jobs that were started in the background.
* Fixed that ``Ctrl-C`` crashes xonsh after running an invalid command.
* Fixed an potential ``ProcessLookupError`` issue, see #2288.




v0.5.7
====================

**Added:**

* New ``color_tools`` module provides basic color tools for converting
  to and from various formats as well as creating palettes from color
  strings.
* Redirections may now be used in string and list-of-strings
  aliases.
* Subprocess redirection may now forego the whitespace between the
  redirection and a file name.  For example,
  ``echo hello world >/dev/null``.
* Add a ``-P`` flag to the ``cd`` function in order to change directory and
  following symlinks.
* ``xonfig tutorial`` command to launch the http://xon.sh/tutorial in the
  browser.
* ``@(...)`` syntax now supports generators and tuples without parentheses.
* Sourcing foreign shells now have the ``--show`` option, which
  lets you see when script will be run, and the ``--dryrun``
  option which prevents the source from actually taking place.
  Xonsh's foreign shell API also added these keyword arguments.
* Subprocess mode now supports subshells. Place any xonsh
  code between two parentheses, e.g. ``(cmd)``, to run
  this command in a separate xonsh subprocess.
* Foreign shell aliases now have the ability to take extra arguments,
  if needed.
* Xonsh will issue a warning message when the current working
  directory has been remove out from under it and not replaced
  prior to running the next command.
* Line continuation backslashes are respected on Windows in the PTK shell if
  the backspace is is preceded by a space.
* Added ``ponysay`` as a command which will usually not run in a
  threaded mode in the commands cache.
* New ``jsonutils`` module available for serializing special
  xonsh objects to JSON.


**Changed:**

* The literal tokens ``and`` and ``or`` must be surrounded by
  whitespace to delimit subprocess mode. If they do not have
  whitespace on both sides in subproc mode, they are considered
  to be part of a command argument.
* The ``xontrib`` command is now flagged as unthreadable and will be
  run on the main Python thread. This allows xontribs to set signal
  handlers and other operations that require the main thread.
* nvim (Neovim) has been flagged as unthreadable
* The interactive prompt will now catch ``SystemExit`` and, instead
  of exiting the session, will refresh the prompt. This is the same
  process as for keyboard interrupts.
* Xonsh no longer launches the wizard for new users. Instead a welcome screen is
  shown which says how to launch the wizard.
* Added Windows ``expanduser()``-like function which prevents
  the expansion of ``~`` that are not followed by a path
  separator.
* Collecting xonsh history files was reported to have random runtime
  OSError failures. This exception is now handled, just in case. The
  The exception will still be printed in debug mode.
* ``Shell.stype`` has been renamed to ``Shell.shell_type``.
* The configuration wizard now displays the proper control sequence to leave
  the wizard at the to start of the wizard itself. Note that this is Ctrl+D for
  readline and Ctrl+C for prompt-toolkit.
* Callable alias proxy functions are now more friendly to
  ``functools.partial()``.
* ``prompt.vc.get_hg_branch`` now uses ``os.scandir`` to walk up the filetree
  looking for a ``.hg`` directory. This results in (generally) faster branch
  resolution compared to the subprocess call to ``hg root``.
* Xonsh's script and code caches will are now invalidated whenever the
  xonsh version changes for a given Python version.
* Autowrapping of subprocess globs has been improved to cover
  more cases that are ambiguous with Python syntax.
* Job control info when foregrounding or backgrounding jobs will now
  only be displayed when xonsh is in interactive mode.
* Enabled virtual terminal processing in the prompt-toolkit shell for Windows.


**Fixed:**

* 3rd party pygments styles (like solorized or monokailight) are now
  able to be used in xonsh. These styles are dynamically created upon
  first use, rather than being lazily loaded by xonsh.
* On Windows, ``os.environ`` is case insensitive. This would potentially
  change the case of environment variables set into the environment.
  Xonsh now uses ``nt.environ``, the case sensitive counterpart, to avoid
  these issues on Windows.
* Fix how ``$PWD`` is managed in order to work with symlinks gracefully
* ``history replay`` no longer barfs on ``style_name`` when setting up the
  environment
* ``Shell.shell_type`` is now properly set to the same value as ``$SHELL_TYPE``.
* Fixed ``source-zsh`` to work with zsh v5.2.
* Fixed issue where ``del (x, y)`` would raise a syntax error.
* Certain vim commands issue commands involving subshells,
  and this is now supported.
* Null bytes handed to Popen are now automatically escaped prior
  to running a subprocess. This prevents Popen from issuing
  embedded null byte exceptions.
* Xonsh will no longer crash is the current working directory is
  removed out from under it.
* Multiline strings can now be written in subprocess mode.
* PTK completions will now correctly deduplicate autosuggest completions
  and display completions values based on the cursor position.
* Fixed bug where trailing backspaces on Windows paths could be interpreted
  as line continuations characters. Now line continuation characters must be
  preceded by a space on Windows. This only applies to xonsh in interactive
  mode to ensure  scripts are portable.
* Importing ``*.xsh`` files will now respect the encoding listed in
  that file and properly fallback to UTF-8. This behaviour follows
  the rules described in PEP 263.
* Wizard is now able to properly serialize environment paths.


v0.5.6
====================

**Added:**

* New core utility function aliases (written in pure Python) are now
  available in ``xonsh.xoreutils``. These include: ``cat``, ``echo``,
  ``pwd``, ``tee``, ``tty``, and ``yes``. These are not enabled by default.
  Use the new ``coreutils`` xontrib to load them.
* CircleCI test post codecov run
* The ``trace`` will automatically disable color printing when
  stdout is not a TTY or stdout is captured.
* New ``jedi`` xontrib enables jedi-based tab completions when it is loaded.
  This supersedes xonsh's default Python-mode completer.
* The lexer has a new ``split()`` method which splits strings
  according to xonsh's rules for whitespace and quotes.
* New events for hooking into the Python import process are now available.
  You can now provide a handler for:

  - ``on_import_pre_find_spec``
  - ``on_import_post_find_spec``
  - ``on_import_pre_create_module``
  - ``on_import_post_create_module``
  - ``on_import_pre_exec_module``
  - ``on_import_post_exec_module``


**Changed:**

* The prompt toolkit shell's first completion will now be the
  current token from the auto-suggestion, if available.
* Sourcing foreign shells will now safely skip applying aliases
  with the same name as existing xonsh aliases by default.
  This prevents accidentally overwriting important xonsh standard
  aliases, such as ``cd``.


**Fixed:**

* Threadable prediction for subprocesses will now consult both the command
  as it was typed in and any resolved aliases.
* The first prompt will no longer print in the middle of the line if the user has
  already started typing.
* Windows consoles will now automatically enable virtual terminal processing
  with the readline shell, if available. This allows the full use of ANSI
  escape sequences.
* On the Windows readline shell, the tab-completion suppression prompt will no
  longer error out depending on what you press.
* Fixed issue with subprocess mode wrapping not respecting line continuation
  backslashes.
* Handle a bug where Bash On Windows causes platform.windows_bash_command()
  to raise CalledProcessError.
* Fixed issues pertaining to completing from raw string paths.
  This is particularly relevant to Windows, where raw strings
  are inserted in path completion.
* Replace deprecated calls to ``time.clock()`` by calls to
  ``time.perf_counter()``.
* Use ``clock()`` to set the start time of ``_timings`` in non-windows instead
  of manually setting it to ``0.0``.
* The ``trace`` utility will now correctly color output and not
  print extraneous newlines when called in a script.
* The ``@$(cmd)`` operator now correctly splits strings according to
  xonsh semantics, rather than just on whitespace using ``str.split()``.
* The ``mpl`` xontrib has been updated to improve matplotlib
  handling. If ``xontrib load mpl`` is run before matplotlib
  is imported and xonsh is in interactive mode, matplotlib
  will automatically enter interactive mode as well. Additionally,
  ``pyplot.show()`` is patched in interactive mode to be non-blocking.
  If a non-blocking show fails to draw the figure for some reason,
  a regular blocking version is called.
* Fixed issues like ``timeit ls`` causing OSError - "Inappropriate ioctl
  for device".
* Fixed a potential "OSError: [Errno 22] Invalid argument" to increase job
  control stability.




v0.5.5
====================

**Added:**

* New ``--rc`` command line option allows users to specify paths to run control
  files from the command line. This includes both xonsh-based and JSON-based
  configuration.
* New ``$UPDATE_COMPLETIONS_ON_KEYPRESS`` controls whether or not completions
  will automatically display and update while typing. This feature is only
  available in the prompt-toolkit shell.


**Changed:**

* Xonsh scripts now report ``__file__`` and ``__name__`` when run as scripts
  or sourced. These variables have the same meaning as they do in Python
  scripts.
* ``$XONSHRC`` and related configuration variables now accept JSON-based
  static configuration file names as elements. This unifies the two methods
  of run control to a single entry point and loading system.
* The ``xonsh.shell.Shell()`` class now requires that an Execer instance
  be explicitly provided to its init method. This class is no longer
  responsible for creating an execer an its dependencies.
* Moved decorators ``unthreadable``, ``uncapturable`` from
  ``xonsh.proc`` to ``xonsh.tools``.
* Some refactorings on jobs control.


**Deprecated:**

* The ``--config-path`` command line option is now deprecated in favor of
  ``--rc``.


**Removed:**

* ``xonsh.environ.DEFAULT_XONSHRC`` has been removed due to deprecation.
  For this value, please check the environment instead, or call
  ``xonsh.environ.default_xonshrc(env)``.


**Fixed:**

* Command pipelines that end in a callable alias are now interruptable with
  ``^C`` and the processes that are piped into the alias have their file handles
  closed. This should ensure that the entire pipeline is closed.
* Fixed issue where unthreadable subprocs were not allowed to be
  captured with the ``$(cmd)`` operator.
* The ``ProcProxy`` class (unthreadable aliases) was not being executed and would
  hang if the alias was capturable. This has been fixed.
* Fixed a ``tcsetattr: Interrupted system call`` issue when run xonsh scripts.
* Fixed issue with ``ValueError`` being thrown from ``inspect.signature()``
  when called on C-extension callables in tab completer.
* Fixed issue that ``ls | less`` crashes on Mac.
* Threadable prediction was incorrectly based on the user input command, rather than
  the version where aliases have been resolved. This has been corrected.


v0.5.4
====================

**Added:**

* Add alias ``xip`` ("kip") so that xonsh's Python environment (whatever that is) can be modified.
* HistoryEntry, a SimpleNamespace object that represents a command in history.
* ``xonsh.completers.bash_completion`` module
* Added option to report timing information of xonsh startup times. Start xonsh
  with the ``--timings`` flag to use the feature.
* The Python tab completer will now complete the argument names of functions
  and other callables.
* Uptime module added to ``xonsh.xoreutils``. This can report the system
  boot time and up time.
* The environment variable ``XONSH_HISTORY_BACKEND`` now also supports a
  value of class type or a History Backend instance.
* ``on_envvar_new`` event that fires after a new envvar is created.
* ``on_envvar_change`` event that fires after an envvar is changed.


**Changed:**

* history indexing api to be more simple, now returns HistoryEntry.
* Decoupled ``bash_completion`` from xonsh project and added shim back to
  xonsh.
* The JSON history backend will now unlock history files that were created
  prior to the last reboot.


**Fixed:**

* Fixed broken bash completions on Windows if 'Windows Subsystem for Linux' is installed.
* Readline history would try to read the first element of history prior to
  actually loading any history. This caused an exception to be raised on
  Windows at xonsh startup when using pyreadline.
* Fixed issue with readline tab completer overwriting initial prefix in
  some instances.
* Fixed issue wherein if ``git`` or (presumably) ``hg`` are aliased, then branch
  information no longer appears in the ``$PROMPT``
* Fixed an issue with commands that background themselves (such as
  ``gpg-connect-agent``) not being able to be run from within xonshrc.




v0.5.3
====================

**Added:**

* Tab completion xontrib for python applications based on click framework.
* Added ``on_transform_command`` event for pre-processing that macros can't handle.
* Autodetection of backgroundability by binary analysis on POSIX.
* New argument ``expand_user=True`` to ``tools.expand_path``.
* New ``$COMPLETION_QUERY_LIMIT`` environment variable for setting the
  number of completions above which the user will be asked if they wish to
  see the potential completions.
* Users may now redirect stdout to stderr in subprocess mode.


**Changed:**

* The ``Block`` and ``Functor`` context managers from ``xonsh.contexts`` have been
  rewritten to use xonsh's macro capabilities. You must now enter these via the
  ``with!`` statement, e.g. ``with! Block(): pass``.
* The ``distributed`` xontrib now needs to use the ``with!`` statement, since it
  relies on ``Functor``.
* ``telnet`` has been flagged as unthreadable.
* When ``$DYNAMIC_CWD_ELISION_CHAR`` is non empty and the last dir of cwd is too
  long and shortened, the elision char is added at the end.
* ``pygments`` is no longer a strict dependency of the ``prompt_toolkit``
  backend. If ``pygments`` is not installed, the PTK backend will use the
  default ansi color settings from the terminal. Syntax highlighting requires
  that ``pygments`` is installed.
* Events are now keyword arguments only
* Restored ``on_precommand`` to its original signature.
* Move ``built_ins.expand_path`` to ``tools.expand_path``.
* Rename ``tools.expandpath`` to ``tools._expandpath``.
* Added ``gvim`` command to unthreadable predictors.
* The ``source`` alias now passes ``$ARGS`` down to file it is sourcing.


**Removed:**

* ``XonshBlockError`` has been removed, since it no longer serves a purpose.


**Fixed:**

* ``PopenThread`` will now re-issue SIGINT to the main thread when it is
  received.
* Fixed an issue that using sqlite history backend does not kill unfinished
  jobs when quitting xonsh with a second "exit".
* Fixed an issue that xonsh would fail over to external shells when
  running .xsh script which raises exceptions.
* Fixed an issue with ``openpty()`` returning non-unix line endings in its buffer.
  This was causing git and ssh to fail when xonsh was used as the login shell on the
  server. See https://mail.python.org/pipermail/python-list/2013-June/650460.html for
  more details.
* Restored the ability to ^Z and ``fg`` processes on posix platforms.
* CommandPipelines were not guaranteed to have been ended when the return code
  was requested. This has been fixed.
* Introduce path expansion in ``is_writable_file`` to fix
  ``$XONSH_TRACEBACK_LOGFILE=~/xonsh.log``.
* Backgrounding a running process (^Z) now restores ECHO mode to the terminal
  in cases where the subprocess doesn't properly restore itself. A major instance
  of this behaviour is Python's interactive interpreter.
* Readline backend would not ask the user to confirm the printing of completion
  options if they numbered above a certain value. Instead they would be dumped to
  the screen. This has been fixed.
* Jupyter kernel was no longer properly running subprocess commands.
  This has been fixed.
* The filename is applied to the target of the ``source`` alias, providing better
  tracebacks.




v0.5.2
====================

**Added:**

* Added ``weechat`` to default predictors
* ``$DYNAMIC_CWD_ELISION_CHAR`` environment variable to control how a shortened
  path is displayed.


**Changed:**

* ``_ret_code`` function of ``prompt_ret_code`` xontrib return now ``None`` when
  return code is 0 instead of empty string allowing more customization of prompt
  format.


**Fixed:**

* Minor Python completer token counting bug fix.
* multiline syntax error in PTK shell due to buffer not being reset
* Segfaults and other early exit signals are now reported correctly,
  again.
* ``tests/bin/{cat,pwd,wc}`` shebang changed to python3




v0.5.1
====================

**Fixed:**

* Fixed xonfig raising error when xonsh is not installed from source.




v0.5.0
====================

**Added:**

* $XONTRIB_MPL_MINIMAL environment variable can be set to change if plots are minimalist or as-seen
* xontrib-mpl now supports iTerm2 inline image display if iterm2_tools python package is installed
* Xonsh now will fallback to other shells if encountered errors when
  starting up.
* Added entry to customization faq re: ``dirs`` alias (#1452)
* Added entry to customization faq re: tab completion selection (#1725)
* Added entry to customization faq re: libgcc core dump (#1160)
* Section about quoting in the tutorial.
* The ``$VC_HG_SHOW_BRANCH`` environment variable to control whether to hide the hg branch in the prompt.
* xonfig now contains the latest git commit date if xonsh installed
  from source.
* Alt+Enter will execute a multiline code block irrespective of cursor position
* Windows now has the ability to read output asynchronously from
  the console.
* Use `doctr <https://drdoctr.github.io/doctr/>`_ to deploy dev docs to github pages
* New ``xonsh.proc.uncapturable()`` decorator for declaring that function
  aliases should not be run in a captured subprocess.
* New history backend sqlite.
* Prompt user to install xontrib package if they try to load an uninstalled
  xontrib
* Callable aliases may now take a final ``spec`` argument, which is the
  corresponding ``SubprocSpec`` instance.
* New ``bashisms`` xontrib provides additional Bash-like syntax, such as ``!!``.
  This xontrib only affects the command line, and not xonsh scripts.
* Tests that create testing repos (git, hg)
* New subprocess specification class ``SubprocSpec`` is used for specifying
  and manipulating subprocess classes prior to execution.
* New ``PopenThread`` class runs subprocesses on a a separate thread.
* New ``CommandPipeline`` and ``HiddenCommandPipeline`` classes manage the
  execution of a pipeline of commands via the execution of the last command
  in the pipeline. Instances may be iterated and stream lines from the
  stdout buffer. These pipelines read from the stdout & stderr streams in a
  non-blocking manner.
* ``$XONSH_STORE_STDOUT`` is now available on all platforms!
* The ``CommandsCache`` now has the ability to predict whether or not a
  command must be run in the foreground using ``Popen`` or may use a
  background thread and can use ``PopenThread``.
* Callable aliases may now use the full gamut of functions signatures:
  ``f()``, ``f(args)``,  ``f(args, stdin=None)``,
  ``f(args, stdin=None, stdout=None)``, and `
  ``f(args, stdin=None, stdout=None, stderr=None)``.
* Uncaptured subprocesses now receive a PTY file handle for stdout and
  stderr.
* New ``$XONSH_PROC_FREQUENCY`` environment variable that specifies how long
  loops in the subprocess framework should sleep. This may be adjusted from
  its default value to improved performance and mitigate "leaky" pipes on
  slower machines.
* ``Shift+Tab`` moves backwards in completion dropdown in prompt_toolkit
* PromptFormatter class that holds all the related prompt methods
* PromptFormatter caching when building the prompt
* p-strings: ``p'/foo/bar'`` is short for ``pathlib.Path('/foo/bar')``
* byte strings: prefixes other than ``b'foo'`` (eg, ``RB'foo'``) now work
* Backticks for regex or glob searches now support an additional modifier
  ``p``, which causes them to return Path objects instead of strings.
* New ``BOTTOM_TOOLBAR`` environment variable to control a bottom toolbar as specified in prompt-toolkit
* New ``$XONSH_STDERR_PREFIX`` and ``$XONSH_STDERR_POSTFIX`` environment
  variables allow the user to print a prompt-like string before and after
  all stderr that is seen. For example, say that you would like stderr
  to appear on a red background, you might set
  ``$XONSH_STDERR_PREFIX = "{BACKGROUND_RED}"`` and
  ``$XONSH_STDERR_PREFIX = "{NO_COLOR}"``.
* New ``xonsh.pyghooks.XonshTerminal256Formatter`` class patches
  the pygments formatter to understand xonsh color token semantics.
* Load events are now available
* New events added: ``on_post_init``, ``on_pre_cmdloop``, ``on_pre_rc``, ``on_post_rc``, ``on_ptk_create``
* Completion for ``xonsh`` builtin functions ``xontrib`` and ``xonfig``
* Added a general customization FAQ page to the docs to collect various
  tips/tricks/fixes for common issues/requests
* ``test_single_command`` and ``test_redirect_out_to_file`` tests in ``test_integrations``
* Add note that the target of redirection should be separated by a space.


**Changed:**

* CircleCI now handles flake8 checks
* Travis doesn't allow failures on nightly
* ``get_hg_branch`` runs ``hg root`` to find root dir and check if we're in repo
* The default style will now use the color keywords (#ansired, #ansidarkred)
  to set colors that follow the terminal color schemes. Currently, this requires
  prompt_toolkit master (>1.0.8) and pygments master (2.2) to work correctly.
* ``vox activate`` now accepts relative directories.
* Updated the effectivity of ``$XONSH_DEBUG`` on debug messages.
* Better documentation on how to get nice colors in Windows' default console
* All custom prompt_toolkit key binding filters now declared with the
  ``@Condition`` decorator
* The style for the prompt toolkit completion menu is now lightgray/darkgray instead of turquoise/teal
* landscape.io linting now ignores ply directory
* ``history`` help messages to reflect subcommand usage
* Quote all paths when completion if any of the paths needs be quoted,
  so that bash can automatically complete to the max prefix of the paths.
* Tee'd reads now occur in 1kb chunks, rather than character-by-character.
* The ``which`` alias no longer has a trailing newline if it is captured.
  This means that ``$(which cmd)`` will simply be the path to the command.
* The following commands are, by default, predicted to be not threadable
  in some circumstances:

    * bash
    * csh
    * clear
    * clear.exe
    * cls
    * cmd
    * ex
    * fish
    * htop
    * ksh
    * less
    * man
    * more
    * mutt
    * nano
    * psql
    * ranger
    * rview
    * rvim
    * scp
    * sh
    * ssh
    * startx
    * sudo
    * tcsh
    * top
    * vi
    * view
    * vim
    * vimpager
    * xo
    * xonsh
    * zsh
* The ``run_subproc()`` function has been replaced with a new implementation.
* Piping between processes now uses OS pipes.
* ``$XONSH_STORE_STDIN`` now uses ``os.pread()`` rather than ``tee`` and a new
  file.
* The implementation of the ``foreground()`` decorator has been moved to
  ``unthreadable()``.
* ``voxapi.Vox`` now supports ``pathlib.Path`` and ``PathLike`` objects as virtual environment identifiers
* Renamed FORMATTER_DICT to PROMPT_FIELDS
* BaseShell instantiates PromptFormatter
* readline/ptk shells use PromptFormatter
* Updated the bundled version of ``ply`` to current master available
* vended ``ply`` is now a git subtree to help with any future updates
* ``WHITE``  color keyword now means lightgray and ``INTENSE_WHITE`` completely white
* Removed ``add_to_shell`` doc section from ``*nix`` install pages and instead
  relocated it to the general customization page
* Moved a few ``*nix`` customization tips from the linux install page to the general
  customization page


**Removed:**

* coverage checks
* ``CompletedCommand`` and ``HiddenCompletedCommand`` classes have been removed
  in favor of ``CommandPipeline`` and ``HiddenCommandPipeline``.
* ``SimpleProcProxy`` and ``SimpleForegroundProcProxy`` have been removed
  in favor of a more general mechanism for dispatching callable aliases
  implemented in the ``ProcProxyThread``  and ``ProcProxy`` classes.
* ``test_run_subproc.py`` in favor of ``test_integrations.py``
* Unused imports in many tests
* Many duplicated tests (copypasta)


**Fixed:**

* xontrib-mpl now preserves the figure and does not permanently alter it for viewing
* Fix up small pep8 violations
* Fixed a bug where some files are not showing using bash completer
* Fixed some issues with subprocess capturing aliases that it probably
  shouldn't.
* ``safe_readable()`` now checks for ``ValueError`` as well.
* The scroll bars in the PTK completions menus are back.
* Jupyter kernel installation now respects the setuptools ``root`` parameter.
* Fix ``__repr__`` and ``__str__`` methods of ``SubprocSpec`` so they report
  correctly
* Fixed the message printed when which is unable to find the command.
* Fixed a handful of sphinx errors and warnings in the docs
* Fixed many PEP8 violations that had gone unnoticed
* Fix failure to detect an Anaconda python distribution if the python was install from the conda-forge channel.
* current_branch will try and locate the vc binary once
* May now Crtl-C out of an infinite loop with a subprocess, such as
  ```while True: sleep 1``.
* Fix for stdin redirects.
* Backgrounding works with ``$XONSH_STORE_STDOUT``
* ``PopenThread`` blocks its thread from finishing until command has completed
  or process is suspended.
* Added a minimum time buffer time for command pipelines to check for
  if previous commands have executed successfully.  This is helpful
  for pipelines where the last command takes a long time to start up,
  such as GNU Parallel. This also checks to make sure that output has occurred.
  This includes piping 2+ commands together and pipelines that end in
  unthreadable commands.
* ``curr_branch`` reports correctly when ``git config status.short true`` is used
* ``pip`` completion now filters results by prefix
* Fixed streaming ``!(alias)`` repr evaluation where bytes where not
  streamed.
* Aliases that begin with a comma now complete correctly (no spurious comma)
* Use ``python3`` in shebang lines for compatibility with distros that still use Python 2 as the default Python
* STDOUT is only stored when ``$XONSH_STORE_STDOUT=True``
* Fixed issue with alias redirections to files throwing an OSError because
  the function ProcProxies were not being waited upon.
* Fixed issue with callable aliases that happen to call sys.exit() or
  raise SystemExit taking out the whole xonsh process.
* Safely flushes file handles on threaded buffers.
* Proper default value and documentation for ``$BASH_COMPLETIONS``
* Fixed readline completer issues on paths with spaces
* Fix bug in ``argvquote()`` functions used when sourcing batch files on Windows. The bug meant an extra backslash was added to UNC paths.
  Thanks to @bytesemantics for spotting it, and @janschulz for fixing the issue.
* pep8, lint and refactor in pytest style of ``test_ptk_multiline.py``, ``test_replay.py``
* Tab completion of aliases returned a upper cased alias on Windows.
* History show all action now also include current session items.
* ``proc.stream_stderr`` now handles stderr that doesn't have buffer attribute
* Made ``history show`` result sorted.
* Fixed issue that ``history gc`` does not delete empty history files.
* Standard stream tees have been fixed to accept the possibility that
  they may not be backed by a binary buffer. This includes the pipeline
  stdout tee as well as the shell tees.
* Fixed a bug when the pygments plugin was used by third party editors etc.
* CPU usage of ``PopenThread`` and ``CommandPipeline`` has been brought
  down significantly.




v0.4.7
====================

**Added:**

* Define alias for 'echo' on startup for Windows only.
* New coredev `astronouth7303 <https://github.com/astronouth7303>`_ added
* ``which -a`` now searches in ``__xonsh_ctx__`` too
* Info about the xontrib cookiecutter template on xontrib tutorial
* xonsh's optional dependencies may now be installed with the pip extras ``ptk``, ``proctitle``, ``linux``, ``mac``, and ``win``.
* Env ``help`` method to format and print the vardocs for an envvar
* test_news fails if no empty line before a category
* more info on test_news failures
* Added ``on_precommand`` and ``on_postcommand`` `events </events.html>`_
* New ``FORMATTER_DICT`` entry ``gitstatus`` to provides informative git status
* FOREIGN_ALIASES_OVERRIDE envvar to control whether foreign aliases should
  override xonsh aliases with the same name.

* Warning on tutorial about foreign aliases being ignored if a xonsh alias
  exist with the same name if not FOREIGN_ALIASES_OVERRIDE.
* The prompt-toolkit shell now auto-inserts matching parentheses, brackets, and quotes. Enabled via the ``XONSH_AUTOPAIR`` environment variable
* Better syntax highlights in prompt-toolkit, including valid command / path highlighting, macro syntax highlighting, and more
* More info on tutorial about history interaction
* Entry on bash_to_xsh
* Macro context managers are now available via the ``with!``
  syntax.


**Changed:**

* Devguide reflects the current process of releasing through ``release.xsh``
* moved ``which`` from ``xonsh.aliases`` into ``xoreutils.which``
* ``xonsh.prompt.gitstatus.gitstatus`` now returns a namedtuple

* implementation of ``xonsh.prompt.vc_branch.get_git_branch`` and
  ``xonsh.prompt.vc_branch.git_dirty_working_directory`` to use 'git status --procelain'
* moved prompt formatting specific functions from ``xonsh.environ``
  to ``xonsh.prompt.base``
* All prompt formatter functions moved to ``xonsh.prompt`` subpackage
* Printing the message about foreign aliases being ignored happens only
  if XONSH_DEBUG is set.
* Use ``SetConsoleTitleW()`` on Windows instead of a process call.
* Tutorial to reflect the current history command argument functionality
* Macro function arguments now default to ``str``, rather than ``eval``,
  for consistency with other parts of the macro system.


**Removed:**

* aliases that use '!' in their name cause they clash with the macro syntax


**Fixed:**

* Fix regression where bash git completions where not loaded
  automatically when GitForWindows is installed.
* More tokens are now supported in subproc args, such as ``==``.
* Python completions now work without space delimiters, e.g. ``a=matpl<TAB>``
  will complete to ``a=matplotlib``
* Parser would fail on nested, captured suprocess macros. Now, it works,
  hooray!?
* now fires chdir event if OS change in working directory is detected.
* ``xonsh.prompt.vc_branch.git_dirty_working_directory``
   uses ``porcelain`` option instead of using the bytestring
   ``nothing to commit`` to find out if a git directory is dirty
* Fix bug where know commands where not highlighted on windows.
* Fixed completer showing executable in upper case on windows.
* Fixed issue where tilde expansion was occurring more than once before an
  equals sign.
* test_dirstack test_cdpath_expansion leaving stray testing dirs
* Better completer display for long completions in prompt-toolkit
* Automatically append newline to target of ``source`` alias, so that it may
  be exec'd.
* test_news fails when single graves around word
* Slashes in virtual environment names work in vox
* non string type value in $FORMATTER_DICT turning prompt ugly
* whole prompt turning useless when one formatting function raises an exception
* Fix completion after alias expansion
* Fix hard crash when foreign shell functions fails to run. #1715
* Bug where non-default locations for ``XDG_DATA_HOME`` and ``XONSH_DATA_DIR``
  would not expand ``~`` into the home directory
* Auto quote path completions if path contains 'and' or 'or'

* Completion now works on subcommands after pipe, ``&&``, ``||`` and so on.
* cd . and cd <singleCharacter> now work.  Fix indexerror in AUTO_PUSHD case, too.
* Fixed issue with accidentally wrapping generators inside of function calls.
* History indexing with string returns most recent command.




v0.4.6
====================

**Added:**

* New option ``COMPLETIONS_CONFIRM``. When set, ``<Enter>`` is used to confirm
  completion instead of running command while completion menu is displayed.
* NetBSD is now supported.
* Macro function calls are now available. These use a Rust-like
  ``f!(arg)`` syntax.
* Macro subprocess call now available with the ``echo! x y z``
  syntax.
* A new `event subsystem <http://xon.sh/tutorial_events.html>`_ has been added.
* howto install sections for Debian/Ubuntu and Fedora.
* ``History`` methods ``__iter__`` and ``__getitem__``

* ``tools.get_portions`` that yields parts of an iterable
* Added a py.test plugin to collect ``test_*.xsh`` files and run ``test_*()`` functions.
* ``__repr__`` and ``__str__`` magic method on LazyObject


**Changed:**

* ``create_module`` implementation on XonshImportHook
* Results of the ``bash`` tab completer are now properly escaped (quoted) when necessary.
* Foreign aliases that match xonsh builtin aliases are now ignored with a warning.
* ``prompt_toolkit`` completions now only show the rightmost portion
  of a given completion in the dropdown
* The value of ``'none'`` is no longer allowed for ``$SHELL_TYPE`` just during the initial
  load from the environment. ``-D``, later times, and other sources still work.
* ``yacc_debug=True`` now load the parser on the same thread that the
  Parser instance is created. ``setup.py`` now uses this synchronous
  form as it was causing the parser table to be missed by some package
  managers.
* Tilde expansion for the home directory now has the same semantics as Bash.
  Previously it only matched leading tildes.
* Context sensitive AST transformation now checks that all names in an
  expression are in scope. If they are, then Python mode is retained. However,
  if even one is missing, subprocess wrapping is attempted. Previously, only the
  left-most name was examined for being within scope.
* ``dirstack.pushd`` and ``dirstack.popd`` now handle UNC paths (of form ``\\<server>\<share>\...``), but only on Windows.
  They emulate behavior of `CMD.EXE` by creating a temporary mapped drive letter (starting from z: down) to replace
  the ``\\<server>\<share>`` portion of the path, on the ``pushd`` and unmapping the drive letter when all references
  to it are popped.

* And ``dirstack`` suppresses this temporary drive mapping funky jive if registry entry
  ``HKCU\software\microsoft\command processor\DisableUNCCheck`` (or HKLM\...) is a DWORD value 1.  This allows Xonsh
  to show the actual UNC path in your prompt string and *also* allows subprocess commands invoking `CMD.EXE` to run in
  the expected working directory. See https://support.microsoft.com/en-us/kb/156276 to satisfy any lingering curiosity.
* ``lazy_locate_binary`` handles binary on different drive letter than current working directory (on Windows).
* ``_curr_session_parser`` now iterates over ``History``
* New implementation of bash completer with better performance and compatibility.
* ``$COMPLETIONS_BRACKETS`` is now available to determine whether or not to
  include opening brackets in Python completions
* ``xonsh.bat`` tries to use `pylauncher <https://www.python.org/dev/peps/pep-0397/>`_ when available.


**Removed:**

* ``History`` method ``show``
* ``_hist_get_portion`` in favor of ``tools.get_portions``
* Unused imports in proc, flake8.


**Fixed:**

* xonsh modules imported now have the __file__ attribute
* Context sensitive AST transformer was not adding argument names to the
  local scope. This would then enable extraneous subprocess mode wrapping
  for expressions whose leftmost name was function argument. This has been
  fixed by properly adding the argument names to the scope.
* Foreign shell functions that are mapped to empty filenames no longer
  receive aliases since they can't be found to source later.
* Correctly preserve arguments given to xon.sh, in case there are quoted ones.
* Environment variables in subprocess mode were not being expanded
  unless they were in a sting. They are now expanded properly.
* Fixed a bug that prevented xonsh from running scripts with code caching disabled.
* Text of instructions to download missing program now does not get off and
  appears in whole.
* Fix some test problems when win_unicode_console was installed on windows.
* Fixed bug that prompt string and ``$PWD`` failed to track change in actual working directory if the
  invoked Python function happened to change it (e.g via ```os.chdir()```.  Fix is to update ``$PWD``
  after each command in ```BaseShell.default()```.
* The interactive prompt now correctly handles multiline strings.
* ``cd \\<server>\<share>`` now works when $AUTO_PUSHD is set, either creating a temporary mapped drive or simply
  setting UNC working directory based on registry ``DisableUNCCheck``.  However, if $AUTO_PUSHD is not set and UNC
  checking is enabled (default for Windows), it issues an error message and fails.  This improves on prior behavior,
  which would fail to change the current working directory, but would set $PWD and prompt string to the UNC path,
  creating false expectations.
* fix parsing for tuple of tuples (like `(),()`)
* ``sys.stdin``, ``sys.stdout``, ``sys.stderr`` no longer complete with
  opening square brackets
* xonsh now properly handles syntax error messages arising from using values in inappropriate contexts (e.g., ``del 7``).


v0.4.5
====================

**Added:**

* ``_hist_get`` that uses generators to filter and fetch
  the history commands of each session.

* ``-n`` option to the show subcommand to choose
  to numerate the commands.
* The ``exec`` command is now a first class alias that acts the same way as in
  sh-based languages. It replaces the current process with the command and
  argument that follows it. This allows xonsh to be used as a default shell
  while maintaining functionality with SSH, gdb, and other third party programs
  that assume the default shell supports raw ``exec command [args]`` syntax.

  This feature introduces some ambiguity between exec-as-a-subprocess and
  exec-as-a-function (the inescapable Python builtin). Though the two pieces of
  syntax do not overlap, they perform very different operations. Please see
  the xonsh FAQ for more information on trade-offs and mitigation strategies.
* ``which -v`` now calls superhelp, which will print highlighted source.
* Added xontribs:
  * `z (Tracks your most used directories, based on 'frecency'.) <https://github.com/astronouth7303/xontrib-z>`_
* amalgamate.py now supports relative imports.
* ``history show`` args ``-t``, ``-f``, ``-T`` ``+T`` to filter commands by timestamp

* ``ensure_timestamp`` in xonsh.tools to try and convert an object to a timestamp a.k.a float

* ``$XONSH_DATETIME_FORMAT`` envvar, the default format to be used with ``datetime.datetime.strptime()``
* ``xon.sh`` script now sets ``$LANG=C.UTF8`` in the event that no encoding
  is detected.
* amalgamate.py now properly handles ``from __future__`` imports.


**Changed:**

* ``_hist_show`` now uses ``_hist_get`` to print out the commands.
* ``xonsh.completers`` sub-package is now fully lazy.
* The vox xontrib now takes flags very similar to Python's venv tool. Use
  ``vox --help <command>`` to learn more.
* Xontribs may now define ``__all__`` as a module top-level to limit what gets exported to the shell context
* xon.sh uses the interpreter used to install instead of the default python3.
* ``imphooks`` now checks directory access rights.
* $TITLE now changes both icon (tab) and window title
* Moved ``amalgamate_source`` outside ``build_tables``

* Disable amalgamation on setup develop
* ``_hist_parse_args`` implementation refactor

* moved all parameter checking in ``_hist_get``

* ``_hist_show`` to handle numeration and timestamp printing of commands
* ``xonsh.imphooks`` does not install the import hooks automatically, you now
  need to explicitly call the  `install_hook()` method defined in this module.
  For example: ``from xonsh.imphooks import install_hook; install_hook()``. The
  ``install_hook`` method can safely be called several times. If you need
  compatibility with previous versions of Xonsh you can use the following::

    from xonsh import imphooks
    getattr(imphooks, 'install_hook', lambda:None)()
* xonfig command now dumps more encoding related settings.


**Removed:**

* Anaconda Build is shutting down so we can no longer build conda development packages.
  All references to these packages are removed from the documentation.
* Removed conda build recipe since the it is no longer used for Anaconda Build.
  The recipe used to build xonsh on conda-forge can be found here:
  https://github.com/conda-forge/xonsh-feedstock/blob/master/recipe/meta.yaml


**Fixed:**

* ``_zsh_hist_parser`` not parsing history files without timestamps.
* Fixed amalgamation of aliased imports that are already in ``sys.modules``.
* Xonsh will no longer fail to start in directories where the user doesn't have
  read access.
* Fixed parser error line number exception from being raised while trying to
  raise a SyntaxError.
* Made pip completer more robust to when pip is not installed.
* Fix a startup problem on windows caused by a refactor of Prompt_toolkit.
  https://github.com/jonathanslenders/python-prompt-toolkit/commit/a9df2a2
* ``ensure_slice`` bugfix for -1 index/slice
* Alias tab completion works again
* Version number reported by bundled PLY
* ``xonfig`` no longer breaks if PLY is externally installed and version 3.8
* LazyObject supports set union
* Fixed error with not sourcing files with ``$XONSH_ENCODING`` and
  ``$XONSH_ENCODING_ERRORS``.
* ``$IGNOREEOF`` envrionment variable now works properly in the
  prompt-toolkit shell.
* Completions in ``jupyter_kernel.py`` now use updated completion framework




v0.4.4
====================

**Added:**

* New ``lazyobject()``, ``lazydict()``, and ``lazybool()`` decorators to turn
  functions into lazy, global objects.
* ``vox remove`` command can remove multiple environments at once.
* Added FreeBSD support.
* Tab completion for pip python package manager.
* Regular expressions for environment variable matching.

* __contains__ method on Env
* Added news tests to enforce changelog conformity.
* A new way to add optional items to the prompt format string has been added.
  Instead of relying on formatter dict items being padded with a space, now the
  padding characters are specified in the format string itself, in place of the
  format spec (after a ``:``).

  For example, previously the prompt string ``{cwd}{curr_branch} $`` would rely
  on ``curr_branch`` giving its output prepended with a space for separation,
  or outputting nothing if it is not applicable. Now ``curr_branch`` just
  outputs a value or ``None``, and the prompt string has to specify the
  surrounding characters: ``{cwd}{curr_branch: {}} $``. Here the  value of
  ``curr_branch`` will be prepended with a space (``{}`` is a placeholder for
  the value itself). The format string after ``:`` is applied only if the value
  is not ``None``.
* ``xonsh.completers`` subpackage is now amalgamated.
* amalgamate.py will now warn if the same name is defined across multiple
  different files.
* xonsh_builtins, xonsh_execer fixtures in conftest.py
* Docs on how to tweak the Windows ConHost for a better color scheme.
* Docs: how to fix Thunar's "Open Terminal Here" action.
* A new API class was added to Vox: ``xontrib.voxapi.Vox``. This allows programmatic access to the virtual environment machinery for other xontribs. See the API documentation for details.
* History now accepts multiple slices arguments separated by spaces


**Changed:**

* amalgamate now works on Python 2 and allows relative imports.
* Top-level xonsh package now more lazy.
* Show conda environment name in prompt in parentheses similar what conda does.
* Implementation of expandvars now uses regex
* Because of the addition of "optional items" to the prompt format string, the
  functions ``xonsh.environ.current_branch``, ``xonsh.environ.env_name`` and
  formatter dict items ``curr_branch``, ``current_job``, ``env_name`` are
  no longer padded with a separator.
* many test cases to use fixtures and parametrization
* Public interface in ``xonsh.ansi_colors`` module now has ``ansi_``
  prefix to prevent name conflicts with other parts of xonsh.
* Vox was moved to xontrib. Behaves exactly the same as before, just need to add it to your xontribs.
* is_int_as_str and is_slice_as_str are now reimplemented in EAFP style


**Deprecated:**

* yield statements (nose style) and for loops in tests
* is_int_or_slice


**Removed:**

* _is_in_env, _get_env_string functions on tools
* ``xonsh.environ.format_prompt`` has been dropped; ``partial_format_prompt``
  can be used instead.
* for loops and yield statements in test cases, unused imports
* is_int_or_slice


**Fixed:**

* Fixed bug on Windows preventing xonsh from changing the console title.
* Unrecognized ``$XONSH_COLOR_STYLE`` values don't crash terminal.
* Writing the window title will no longer accidentally answer interactive
  questions, eg ``rm -i`` now works as expected.
* more matching cases for envvar reference
* Certain linux VTE terminals would not start new tabs in the previous CWD.
  This may now be rectified by adding ``{vte_new_tab_cwd}`` somewhere to the
  prompt.
* Unqualified usage of Unstorable in xonsh setup wizard that was causing the
  wizard to crash and burn
* Bare ``except:`` was replaced with ``except Exception`` to prevent
  accidentally catching utility exceptions such as KeyboardInterrupt, which
  caused unexpected problems like printing out the raw $PROMPT string.
* Fixed multiple definition of ``EQUAL``.
* Fixed multiple definition of ``pprint``.
* Fixed multiple definition of ``pyghooks``.
* Fixed multiple definition of ``pygments``.
* Fixed multiple definition of ``tokenize``.
* redundant and 'leaky' tests in nose
* Fix bug that prevented disabling $INTENSIFY_COLORS_ON_WIN in ``xonshrc``
* ``LazyJSON`` will now hide failures to close, and instead rely on reference
  counting if something goes wrong.
* Fixed maximum recursion error with color styles.
* Parser tables will no longer be generated in the current directory
  by accident.
* Error messages when zsh or bash history file is not found




v0.4.3
====================

**Added:**

* The results of glob expressions are sorted if ``$GLOB_SORTED`` is set.
* LazyObjects will now load themselves on ``__getitem__()``
* New tools in ``xonsh.lazyasd`` module for loading modules in background
  threads.


**Changed:**

* ``GLOB_SORTED`` is enabled by default.
* Sped up loading of pygments by ~100x by loading ``pkg_resources`` in
  background.
* Sped up loading of prompt-toolkit by ~2x-3x by loading ``pkg_resources``
  in background.
* ``setup.py`` will no longer git checkout to replace the version number.
  Now it simply stores and reuses the original version line.


**Removed:**

* Removed the ``xonsh.built_ins.ENV`` global instance of the Env class.


**Fixed:**

* Bug with setting hist size not being settable due to lazy object loading
  has been resolved.
* Minor amalgamate bug with ``import pkg.mod`` amalgamated imports.
* No longer raises an error if a directory in ``$PATH`` does not exist on
  Python v3.4.
* Fixed a readline shell completion issue that caused by inconsistency between
  ``$CASE_SENSITIVE_COMPLETIONS`` and readline's inputrc setting.




v0.4.2
====================

**Added:**

* dev versions now display a ``devN`` counter at the end and ``xonfig info``
  also displays the git sha of the current build


**Changed:**

* `prompt_toolkit` completion no longer automatically selects the first entry on first tab-press when completing multiple directories at once


**Fixed:**

* Sourcing foreign shells now allow fully capture environment variables that
  contain newlines as long as they also don't contain equal signs.
* Added scripts directory to MANIFEST.in




v0.4.1
====================

**Fixed:**

* ``setup.py`` will only amalgamate source files if ``amalgamate.py`` is
  available. This fixes issues with installing from pip.




v0.4.0
====================

**Added:**

* A new class, ``xonsh.tools.EnvPath`` has been added. This class implements a
  ``MutableSequence`` object and overrides the ``__getitem__`` method so that
  when its entries are requested (either explicitly or implicitly), variable
  and user expansion is performed, and relative paths are resolved.
  ``EnvPath`` accepts objects (or lists of objects) of ``str``, ``bytes`` or
  ``pathlib.Path`` types.
* New amalgamate tool collapses modules inside of a package into a single
  ``__amalgam__.py`` module. This tool glues together all of the code from the
  modules in a package, finds and removes intra-package imports, makes all
  non-package imports lazy, and adds hooks into the ``__init__.py``.
  This helps makes initial imports of modules fast and decreases startup time.
  Packages and sub-packages must be amalgamated separately.
* New lazy and self-destructive module ``xonsh.lazyasd`` adds a suite of
  classes for delayed creation of objects.

    - A ``LazyObject`` won't be created until it has an attribute accessed.
    - A ``LazyDict`` will load each value only when a key is accessed.
    - A ``LazyBool`` will only be created when ``__bool__()`` is called.

  Additionally, when fully loaded, the above objects will replace themselves
  by name in the context that they were handed, thus dereferencing themselves.
  This is useful for global variables that may be expensive to create,
  should only be created once, and may not be used in any particular session.
* New ``xon.sh`` script added for launching xonsh from a sh environment.
  This should be used if the normal ``xonsh`` script does not work for
  some reason.
* Normal globbing is now available in Python mode via ``g````
* Backticks were expanded to allow searching using arbitrary functions, via
  ``@<func>````
* ``xonsh.platform`` now has a new ``PATH_DEFAULT`` variable.
* Tab completers can now raise ``StopIteration`` to prevent consideration of
  remaining completers.
* Added tab completer for the ``completer`` alias.
* New ``Block`` and ``Functor`` context managers are now available as
  part of the ``xonsh.contexts`` module.
* ``Block`` provides support for turning a context body into a non-executing
  list of string lines. This is implement via a syntax tree transformation.
  This is useful for creating remote execution tools that seek to prevent
  local execution.
* ``Functor`` is a subclass of the ``Block`` context manager that turns the
  block into a callable object.  The function object is available via the
  ``func()`` attribute.  However, the ``Functor`` instance is itself callable
  and will dispatch to ``func()``.
* New ``$VC_BRANCH_TIMEOUT`` environment variable is the time (in seconds)
  of how long to spend attempting each individual version control branch
  information command during ``$PROMPT`` formatting.  This allows for faster
  prompt resolution and faster startup times.
* New lazy methods added to CommandsCache allowing for testing and inspection
  without the possibility of recomputing the cache.
* ``!(command)`` is now usefully iterable, yielding lines of stdout
* Added XonshCalledProcessError, which includes the relevant CompletedCommand.
  Also handles differences between Py3.4 and 3.5 in CalledProcessError
* Tab completion of paths now includes zsh-style path expansion (subsequence
  matching), toggleable with ``$SUBSEQUENCE_PATH_COMPLETION``
* Tab completion of paths now includes "fuzzy" matches that are accurate to
  within a few characters, toggleable with ``$FUZZY_PATH_COMPLETION``
* Provide ``$XONSH_SOURCE`` for scripts in the environment variables pointing to
  the currently running script's path
* Arguments '+' and '-' for the ``fg`` command (job control)
* Provide ``$XONSH_SOURCE`` for scripts in the environment variables pointing to
  the currently running script's path
* ``!(command)`` is now usefully iterable, yielding lines of stdout
* Added XonshCalledProcessError, which includes the relevant CompletedCommand.
  Also handles differences between Py3.4 and 3.5 in CalledProcessError
* XonshError and XonshCalledProcessError are now in builtins:

  - ``history session``
  - ``history xonsh``
  - ``history all``
  - ``history zsh``
  - ``history bash``
  - ``__xonsh_history__.show()``

* New ``pathsep_to_set()`` and ``set_to_pathsep()`` functions convert to/from
  ``os.pathsep`` separated strings to a set of strings.


**Changed:**

* Changed testing framework from nose to pytest
* All ``PATH``-like environment variables are now stored in an ``EnvPath``
  object, so that non-absolute paths or paths containing environment variables
  can be resolved properly.
* In ``VI_MODE``, the ``v`` key will enter character selection mode, not open
  the editor.  ``Ctrl-X Ctrl-E`` will still open an editor in any mode
* ``$XONSH_DEBUG`` will now suppress amalgamated imports. This usually needs to be
  set in the calling environment or prior to *any* xonsh imports.
* Restructured ``xonsh.platform`` to be fully lazy.
* Restructured ``xonsh.ansi_colors`` to be fully lazy.
* Ensured the ``pygments`` and ``xonsh.pyghooks`` are not imported until
  actually needed.
* Yacc parser is now loaded in a background thread.
* Cleaned up argument parsing in ``xonsh.main.premain`` by removing the
  ``undo_args`` hack.
* Now complains on invalid arguments.
* ``Env`` now guarantees that the ``$PATH`` is available and mutable when
  initialized.
* On Windows the ``PROMPT`` environment variable is reset to `$P$G` before
  sourcing ``*.bat`` files.
* On Windows the ``PROMPT`` environment variable is reset to `$P$G` before starting
  subprocesses. This prevents the unformatted xonsh ``PROMPT`` template from showing up
  when running batch files with ``ECHO ON```
* ``@()`` now passes through functions as well as strings, which allows for the
  use of anonymous aliases and aliases not explicitly added to the ``aliases``
  mapping.
* Functions in ``Execer`` now take ``transform`` kwarg instead of
  ``wrap_subproc``.
* Provide ``$XONSH_SOURCE`` for scripts in the environment variables pointing to
  the currently running script's path
* XonshError and XonshCalledProcessError are now in builtins
* ``__repr__`` on the environment only shows a short representation of the
  object instead of printing the whole environment dictionary
* More informative prompt when configuring foreign shells in the wizard.
* ``CommandsCache`` is now a mapping from command names to a tuple of
  (executable locations, has alias flags). This enables faster lookup times.
* ``locate_bin()`` now uses the ``CommandsCache``, rather than scanning the
  ``$PATH`` itself.
* ``$PATHEXT`` is now a set, rather than a list.
* Ignore case and leading a quotes when sorting completions


**Removed:**

* The ``'console_scripts'`` option to setuptools has been removed. It was found
  to cause slowdowns of over 150 ms on every startup.
* Bash is no longer loaded by default as a foreign shell for initial
  configuration. This was done to increase stock startup times. This
  behaviour can be recovered by adding ``{"shell": "bash"}`` to your
  ``"foreign_shells"`` in your config.json file. For more details,
  see http://xon.sh/xonshconfig.html#foreign-shells
* ``ensure_git()`` and ``ensure_hg()`` decorators removed.
* ``call_hg_command()`` function removed.


**Fixed:**

* Issue where ``xonsh`` did not expand user and environment variables in
  ``$PATH``, forcing the user to add absolute paths.
* Fixed a problem with aliases not always being found.
* Fixed issue where input was directed to the last process in a pipeline,
  rather than the first.
* Bug where xonfig wizard can't find ENV docs
* Fixed ``xonsh.environ.locate_binary()`` to handle PATH variable are given as a tuple.
* Fixed missing completions for ``cd`` and ```rmdir`` when directories had spaces
  in their names.
* Bug preventing `xonsh` executable being installed on macOS.
* Strip leading space in commands passed using the "-c" switch
* Fixed xonfig wizard failing on Windows due to colon in created filename.
* Ensured that the prompt_toolkit shell functions, even without a ``completer``
  attribute.
* Fixed crash resulting from malformed ``$PROMPT`` or ``$TITLE``.
* xonsh no longer backgrounds itself after every command on Cygwin.
* Fixed an issue about ``os.killpg()`` on Cygwin which caused xonsh to crash
  occasionally
* Fix crash on startup when Bash Windows Subsystem for Linux is on the Path.
* Fixed issue with setting and signaling process groups on Linux when the first
  process is a function alias and has no pid.
* Fixed ``_list_completers`` such that it does not throw a ValueError if no completer is registered.
* Fixed ``_list_completers`` such that it does not throw an AttributeError if a completer has no docstring.
* Bug that caused command line argument ``--config-path`` to be ignored.
* Bug that caused xonsh to break on startup when prompt-toolkit < 1.0.0.


v0.3.4
====================

**Changed:**

* ``$PROMPT`` from foreign shells is now ignored.
* ``$RC_FILES`` environment variable now stores the run control files we
  attempted to load.
* Only show the prompt for the wizard if we did not attempt to load any run
  control files (as opposed to if none were successfully loaded).
* Git and mercurial branch and dirty function refactor to improve run times.


**Fixed:**

* Fixed an issue whereby attempting to delete a literal value (e.g., ``del 7``)
  in the prompt_toolkit shell would cause xonsh to crash.
* Fixed broken behavior when using ``cd ..`` to move into a nonexistent
  directory.
* Partial workaround for Cygwin where ``pthread_sigmask`` appears to be missing
  from the ``signal`` module.
* Fixed crash resulting from malformed ``$PROMPT``.
* Fixed regression on Windows with the locate_binary() function.
  The bug prevented `source-cmd` from working correctly and broke the
  ``activate``/``deactivate`` aliases for the conda environments.
* Fixed crash resulting from errors other than syntax errors in run control
  file.
* On Windows if bash is not on the path look in the registry for the defaults
  install directory for GitForWindows.


v0.3.3
====================
**Added:**

* Question mark literals, ``?``, are now allowed as part of
  subprocess argument names.
* IPython style visual pointer to show where syntax error was detected
* Pretty printing of output and syntax highlighting of input and output can now
  be controlled via new environment variables ``$COLOR_INPUT``,
  ``$COLOR_RESULTS``, and ``$PRETTY_PRINT_RESULTS``.

* In interactive mode, if there are stopped or background jobs, Xonsh prompts
  for confirmations rather than just killing all jobs and exiting.

**Changed:**

* ``which`` now gives a better verbose report of where the executables are
  found.
* Tab completion now uses a different interface, which allows new completers
  to be implemented in Python.
* Most functions in the ``Execer`` now take an extra argument
  ``transform``, indicating whether the syntax tree transformations should
  be applied.
* ``prompt_toolkit`` is now loaded lazily, decreasing load times when using
  the ``readline`` shell.
* RC files are now executed directly in the appropriate context.
* ``_`` is now updated by ``![]``, to contain the appropriate
  ``CompletedCommand`` object.



**Removed:**

* Fixed bug on Windows where ``which`` did not include current directory

**Fixed:**

* Fixed crashed bash-completer when bash is not available on Windows
* Fixed bug on Windows where tab-completion for executables would return all files.
* Fixed bug on Windows which caused the bash $PROMPT variable to be used when no
  no $PROMPT variable was set in .xonshrc
* Improved start-up times by caching information about bash completion
  functions
* The --shell-type CLI flag now takes precedence over $SHELL_TYPE specified in
  .xonshrc
* Fixed an issue about ``os.killpg()`` on OS X which caused xonsh crash with
  occasionally.



v0.3.2
====================
**Fixed:**

* Fixed PermissionError when tab completions tries to lookup executables in
  directories without read permissions.
* Fixed incorrect parsing of command line flags



v0.3.1
====================
**Added:**

* When a subprocess exits with a signal (e.g. SIGSEGV), a message is printed,
  similar to Bash.
* Added comma literals to subproc mode.
* ``@$(cmd)`` has been added as a subprocess-mode operator, which replaces in
  the subprocess command itself with the result of running ``cmd``.
* New ``showcmd`` alias for displaying how xonsh interprets subprocess mode
  commands and arguments.
* Added ``$DYNAMIC_CWD_WIDTH`` to allow the adjusting of the current working
  directory width in the prompt.
* Added ``$XONSH_DEBUG`` environment variable to help with debugging.
* The ``${...}`` shortcut for ``__xonsh_env__`` now returns appropriate
  completion options

**Changed:**

* On Windows the default bash completions files ``$BASH_COMPLETIONS`` now points
  to the default location of the completions files used by 'Git for Windows'
* On Cygwin, some tweaks are applied to foreign shell subprocess calls and the
  readline import, in order to avoid hangs on launch.


**Removed:**

* Special cased code for handling version of prompt_toolkit < v1.0.0


**Fixed:**

* Show sorted bash completions suggestions.
* Fix bash completions (e.g git etc.) on windows when completions files have
  spaces in their path names
* Fixed a bug preventing ``source-bash`` from working on Windows
* Numerous improvements to job control via a nearly-complete rewrite.
* Addressed issue with finding the next break in subproc mode in context
  sensitive parsing.
* Fixed issue with loading readline init files (inputrc) that seems to be
  triggered by libedit.
* ``$MULTILINE_PROMPT`` now allows colors, as originally intended.
* Rectified install issue with Jupyter hook when installing with pyenv,
  Jupyter install hook now respects ``--prefix`` argument.
* Fixed issue with the xonsh.ply subpackage not being installed.
* Fixed a parsing bug whereby a trailing ``&`` on a line was being ignored
  (processes were unable to be started in the background)



v0.3.0
====================
**Added:**

* ``and``, ``or``, ``&&``, ``||`` have been added as subprocess logical operators,
  by popular demand!
* Subprocesses may be negated with ``not`` and grouped together with parentheses.
* New framework for writing xonsh extensions, called ``xontribs``.
* Added a new shell type ``'none'``, used to avoid importing ``readline`` or
  ``prompt_toolkit`` when running scripts or running a single command.
* New: `sudo` functionality on Windows through an alias
* Automatically enhance colors for readability in the default terminal (cmd.exe)
  on Windows. This functionality can be enabled/disabled with the
  $INTENSIFY_COLORS_ON_WIN environment variable.
* Added ``Ellipsis`` lookup to ``__xonsh_env__`` to allow environment variable checks, e.g. ``'HOME' in ${...}``
* Added an option to update ``os.environ`` every time the xonsh environment changes.
  This is disabled by default but can be enabled by setting ``$UPDATE_OS_ENVIRON`` to
  True.
* Added Windows 'cmd.exe' as a foreign shell. This gives xonsh the ability to source
  Windows Batch files (.bat and .cmd). Calling ``source-cmd script.bat`` or the
  alias ``source-bat script.bat`` will call the bat file and changes to the
  environment variables will be reflected in xonsh.
* Added an alias for the conda environment activate/deactivate batch scripts when
  running the Anaconda python distribution on Windows.
* Added a menu entry to launch xonsh when installing xonsh from a conda package
* Added a new ``which`` alias that supports both regular ``which`` and also searches
  through xonsh aliases. A pure python implementation of ``which`` is used. Thanks
  to Trent Mick. https://github.com/trentm/which/
* Added support for prompt toolkit v1.0.0.
* Added ``$XONSH_CACHE_SCRIPTS`` and ``$XONSH_CACHE_EVERYTHING`` environment
  variables to control caching of scripts and interactive commands.  These can
  also be controlled by command line options ``--no-script-cache`` and
  ``--cache-everything`` when starting xonsh.
* Added a workaround to allow ctrl-c to interrupt reverse incremental search in
  the readline shell

**Changed:**

* Running scripts through xonsh (or running a single command with ``-c``) no
  longer runs the user's rc file, unless the ``--login`` option is specified.
  Also avoids loading aliases and environments from foreign shells, as well as
  loading bash completions.
* rc files are now compiled and cached, to avoid re-parsing when they haven't
  changed.  Scripts are also compiled and cached, and there is the option to
  cache interactive commands.
* Left and Right arrows in the ``prompt_toolkit`` shell now wrap in multiline
  environments
* Regexpath matching with backticks, now returns an empty list in python mode.
* Pygments added as a dependency for the conda package
* Foreign shells now allow for setting exit-on-error commands before and after
  all other commands via the ``seterrprevcmd`` and ``seterrpostcmd`` arguments.
  Sensinble defaults are provided for existing shells.
* PLY is no longer a external dependency but is bundled in xonsh/ply. Xonsh can
  therefore run without any external dependencies, although having prompt-toolkit
  recommended.
* Provide better user feedback when running ``which`` in a platform that doesn't
  provide it (e.g. Windows).
* The lexer now uses a custom tokenizer that handles regex globs in the proper
  way.






**Fixed:**

* Fixed bug with loading prompt-toolkit shell < v0.57.
* Fixed bug with prompt-toolkit completion when the cursor is not at the end of
  the line.
* Aliases will now evaluate environment variables and other expansions
  at execution time rather than passing through a literal string.
* Fixed environment variables from os.environ not being loaded when a running
  a script
* The readline shell will now load the inputrc files.
* Fixed bug that prevented `source-alias` from working.
* Now able to ``^C`` the xonfig wizard on start up.
* Fixed deadlock on Windows when running subprocess that generates enough output
  to fill the OS pipe buffer.
* Sourcing foreign shells will now return a non-zero exit code if the
  source operation failed for some reason.
* Fixed PermissionError when running commands in directories without read permissions
* Prevent Windows fixups from overriding environment vars in static config
* Fixed Optional Github project status to reflect added/removed files via git_dirty_working_directory()
* Fixed xonsh.exe launcher on Windows, when Python install directory has a space in it
* Fixed `$CDPATH` to support `~` and environments variables in its items




v0.2.7
====================
**Added:**

* Added new valid ``$SHELL_TYPE`` called ``'best'``. This selects the best value
  for the concrete shell type based on the availability on the user's machine.
* New environment variable ``$XONSH_COLOR_STYLE`` will set the color mapping
  for all of xonsh.
* New ``XonshStyle`` pygments style will determine the appropriate color
  mapping based on ``$XONSH_COLOR_STYLE``.  The associated ``xonsh_style_proxy()``
  is intended for wrapping ``XonshStyle`` when actually being used by
  pygments.
* The functions ``print_color()`` and ``format_color()`` found in ``xonsh.tools``
  dispatch to the approriate shell color handling and may be used from
  anywhere.
* ``xonsh.tools.HAVE_PYGMENTS`` flag now denotes if pygments is installed and
  available on the users system.
* The ``ansi_colors`` module is now available for handling ANSI color codes.
* ``?`` and ``??`` operator output now has colored titles, like in IPython.
* ``??`` will syntax highlight source code if pygments is available.
* Python mode output is now syntax highlighted if pygments is available.
* New ``$RIGHT_PROMPT`` environment variable for displaying right-aligned
  text in prompt-toolkit shell.
* Added ``!(...)`` operator, which returns an object representing the result
  of running a command.  The truth value of this object is True if the
  return code is equal to zero and False otherwise.
* Optional dependency on the win_unicode_console package to enable unicode
  support in cmd.exe on Windows. This can be disabled/enabled with the
  ``$WIN_UNICODE_CONSOLE`` environment variable.

**Changed:**

* Updated ``$SHELL_TYPE`` default to ``'best'``.
* Shell classes are now responsible for implementing their own color
  formatting and printing.
* Prompt coloring, history diffing, and tracing uses new color handling
  capabilities.
* New ``Token.Color`` token for xonsh color names, e.g. we now use
  ``Token.Color.RED`` rather than ``Token.RED``.
* Untracked files in git are ignored when determining if a git workdir is
  is dirty. This affects the coloring of the branch label.
* Regular expression globbing now uses ``re.fullmatch`` instead of
  ``re.match``, and the result of an empty regex glob does not cause the
  argument to be deleted.


**Removed:**

* The ``xonsh.tools.TERM_COLORS`` mapping has been axed, along with all
  references to it. This may cause a problem if you were using a raw color code
  in your xonshrc file from ``$FORMATTER_DICT``. To fix, simply remove these
  references.

**Fixed:**

* Multidimensional slicing, as in numpy, no longer throws SyntaxErrors.
* Some minor zsh fixes for more platforms and setups.
* The ``BaseShell.settitle`` method no longer has its commands captured by
  ``$(...)``



v0.2.6
====================
**Added:**

* ``trace`` alias added that enables users to turn on and off the printing
  of source code lines prior to their execution. This is useful for debugging scripts.
* New ability to force callable alias functions to be run in the foreground, i.e.
  the main thread from which the function was called. This is useful for debuggers
  and profilers which may require such access. Use the ``xonsh.proc.foreground``
  decorator on an alias function to flag it. ``ForegroundProcProxy`` and
  ``SimpleForegroundProcProxy`` classes have been added to support this feature.
  Normally, forcing a foreground alias is not needed.
* Added boolean ``$RAISE_SUBPROC_ERROR`` environment variable. If true
  and a subprocess command exits with a non-zero return code, a
  CalledProcessError will be raised. This is useful in scripts that should
  fail at the first error.
* If the ``setproctitle`` package is installed, the process title will be
  set to ``'xonsh'`` rather than the path to the Python interpreter.
* zsh foreign shell interface now supported natively in xonsh, like with Bash.
  New ``source-zsh`` alias allows easy access to zsh scripts and functions.
* Vox virtual environment manager added.

**Changed:**

* The ``foreign_shell_data()`` keyword arguments ``envcmd`` and ``aliascmd``
  now default to ``None``.
* Updated alias docs to pull in usage from the commands automatically.

**Fixed:**

* Hundreds of bugs related to line and column numbers have been addressed.
* Fixed path completion not working for absolute paths or for expanded paths on Windows.
* Fixed issue with hg dirty branches and $PATH.
* Fixed issues related to foreign shell data in files with whitespace in the names.
* Worked around bug in ConEmu/cmder which prevented ``get_git_branch()``
  from working in these terminal emulators on Windows.


v0.2.5
===========
**Added:**

* New configuration utility 'xonfig' which reports current system
  setup information and creates config files through an interactive
  wizard.
* Toolkit for creating wizards now available
* timeit and which aliases will now complete their arguments.
* $COMPLETIONS_MENU_ROWS environment variable controls the size of the
  tab-completion menu in prompt-toolkit.
* Prompt-toolkit shell now supports true multiline input with the ability
  to scroll up and down in the prompt.

**Changed:**

* The xonfig wizard will run on interactive startup if no configuration
  file is found.
* BaseShell now has a singleline() method for prompting a single input.
* Environment variable docs are now auto-generated.
* Prompt-toolkit shell will now dynamically allocate space for the
  tab-completion menu.
* Looking up nonexistent environment variables now generates an error
  in Python mode, but produces a sane default value in subprocess mode.
* Environments are now considered to contain all manually-adjusted keys,
  and also all keys with an associated default value.

**Removed:**

* Removed ``xonsh.ptk.shortcuts.Prompter.create_prompt_layout()`` and
  ``xonsh.ptk.shortcuts.Prompter.create_prompt_application()`` methods
  to reduce portion of xonsh that forks prompt-toolkit. This may require
  users to upgrade to prompt-toolkit v0.57+.

**Fixed:**

* First prompt in the prompt-toolkit shell now allows for up and down
  arrows to search through history.
* Made obtaining the prompt-toolkit buffer thread-safe.
* Now always set non-detypable environment variables when sourcing
  foreign shells.
* Fixed issue with job management if a TTY existed but was not controlled
  by the process, posix only.
* Jupyter kernel no longer times out when using foreign shells on startup.
* Capturing redirections, e.g. ``$(echo hello > f.txt)``, no longer fails
  with a decoding error.
* Evaluation in a Jupyter cell will return pformatted object.
* Jupyter with redirect uncaptured subprocs to notebook.
* Tab completion in Jupyter fixed.


v0.2.1 - v0.2.4
===============
You are reading the docs...but you still feel hungry.

v0.2.0
=============
**Added:**

* Rich history recording and replaying

v0.1.0
=============
**Added:**

* Naturally typed environment variables
* Inherits the environment from BASH
* Uses BASH completion for subprocess commands
* Regular expression filename globbing
* Its own PLY-based lexer and parser
* xonsh code parses into a Python AST
* You can do all the normal Python things, like arithmetic and importing
* Captured and uncaptured subprocesses
* Pipes, redirection, and non-blocking subprocess syntax support
* Help and superhelp with ? and ??
* Command aliasing
* Multiline input, unlike ed
* History matching like in IPython
* Color prompts
* Low system overhead




<v0.1.0
=============
The before times, like 65,000,000 BCE.
