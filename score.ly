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
    \melody-verse-two
    \melody-chorus-two
    \melody-episode
    \melody-chorus-last
    \melody-outro
  }
  % \bar "|."
}

upper-intro = \relative c''' {
  R1
}

lower-intro = \relative c' {
  R1
}

upper-verse-one = \relative c' {
  R1*16
}

upper-verse-two = \relative c'' {
}

lower-verse-one = \relative c {
  R1*16
}

lower-verse-two = \relative c' {
}

upper-chorus-one = \relative c' {
  r8 <b d g> r <b d fis g>
  r8 <b d e g> r <b d e a>
  r8 <e g b> r <ees a>
  r8 <e fis a c> d c
  r8 <d fis a> r <d fis ais>
  r8 <d e g b> r <c d g d'>
  r8 <e g c> r <des g bes c>
  <fis bes c>8 r s4
  a'16 e' g, ees' g, d' g, e'
  c, a' d, b' d, bes' c, a'
  c, aes' e c' fis, dis' a ees' c16 a fis ees c a fis ees

}

lower-chorus-one = \relative c {
  g8 r16. fis32 g8 r
  b8 r16. ais32 b8 r
  a8 r16. a32 g8 r16. g32
  fis8 r16. e32 d8 c
  b8 r16. a'32 fis8 r
  e8 r16. e32 gis8 r
  a8 r16. fis32 ees8 r16. c32
  d16 bes' d fis \cr bes d fis bes
  \cl
  \clef treble
  e8 ees d des c b bes a aes g ges f ees r r
  \clef bass
  bes,,8 b c cis d dis e f fis g gis a bes a8 r r4
}

upper-chorus-two = \relative c' {
}

lower-chorus-two = \relative c' {
}

upper-episode = \relative c''' {
}

lower-episode = \relative c' {
}

upper-chorus-last = \relative c' {
}

lower-chorus-last = \relative c' {
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
    \upper-chorus-one
    \upper-verse-two
    \upper-chorus-two
    \upper-episode
    \upper-chorus-last
    \upper-outro
  }
  % \bar "|."
}

lower = \relative c {
  \clef bass
  \time 4/4
  \key ges \major
  \transpose g ges {
    \lower-intro
    \lower-verse-one
    \lower-chorus-one
    \lower-verse-two
    \lower-chorus-two
    \lower-episode
    \lower-chorus-last
    \lower-outro
  }
  % \bar "|."
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
