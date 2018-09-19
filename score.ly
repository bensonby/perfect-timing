% ad lib
\version "2.18.2"
\include "articulate.ly"
#(set-global-staff-size 16)
% \tripletFeel 8 {

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  http://lsr.di.unimi.it/LSR/Item?id=445

%LSR by Jay Anderson.
%modyfied by Simon Albrecht on March 2014.
%=> http://lilypond.1069038.n5.nabble.com/LSR-445-error-td160662.html

#(define (octave-up m t)
 (let* ((octave (1- t))
      (new-note (ly:music-deep-copy m))
      (new-pitch (ly:make-pitch
        octave
        (ly:pitch-notename (ly:music-property m 'pitch))
        (ly:pitch-alteration (ly:music-property m 'pitch)))))
  (set! (ly:music-property new-note 'pitch) new-pitch)
  new-note))

#(define (octavize-chord elements t)
 (cond ((null? elements) elements)
     ((eq? (ly:music-property (car elements) 'name) 'NoteEvent)
       (cons (car elements)
             (cons (octave-up (car elements) t)
                   (octavize-chord (cdr elements) t))))
     (else (cons (car elements) (octavize-chord (cdr elements ) t)))))

#(define (octavize music t)
 (if (eq? (ly:music-property music 'name) 'EventChord)
       (ly:music-set-property! music 'elements (octavize-chord
(ly:music-property music 'elements) t)))
 music)

makeOctaves = #(define-music-function (parser location arg mus) (integer? ly:music?)
 (music-map (lambda (x) (octavize x arg)) (event-chord-wrap! mus)))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cr = \change Staff = "right"
cl = \change Staff = "left"
rhMark = \markup { 
  \path #0.1 #'((moveto -1 0)(rlineto 0 -1.5)(rlineto 0.5 0))
}

\header {
  title = "王菀之 - 好時辰"
  subtitle = "For female vocal and piano accompaniment"
  arranger = "Arranged by Benson"
}

melody-intro = \relative c {
  R1
}

melody-verse-one = \relative c' {
  r2 r8 b d fis~ fis d4. r4 r8
  d d4. g,8~ g4 r8
  d'8 d4 c8 b g( a) a4
  r2 r8 b d fis~ fis d4. r4 r8
  g g4 g,8 g~ g e'4 d8~ d2 r2

  r8 d8 d c c b b r
  r8 d8 d c c b b gis
  r8 e' e d d c b c b4. a16 g a4 r8
  d8 d4 e fis a a4. g16 fis g4 r8
  d8 e fis fis g g4. a8 a4 r r2
}

melody-verse-two = \relative c' {
  r8 d8 d c c b b r
  r8 d8 d c c b b gis
  r8 e' e d d c b c b4. a16 g a4 r8
  d8 d4 e fis a a4. g16 a b4 r8
  d,8 e fis fis g g4. d'8~ d b16( a16~) a4 r2
}

melody-chorus-one = \relative c' {
  b8 d d4 g8 b b4
  b8\( e, e a a4\)
  d,8 c b d d4 g8 d' d4
  d8 g, g c c4 r
  c8 b b a a g g e' e c b c a4 r8
  d,8 d' b a b a g d b e4. g8 fis4

  d8 c b8 d d4 g8 b b4
  b8\( e, e a a4\)
  d,8 c b d d4 g8 d' d4
  d8 c c d d4 r
  c8 b ais b c b a fis
  a4 g g8 a b d e4 r4
  d8 g, g d' e4 r
  d8 g, g d' b4. g8 g4 r8
  d' b4 g8 e g4. a16 g~ g2 r2
}

melody-bridge-one = \relative c' {
}

melody-chorus-two = \relative c' {
  b8 d d4 g8 b b4
  b8\( e, e a a4\)
  d,8 c b d d4 g8 d' d4
  d8 g, g c c4 r
  c8 b b a a g g e' e c b c a4 r8
  d,8 d' b a b a8. g16~ g8 d16 b e4. g8 fis4. g8~
  g8 g r
}

melody-chorus-last = \relative c'' {
  a8 b b4 a8 g g4
  b8 c c b~ b b16( a)~ a8
  d,16 c b8 d d4 g8 d' d4
  d8 c e b a4 r
  c8 b ais b c b a fis a4 g g8 a b d e4 r
  d8 g, g d' e4 r
  d8 g, g d' b4. g16( e) g4.
  d'8 b4 g8 e g4. a8~ a8 a16( g)~ g4 r2
}

melody-episode = \relative c'' {
  d16 d d8 b16 b~ b g8 bes16~( bes a8.) r8
  d,16 d d8 e16 fis~ fis d8 b'16~( b8 a8) r8
  d,8 d e fis a a4. g16 a b4 r8
  d,8 d'4 b g e d' b g8( a) a8( g16 a)
}

melody-outro = \relative c {
  R1
}

melody = \relative c' {
  \phrasingSlurUp
	\key ges \major
	\time 4/4
  \tempo 4 = 84
  \transpose g ges {
    \melody-intro
    \melody-verse-one
    \melody-chorus-one
    R1
    \melody-verse-two
    \melody-chorus-two
    \melody-episode
    \melody-chorus-last
    \melody-outro
  }
  \bar "|."
}

upper-intro = \relative c''' {
  R1
}

lower-intro = \relative c' {
  R1
}

upper-verse-one = \relative c' {
  r4 <b d g>8 r r4 <d fis>8 r
  <gis, d'>8 b d e <fis b,>4 <f bes,>
  <e g,>4 b'8 r <e, g b>4 <ees g a>
  <ees fis a c>4 <fis c' e> <fis bes e> <g a ees'>
  r4 <b, d g>8 r r4 <d fis>8 r
  <gis, d'>8 b d e <fis b,>4 <f bes,>
  <e g,>4 <c g' b>4 r8 <c bes'>4 <c e b'>8~ q2 << { b'4 bes } \\ { <ees, g>2 } >>
}
lower-verse-one = \relative c {
  g4. g16 a b2
  e,4. e16 fis g4 gis
  a4. a16 b c4 ees
  d2 d,4 d'
  g,4. g16 a b2
  e,4. e16 fis g4 gis
  a2~ a8 ees'4 d8~ d1
}
upper-bridge-one = \relative c''' {
  << {
    r8 <b a'> q <bes g'> q <a fis'> q4
    r8 <b a'> q <bes g'> q <a fis'> q <gis f'>
    r8 <c b'> q <b a'> q <bes g'> <a fis'> <bes g'>
    r8 <c b'> q <b a'> <bes g'> <a fis'> <gis eis'> <a fis'>
  } \\ {
    r4 d, c b
    r4 d c b
    r4 e d c
    r4 d c
  } >>
  \stemUp fis'2 a, b e a, g fis2 \stemNeutral \ottava #1 <ees' d'>4 \ottava #0 r

}
lower-bridge-one = \relative c {
  <b a'>2.~ q8 b~
  <b gis'>1
  <a g'>2.~ q8 c'8~ <d, c'>2. ais4
  b16 fis' a d \cr fis a d fis \cl
  dis,,16 c' fis a \cr c fis a c \cl
  e,,,16 b' d g \cr b d g b \cl
  cis,,,16 b' e g \cr b e g b \cl
  c,,, g' d' e \cr g c d e \cl
  a,,, e' c' g' \cr d' e fis g \cl
  d,, c' fis a \cr c fis a e' \cl
  r4 d,,,,4->
}


upper-verse-two = \relative c''' {
  << {
    r8 <b a'> q <bes g'> q <a fis'> q4
    r8 <b a'> q <bes g'> q <a fis'> q <gis f'>
    r8 <c b'> q <b a'> q <bes g'> <a fis'> <bes g'>
    r8 <c b'> q <b a'> <bes g'> <a fis'> <gis eis'> <a fis'>
  } \\ {
    r4 d, c b
    r4 d c b
    r4 e d c
    r4 d c
  } >>
  \stemUp fis'2 a, b e a, g fis2 \stemNeutral \ottava #1 <ees' d'>4 \ottava #0 r
}

lower-verse-two = \relative c {
  <b a'>2.~ q8 b~
  <b gis'>1
  <a g'>2.~ q8 c'8~ <d, c'>2. ais4
  b16 fis' a d \cr fis a d fis \cl
  dis,,16 c' fis a \cr c fis a c \cl
  e,,,16 b' d g \cr b d g b \cl
  cis,,,16 b' e g \cr b e g b \cl
  a,,, e' c' g' \cr c d e fis \cl
  b,,, g' a d \cr g b c g' \cl
  c,,, a' ees' fis \cr c' fis a e' \cl
  r4 d,,,,4->
}

upper-chorus-one = \relative c' {
  r8 <b d g> r <b d fis g>
  r8 <b d e g> r <b d e a>
  r8 <e g b> r <ees a>
  r8 <e fis a c> d c
  r8 <d fis a> r <d fis ais>
  r8 <d e g b> r <c d g d'>
  r8 <e g c> r <des g bes c>
  <fis bes c>16 gis,( a) dis( e) gis( a) dis
  e16 e' ees, ees' d, d' des, des' c, c' b, b' bes, bes' a, a' gis, gis' g, g' fis, fis' f, f'
  <e, bes' d e> dis e a, bes \clef bass dis, e8
  d8 dis e f fis g gis a bes b c cis
  <b dis>4 <fis c' d>->

  \clef treble
  r8 <b d g> r <b d fis g>
  r8 <b d e g> r <b d e a>
  r8 <e g b> r <ees a>
  r8 <e fis a c> d c
  r8 <d fis a> r <d fis ais>
  r8 <d e g b> r <c d g d'>
  r8 <e g c> r <des g bes c>
  <fis bes c>16 gis,( a) dis( e) gis( a) dis

  \stemUp
  a'2 fis g b
  e,16 g b e g8 s s2
  g,16 c e g c8 s s2
  << {
    g,,8 a b c d e fis g
    fis g a b c d e fis
    g4
  } \\ {
    <d,, g>4 <c a'> <e b'>2
    b'4 d4 <e g>2

    b,4 d <b d e> dis
    <c e>4 g' <g b> <fis a>
  } \\ {
    s1 s1
    f'8\rest g, fis g r8 b a b
    r8 c b c fis e d c
  } >>
}

lower-chorus-one = \relative c {
  g8 r16. fis32 g8 r
  b8 r16. ais32 b8 r
  a8 r16. a32 g8 r16. g32
  fis8 r16. e32 d8 c
  b8 r16. a'32 fis8 r
  e8 r16. e32 gis8 r
  a8 r16. fis32 ees8 r16. c32
  d16 r16 r8 r4
  \clef treble
  c'''8 b bes a gis g fis f e ees d cis
  c16 r16 r8 r8
  \clef bass bes,,
  b16 b' c, c' cis, cis' d, d' dis, dis' e, e' f, f' fis, fis' g, g' gis, gis' a, a' bes, bes'
  b4 d,->

  g,8 r16. fis32 g8 r
  b8 r16. ais32 b8 r
  a8 r16. a32 g8 r16. g32
  fis8 r16. e32 d8 c
  b8 r16. a'32 fis8 r
  e8 r16. e32 gis8 r
  a8 r16. fis32 ees8 r16. c32
  d16 r16 r8 r4

  b'16 fis' a d \cr fis a d fis \cl
  dis,, a' c fis \cr a b dis fis \cl
  e,, b' d g \cr b d e g \cl
  d,, b' d g \cr b d g b
  \stemDown
  cis,,16 b' e g b8 r r2
  c,,16 e' g c e8 r r2
  \cl
  e,,,4 d c2
  c4 b a d,
  g2 b a d'4 c
}

upper-chorus-two = \relative c' {
  r8 <b d g> r <b d fis g>
  r8 <b d e g> r <b d e a>
  r8 <e g b> r <ees a>
  r8 <e fis a c> d c
  r8 <d fis a> r <d fis ais>
  r8 <d e g b> r <c d g d'>
  r8 <e g c> r <des g bes c>
  <fis bes c>16 gis,( a) dis( e) gis( a) dis
  e16 e' ees, ees' d, d' des, des' c, c' b, b' bes, bes' a, a' gis, gis' g, g' fis, fis' f, f'
  <e, bes' d e> dis e a, bes \clef bass dis, e8
  d8 dis e f fis g gis a bes b c cis d e f fis
}

lower-chorus-two = \relative c {
  g8 r16. fis32 g8 r
  b8 r16. ais32 b8 r
  a8 r16. a32 g8 r16. g32
  fis8 r16. e32 d8 c
  b8 r16. a'32 fis8 r
  e8 r16. e32 gis8 r
  a8 r16. fis32 ees8 r16. c32
  d16 r16 r8 r4
  \clef treble
  c'''8 b bes a gis g fis f e ees d cis
  c16 r16 r8 r8
  \clef bass bes,,
  b16 b' c, c' cis, cis' d, d' dis, dis' e, e' f, f' fis, fis' g, g' gis, gis' a, a' bes, bes'
  b, b' c, c' cis, cis' d, d'
}

upper-episode = \relative c' {
  \clef treble
  <c e g>8 r <b' g'>4-- <b' g'>8( <a fis'>) <gis f'>( <g e'>)
  <c,, e a>8 r <a' fis'>4-- <a' fis'>8( <g e'>) <f d'>( <e cis'>)
  <d,, fis a>8 r <a' fis'>4-- <c' a'>8( <a fis'>) <fis e'>( <d d'>)
  e16 e' d b ais fis e cis
  d g a b des ees f g
  g, a <d g> a g b <d g> b
  g b <e g> b a b <e g> b
  bes c <d f> bes b dis <eis b'> cis
  ees, ges a c ees ges a c
}

lower-episode = \relative c, {
  c8-. d dis e c d dis e
  d e f fis d e f fis
  b,8-. c cis d b c cis d
  e8 r16. e32 fis8 r
  g8 r16. a32 b8 r

  a8 r16. d,32 ees8 r
  e8 r16. cis32 d8 r
  f8 r16. c32 cis8 r
  ees4-- ees--
}

upper-chorus-last = \relative c' {
  r8 <b d g> r <b d fis g>
  r8 <b d e g> r <b d e a>
  r8 <e g b> r <ees a>
  r8 <e fis a c> d c
  r8 <d fis a> r <d fis ais>
  r8 <d e g b> r <c d g d'>
  r8 <e g c> r <des g bes c>
  <fis bes c>16 gis,( a) dis( e) gis( a) dis

  \stemUp
  a'2 fis g b
  e,16 g b e g8 s s2
  g,16 c e g c8 s s2
  << {
    g,,8 a b c d e fis g
    fis g a b c d e fis
  } \\ {
    <d,, g>4 <c a'> <e b'>2
    b'4 d4 <e g>2
  } >>
  \ottava #1
  g'8 a b c d2 g1
  \ottava #0
}

lower-chorus-last = \relative c {
  g8 r16. fis32 g8 r
  b8 r16. ais32 b8 r
  a8 r16. a32 g8 r16. g32
  fis8 r16. e32 d8 c
  b8 r16. a'32 fis8 r
  e8 r16. e32 gis8 r
  a8 r16. fis32 ees8 r16. c32
  d16 r16 r8 r4

  b'16 fis' a d \cr fis a d fis \cl
  dis,, a' c fis \cr a b dis fis \cl
  e,, b' d g \cr b d e g \cl
  d,, b' d g \cr b d g b
  \stemDown
  cis,,16 b' e g b8 r r2
  c,,16 e' g c e8 r r2
  \cl
  e,,,4 d c2
  c4 b a d, g1~
  g1
}

upper-outro = \relative c''' {
}

lower-outro = \relative c {
}

upper = \relative c' {
  \clef treble
  \tempo 4 = 84
  \time 4/4
  \key ges \major
  \transpose g ges {
    \upper-intro
    \upper-verse-one
    \upper-bridge-one
    \upper-chorus-one
    \upper-verse-two
    \upper-chorus-two
    \upper-episode
    \upper-chorus-last
    \upper-outro
  }
  \bar "|."
}

lower = \relative c {
  \clef bass
  \time 4/4
  \key ges \major
  \transpose g ges {
    \lower-intro
    \lower-verse-one
    \lower-bridge-one
    \lower-chorus-one
    \lower-verse-two
    \lower-chorus-two
    \lower-episode
    \lower-chorus-last
    \lower-outro
  }
  \bar "|."
}

pedals = {
  % verse one
  s2..
}

dynamics = {
}

lyricsmain = \lyricmode {
  在 昨 天 裡 幾 多 人 新 歡 變 做 前 度
  未 結 識 你 只 懂 茫 然 消 耗

  幾 多 次 告 段 落 走 的 幾 多 冤 枉 路
  彷 彿 忠 告 對 下 一 位 請 更 好
  其 時 如 若 一 早 碰 著 你
  談 情 或 聚 散 也 草 草

  遇 上 你 太 感 恩 不 遲 亦 不 早
  等 我 笨 夠 了 傻 得 多 方 前 來 抱 抱
  當 天 輕 率 的 我 如 果 不 太 值 愛 慕
  如 剛 巧 擦 肩 的 你 也 無 視 過 路

  所 以 讓 我 說 太 感 激 這 時 辰 剛 好
  等 我 後 悔 了 才 珍 惜 先 叫 我 找 到
  每 段 前 事 彷 彿 一 直 考 我
  如 何 待 你 好 你 猶 如 瑰 寶
  假 如 人 一 直 糊 塗
  天 不 會 讓 我 得 到

  多 番 對 鏡 自 問 多 少 晚 反 覆 思 念
  即 使 委 屈 也 學 反 省 數 缺 點
  原 來 全 為 此 刻 對 你 講
  能 陪 伴 著 你 變 經 典

  遇 上 你 太 感 恩 不 遲 亦 不 早
  等 我 笨 夠 了 傻 得 多 方 前 來 抱 抱
  當 天 輕 率 的 我 如 只 嚮 往 被 仰 慕
  誰 竟 可 湊 巧 戀 上 我 還 是 破 壞 氣 數

  得 不 到 開 花 結 果 才 明 瞭 時 日 無 多
  旁 人 如 學 得 懂 我 也 可
  付 出 比 愛 自 己 應 更 多

  你 一 聲 很 愛 我 說 得 剛 剛 好
  此 際 悟 透 了 無 悔 了 心 意 聽 得 到

  每 段 前 事 彷 彿 一 直 考 我
  如 何 待 你 好 你 猶 如 瑰 寶
  好 時 辰 先 找 到 你
  天 公 對 待 我 真 好
}

\paper {
  page-breaking = #ly:page-turn-breaking
}
\score {
  <<
    \new Staff = "melodystaff" <<
      \set Staff.instrumentName = #"Vocal"
      \new Voice = "melody" {
        \melody
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" {
        \upper
        % \articulate << \upper \pedals >>
      }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" {
        \lower
        % \articulate << \lower \pedals >>
      }
    >>
  >>
  \layout {
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      \Staff \RemoveEmptyStaves
    }
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      % \Dynamics \RemoveEmptyStaves
    }
    \context {
      \Score
      % Remove all-rest staves also in the first system
      \override VerticalAxisGroup.remove-first = ##t
      % If only one non-empty staff in a system exists, still print the starting bar
      \override SystemStartBar.collapse-height = #1
    }
    \context {
      \ChordNames
      \override ChordName #'font-size = #-3
    }
  }
}

\score {
  <<
    \new Staff = "melodystaff" <<
      \set Staff.midiInstrument = #"electric guitar (clean)"
      \set Staff.instrumentName = #"Vocal"
      \set Staff.midiMinimumVolume = #0.6
      \set Staff.midiMaximumVolume = #0.7
      \new Voice = "melody" {
        \melody
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        % \upper
        \articulate << \upper \pedals >>
      }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        % \lower
        \articulate << \lower \pedals >>
      }
    >>
  >>
  \midi {
    \context {
      \ChordNameVoice \remove Note_performer
    }
  }
}

\book {
\bookOutputSuffix "no-vocal"
\score {
  <<
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.3
        \set Staff.midiMaximumVolume = #0.7
        \articulate << \upper \pedals >>
      }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.3
        \set Staff.midiMaximumVolume = #0.7
        \articulate << \lower \pedals >>
      }
    >>
  >>
  \midi {
    \context {
      \ChordNameVoice \remove Note_performer
    }
  }
}
}
