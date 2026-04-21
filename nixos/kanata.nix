{
  services.kanata = {
    enable = true;
    keyboards.internalKeyboard = {
      extraDefCfg = ''
        process-unmapped-keys yes
        concurrent-tap-hold yes
      '';
      config = ''
        (defvar
          tap-time 200
          hold-time 200
        )

        (defsrc
          grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
          tab  q    w    e    r    t    y    u    i    o    p    [
          caps a    s    d    f    g    h    j    k    l    ;    '    ret
          lsft z    x    c    v    b    n    m    ,    .    /
          lctl lmet lalt spc  ralt
        )

        (deflayer default
          grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
          tab  q    w    e    r    t    y    u    i    o    p    [
          esc  @ha  @hs  @hd  f    g    h    j    @hk  @hl  @h;  '    ret
          lsft z    x    c    v    b    n    m    ,    .    /
          lctl lmet @num spc  @pln
        )

        (deflayer plain
          grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
          tab  q    w    e    r    t    y    u    i    o    p    [
          esc  a    s    d    f    g    h    j    k    l    ;    '    ret
          lsft z    x    c    v    b    n    m    ,    .    /
          lctl lmet lalt spc  @def
        )

        (deflayer nav
          XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   bspc
          tab  XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX
          esc  XX   XX   XX   bspc XX   left down up  right ret  ret  ret
          XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX
          XX   XX   XX   XX   XX
        )

        #|
          grv  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  bspc
          XX   1    2    3    4    5    6    7    8    9    0    XX
          XX   $    +    (    )    @    |    -    =    _    *    ret  ret
          lsft !    #    {    }    ~    &    [    ]    %    ^
          XX   XX   XX   spc  XX
        |#
        (deflayer nums_and_more
          grv  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  bspc
          XX   1    2    3    4    5    6    7    8    9    0    XX
          XX   S-4  +    S-9  S-0  S-2  S-\  -    =    S--  S-8  ret  ret
          lsft S-1  S-3  S-[  S-]  S-`  S-7  [    ]    S-5  S-6
          XX   XX   XX   spc  XX
        )

        (defalias
          num (layer-while-held nums_and_more)
          pln (layer-switch plain)
          def (layer-switch default)

          ha (tap-hold $tap-time $hold-time a lmet)
          hs (tap-hold $tap-time $hold-time s lalt)
          hd (tap-hold $tap-time $hold-time d lctl)

          hk (tap-hold $tap-time $hold-time k lctl)
          hl (tap-hold $tap-time $hold-time l lalt)
          h; (tap-hold $tap-time $hold-time ; lmet)
        )

        (defchordsv2
          (s d) (layer-while-held nav) $hold-time first-release (plain)
        )
      '';
    };
  };
}
