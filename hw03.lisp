; **************** BEGIN INITIALIZATION FOR ACL2s B MODE ****************** ;
; (Nothing to see here!  Your actual file is after this initialization code);

#|
Pete Manolios
Fri Jan 27 09:39:00 EST 2012
----------------------------

Made changes for spring 2012.


Pete Manolios
Thu Jan 27 18:53:33 EST 2011
----------------------------

The Beginner level is the next level after Bare Bones level.

|#

; Put CCG book first in order, since it seems this results in faster loading of this mode.
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading the CCG book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "ccg/ccg" :uncertified-okp nil :dir :acl2s-modes :ttags ((:ccg)) :load-compiled-file nil);v4.0 change

;Common base theory for all modes.
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s base theory book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "base-theory" :dir :acl2s-modes)

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s customizations book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "custom" :dir :acl2s-modes :uncertified-okp nil :ttags :all)

;Settings common to all ACL2s modes
(acl2s-common-settings)

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading trace-star and evalable-ld-printing books.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "trace-star" :uncertified-okp nil :dir :acl2s-modes :ttags ((:acl2s-interaction)) :load-compiled-file nil)
(include-book "hacking/evalable-ld-printing" :uncertified-okp nil :dir :system :ttags ((:evalable-ld-printing)) :load-compiled-file nil)

;theory for beginner mode
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s beginner theory book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "beginner-theory" :dir :acl2s-modes :ttags :all)


#+acl2s-startup (er-progn (assign fmt-error-msg "Problem setting up ACL2s Beginner mode.") (value :invisible))
;Settings specific to ACL2s Beginner mode.
(acl2s-beginner-settings)

; why why why why 
(acl2::xdoc acl2s::defunc) ; almost 3 seconds

(cw "~@0Beginner mode loaded.~%~@1"
    #+acl2s-startup "${NoMoReSnIp}$~%" #-acl2s-startup ""
    #+acl2s-startup "${SnIpMeHeRe}$~%" #-acl2s-startup "")


(acl2::in-package "ACL2S B")

; ***************** END INITIALIZATION FOR ACL2s B MODE ******************* ;
;$ACL2s-SMode$;Beginner
#|

CS 2800 Homework 3 - Spring 2017

One group member will create a group in BlackBoard.
 
 * Other group members then join the group.
 
 * Homework is submitted by one group member. Therefore make sure the person
   submitting actually does so. In previous terms when everyone needed
   to submit we regularly had one person forget but the other submissions
   meant the team did not get a zero. Now if you forget, your team gets 0.
   - It wouldn't be a bad idea for groups to email confirmation messages
     to each other to reduce anxiety.

 * Submit the homework file (this file) on Blackboard.  Do not rename 
   this file.  There will be a 10 point penalty for this.

 * You must list the names of ALL group members below, using the given
   format. This way we can confirm group membership with the BB groups.
   If you fail to follow these instructions, it costs us time and
   it will cost you points, so please read carefully.


Names of ALL group members: Izaak Branch, Chris Kenyon

Note: There will be a 10 pt penalty if your names do not follow 
this format.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For this homework you will need to use ACL2s.

Technical instructions:

- open this file in ACL2s as hw03.lisp

- make sure you are in BEGINNER mode. This is essential! Note that you can
  only change the mode when the session is not running, so set the correct
  mode before starting the session.

- insert your solutions into this file where indicated (usually as "...")

- only add to the file. Do not remove or comment out anything pre-existing.

- make sure the entire file is accepted by ACL2s. In particular, there must
  be no "..." left in the code. If you don't finish all problems, comment
  the unfinished ones out. Comments should also be used for any English
  text that you may add. This file already contains many comments, so you
  can see what the syntax is.

- when done, save your file and submit it as hw03.lisp

- avoid submitting the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file.

Instructions for programming problems:

For each function definition, you must provide both contracts and a body.

You must also ALWAYS supply your own tests. This is in addition to the
tests sometimes provided. Make sure you produce sufficiently many new test
cases. This means: cover at least the possible scenarios according to the
data definitions of the involved types. For example, a function taking two
lists should have at least 4 tests: all combinations of each list being
empty and non-empty.

Beyond that, the number of tests should reflect the difficulty of the
function. For very simple ones, the above coverage of the data definition
cases may be sufficient. For complex functions with numerical output, you
want to test whether it produces the correct output on a reasonable
number if inputs.

Use good judgment. For unreasonably few test cases we will deduct points. In
fact, I've told the markers they can add any tests they want. You should feel
confident your code will pass ANY tests the markers can come up with.

We will use ACL2s' check= function for tests. This is a two-argument
function that rejects two inputs that do not evaluate equal. You can think
of check= roughly as defined like this:

(defunc check= (x y)
  :input-contract (equal x y)
  :output-contract (equal (check= x y) t)
  t)

That is, check= only accepts two inputs with equal value. For such inputs, t
(or "pass") is returned. For other inputs, you get an error. If any check=
test in your file does not pass, your file will be rejected.

If we've done test? or thm in class before the due date, feel free to test
with these as well.  They can be much more powerful. An example for made up
function "double-len" might be:
(test? (implies (listp l) (equal (double-len l)(* (len l) 2))))

|#

#|

This time around, we will let ACL2s formally prove the various 
conditions for admitting a function.  Hence ":program" has been
commented out. If you get stuck, you can put things back into
program mode but you will lose some points (but better than 0)

NOTE 2: Proving function correctness often takes time.  Please be
patient when functions are being admitted.  If they fail,  you'll
see red text output in the REPL window (it won't hang).
|#
;:program

#|

Notes:

1. Testing is cheaper but less powerful than proving. So, by turning off
proving and doing only testing, it is possible that the functions we are
defining cause runtime errors even if called on valid inputs. In the future
we will require functions complete with admission proofs, i.e. without the
above directive. For this homework, the functions are simple enough
that there is a good chance ACL2s's testing will catch any contract or
termination errors you may have.

2. The tests ACL2s runs test only the conditions for admitting the
function. They do not test for "functional correctness", i.e. does the
function do what it is supposed to do? ACL2s has no way of telling what
your function is supposed to do. That is what your own tests are for!

|#

#|
 Problem I: Rock-Paper-Scissors-Lizard-spocK (RPSLK) and Beyond
 The classic game Rock-Paper-Scissors or Roshambo 
 (https://en.wikipedia.org/wiki/Rock%E2%80%93paper%E2%80%93scissors) 
 is a 2 player game where each person simulaneously makes a hand sign
 (indicating rock paper or scissors) and each sign either beats or is
 beaten by another. This game can be extended to any odd number of 
 hand signs provided there are an equal number of ways to 
 win and lose against each sign. Hence Dr. Sheldon Cooper from
 the Big Bang Theory suggests Rock-Paper-Scissors-Lizard-Spock (the K 
 for Spock is so we don't have a Scissors and Spock collission and 
 you can write your move with a single character rather than writing 
 words each time)
 (http://bigbangtheory.wikia.com/wiki/Rock_Paper_Scissors_Lizard_Spock)
 
 The rules are as follows:
  Scissors cuts Paper
  Paper covers Rock
  Rock crushes Lizard
  Lizard poisons Spock
  Spock smashes Scissors
  Scissors decapitates Lizard
  Lizard eats Paper
  Paper disproves Spock
  Spock vaporizes Rock
  (and as it always has) Rock crushes Scissors
  
 Since we know many of you use a divide and conquer approach to splitting up
 your homework (despite us telling you not to) we figured we would give you
 a tool to decide which partner does the hard problems.  Each player will define
 a list of RPSLK decisions and the function you write below will run a series
 of RPSLK matches to determine who won the most in the series. A single match just
 seems way to easy.
 
 You will need to define the data definitions both to encode your decisions AND
 to encode all the game rules.  This way, you can expand the game further
 in creative ways (bonus question). You functions should work with any data 
 in that format.
 
 Instructions For Playing Game:
 1) Player 1: Fill in the *p1* constant with as many signs / matches
    as desired.  Player 2 should not look at this.
 2) Player 1: Scroll down to the *p2* definition below.
 3) Player 1: Now close your eyes (or walk away from the screen)
 4) Player 2: Change the list of signs in the *p2* definition. You can 
    have as many as you want.
 5) Player 2: Admit all RPSLK code for Part 1.
 6) Player 2: From the Read-Evaluate-Print Loop call 
 (runMatches *p1* *p2* *RPSLK-rules*)
 or 
 (runMatchesMsg *p1* *p2* *RPSLK-rules*)
 7) Player 2: Hide all evidence of the game outcome and tell player 1 to
 open his or her eyes.
 8) Player 2: Claim you won. Optional: gloat.
|#

;; Data Definitions
;; RPSLK is the set of possible signs one can make and a loc is a list
;; or series of matches that use these signs.
:logic
(defdata RPSLK (oneof 'R 'P 'S 'L 'K))
(defdata loc (listof RPSLK))
(defconst *p1* (list 'S 'S 'S 'S 'S))

;; DEFINE a record which describes win/loss cases. The defconst below 
;; should work using your record. You can change this later if you 
;; solve the bonus question:
(defdata RPSLK-rule (record (c1 . RPSLK)
                            (c2 . RPSLK)
                            (outcome . string)))

(defconst *SP-rule* (RPSLK-rule 'S 'P "Scissors cuts Paper"))
; Add the remaining rules
(defconst *PR-rule* (RPSLK-rule 'P 'R "Paper covers Rock"))
(defconst *RL-rule* (RPSLK-rule 'R 'L "Rock crushes Lizard"))
(defconst *LK-rule* (RPSLK-rule 'L 'K "Lizard poisons Spock"))
(defconst *KS-rule* (RPSLK-rule 'K 'S "Spock smashes Scissors"))
(defconst *SL-rule* (RPSLK-rule 'S 'L "Scissors decapitates Lizard"))
(defconst *LP-rule* (RPSLK-rule 'L 'P "Lizard eats Paper"))
(defconst *PK-rule* (RPSLK-rule 'P 'K "Paper disproves Spock"))
(defconst *KR-rule* (RPSLK-rule 'K 'R "Spock vaporizes Rock"))
(defconst *RS-rule* (RPSLK-rule 'R 'S "Rock crushes Scissors"))

;; Now bundle these rules in whatever way you think would be most effective
;; so that all the game rules can be passed as a single rule-list parameter
(defdata rule-list (listof RPSLK-rule)) 
(defconst *RPSLK-rules* (list *SP-rule* *PR-rule* *RL-rule* *LK-rule* *KS-rule*
                               *SL-rule* *LP-rule* *PK-rule* *KR-rule* *RS-rule*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; getWinner: RPSLK x RPSLK x rule-list -> Integer
;; (getWinner p1 p2 rules) takes player 1's sign p1
;; player 2's sign p2, and the game rules (rules)
;; and returns -1 if p2 wins, 1 if p1 wins and 0 for a tie
(defunc getWinner (p1 p2 rules)
  :input-contract (and (RPSLKp p1)(RPSLKp p2)(rule-listp rules))
  :output-contract (integerp (getWinner p1 p2 rules))
  (cond ((or (equal p1 p2)(endp rules)) 0)
        ((and (equal p1 (RPSLK-rule-c1 (first rules))) 
              (equal p2 (RPSLK-rule-c2 (first rules)))) 1)
        ((and (equal p1 (RPSLK-rule-c2 (first rules))) 
              (equal p2 (RPSLK-rule-c1 (first rules)))) -1)
        (t (getWinner p1 p2 (rest rules)))))

(check= (getWinner 'R 'R *RPSLK-rules*) 0)
(check= (getWinner 'P 'P *RPSLK-rules*) 0)
(check= (getWinner 'S 'S *RPSLK-rules*) 0)
(check= (getWinner 'K 'K *RPSLK-rules*) 0)
(check= (getWinner 'L 'L *RPSLK-rules*) 0)
(check= (getWinner 'S 'P *RPSLK-rules*) 1)
(check= (getWinner 'P 'S *RPSLK-rules*) -1)
(check= (getWinner 'P 'R *RPSLK-rules*) 1)
(check= (getWinner 'R 'P *RPSLK-rules*) -1)
(check= (getWinner 'R 'L *RPSLK-rules*) 1)
(check= (getWinner 'L 'R *RPSLK-rules*) -1)
(check= (getWinner 'K 'S *RPSLK-rules*) 1)
(check= (getWinner 'S 'K *RPSLK-rules*) -1)
(check= (getWinner 'S 'L *RPSLK-rules*) 1)
(check= (getWinner 'L 'S *RPSLK-rules*) -1)
(check= (getWinner 'L 'P *RPSLK-rules*) 1)
(check= (getWinner 'P 'L *RPSLK-rules*) -1)
(check= (getWinner 'P 'K *RPSLK-rules*) 1)
(check= (getWinner 'K 'P *RPSLK-rules*) -1)
(check= (getWinner 'K 'R *RPSLK-rules*) 1)
(check= (getWinner 'R 'K *RPSLK-rules*) -1)
(check= (getWinner 'R 'S *RPSLK-rules*) 1)
(check= (getWinner 'S 'R *RPSLK-rules*) -1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; runMatches: loc x loc x rule-list -> Integer
;; (runMatches p1List p2List rules) goes through
;; pairs of symbols from the list of choices given
;; by both players.  The game stops when one
;; player has given no more choices. Add each outcome
;; to the final tally. A positive values means player 1
;; wins, negative means player 2 wins, and 0 indicates a tie.
(defunc runMatches (p1List p2List rules)
  :input-contract (and (locp p1List)
                       (locp p2List)
                       (rule-listp rules))
  :output-contract (integerp (runMatches p1List p2List rules))
  (if (or (endp p1List)(endp p2List))
    0
    (+ (getWinner (first p1List)(first p2List) rules)
       (runMatches (rest p1List)(rest p2List) rules))))


;; PLAYER 2
;(defconst *p1* (list 'S 'S 'S 'S 'S))
(defconst *p2* (list 'R 'P 'S 'L 'K))
(defconst *p3* (list 'R 'R 'R 'R 'R))
(defconst *p4* (list 'P 'P 'P 'P 'P))

(check= (runmatches *p1* *p1* *RPSLK-rules*) 0)
(check= (runmatches *p1* *p2* *RPSLK-rules*) 0)
(check= (runmatches *p1* *p3* *RPSLK-rules*) -5)
(check= (runmatches *p1* *p4* *RPSLK-rules*) 5)

(check= (runmatches *p2* *p1* *RPSLK-rules*) 0)
(check= (runmatches *p2* *p2* *RPSLK-rules*) 0)
(check= (runmatches *p2* *p3* *RPSLK-rules*) 0)
(check= (runmatches *p2* *p4* *RPSLK-rules*) 0)

(check= (runmatches *p3* *p1* *RPSLK-rules*) 5)
(check= (runmatches *p3* *p2* *RPSLK-rules*) 0)
(check= (runmatches *p3* *p3* *RPSLK-rules*) 0)
(check= (runmatches *p3* *p4* *RPSLK-rules*) -5)

(check= (runmatches *p4* *p1* *RPSLK-rules*) -5)
(check= (runmatches *p4* *p2* *RPSLK-rules*) 0)
(check= (runmatches *p4* *p3* *RPSLK-rules*) 5)
(check= (runmatches *p4* *p4* *RPSLK-rules*) 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Let's make things prettier and easier to follow. Write a
; function that runs the matches but records the person who won
; each time and the text message associated with the match.  
; For example (runMatchesMsg '(K K) '(L R) *RPSLK-rules*)
; returns (LIST (LIST 'P2 "Lizard poisons Spock")
;               (LIST 'P1 "Spock vaporizes Rock"))
; Ties should output information indicating what both players chose
; such as (LIST '- 'K)... 'K was used just to make your life easier 
; so you don't have to generate strings.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; getWinMsg: RPSLK x RPSLK x rule-list -> String
;; (getWinMsg p1 p2 rules) takes the sign from player 1 and 2
;; plus the game rules and outputs a string message indicating
;; the outcome (such as "Lizard poisons Spock"). 
;; If no rule is found, "No match" can be returned.
(defunc getWinMsg (p1 p2 rules)
  :input-contract (and (RPSLKp p1)(RPSLKp p2)(rule-listp rules))
  :output-contract (COMMON-LISP::STRINGP (getWinMsg p1 p2 rules))
  (cond ((or (equal p1 p2)(endp rules)) "No Match")
        ((or (and (equal p1 (RPSLK-rule-c1 (first rules))) 
                  (equal p2 (RPSLK-rule-c2 (first rules))))
             (and (equal p1 (RPSLK-rule-c2 (first rules))) 
                  (equal p2 (RPSLK-rule-c1 (first rules)))))
               (RPSLK-rule-outcome (first rules)))
        (t (getWinMsg p1 p2 (rest rules)))))

(check= (getWinMsg 'R 'R *RPSLK-rules*) "No Match")
(check= (getWinMsg 'P 'P *RPSLK-rules*) "No Match")
(check= (getWinMsg 'S 'S *RPSLK-rules*) "No Match")
(check= (getWinMsg 'K 'K *RPSLK-rules*) "No Match")
(check= (getWinMsg 'L 'L *RPSLK-rules*) "No Match")
(check= (getWinMsg 'S 'P *RPSLK-rules*) "Scissors cuts Paper")
(check= (getWinMsg 'P 'S *RPSLK-rules*) "Scissors cuts Paper")
(check= (getWinMsg 'P 'R *RPSLK-rules*) "Paper covers Rock")
(check= (getWinMsg 'R 'P *RPSLK-rules*) "Paper covers Rock")
(check= (getWinMsg 'R 'L *RPSLK-rules*) "Rock crushes Lizard")
(check= (getWinMsg 'L 'R *RPSLK-rules*) "Rock crushes Lizard")
(check= (getWinMsg 'K 'S *RPSLK-rules*) "Spock smashes Scissors")
(check= (getWinMsg 'S 'K *RPSLK-rules*) "Spock smashes Scissors")
(check= (getWinMsg 'S 'L *RPSLK-rules*) "Scissors decapitates Lizard")
(check= (getWinMsg 'L 'S *RPSLK-rules*) "Scissors decapitates Lizard")
(check= (getWinMsg 'L 'P *RPSLK-rules*) "Lizard eats Paper")
(check= (getWinMsg 'P 'L *RPSLK-rules*) "Lizard eats Paper")
(check= (getWinMsg 'P 'K *RPSLK-rules*) "Paper disproves Spock")
(check= (getWinMsg 'K 'P *RPSLK-rules*) "Paper disproves Spock")
(check= (getWinMsg 'K 'R *RPSLK-rules*) "Spock vaporizes Rock")
(check= (getWinMsg 'R 'K *RPSLK-rules*) "Spock vaporizes Rock")
(check= (getWinMsg 'R 'S *RPSLK-rules*) "Rock crushes Scissors")
(check= (getWinMsg 'S 'R *RPSLK-rules*) "Rock crushes Scissors")
(check= (getWinMsg 'L 'K *RPSLK-rules*) "Lizard poisons Spock")
(check= (getWinMsg 'K 'L *RPSLK-rules*) "Lizard poisons Spock")
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; genMatchMsg: RPSLK x RPSLK x rule-list -> List
;; (genMatchMsg p1 p2 rules) make a list of 2 elements,
;; typically the winner's symbol ('P1 or 'P2) plus
;; the rule string.
(defunc genMatchMsg (p1 p2 rules)
  :input-contract (and (RPSLKp p1)(RPSLKp p2)(rule-listp rules))
  :output-contract (listp (genMatchMsg p1 p2 rules))
  (if (equal p1 p2)
    (list '- p1)
    (if (equal (getWinner p1 p2 rules) 1)
      (list 'P1 (getWinMsg p1 p2 rules))
      (list 'P2 (getWinMsg p1 p2 rules)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; runMatchesMsg: loc x loc x rule-list -> List
;; (runMatchesMsg p1List p2List rules) goes through
;; pairs of symbols from the list of choices given
;; by both players. The game stops when one
;; player has given no more choices. The output list
;; consists of all match messages.
(defunc runMatchesMsg (p1List p2List rules)
  :input-contract (and (locp p1List)
                       (locp p2List)
                       (rule-listp rules))
  :output-contract (listp (runMatchesMsg p1List p2List rules))
 (if (or (endp p1List)(endp p2List))
    '()
    (cons (getWinMsg (first p1List)(first p2List) rules)
       (runMatchesMsg (rest p1List)(rest p2List) rules))))

(check= (runMatchesMsg *p1* *p3* *RPSLK-rules*) (list "Rock crushes Scissors"
                                                      "Rock crushes Scissors"
                                                      "Rock crushes Scissors"
                                                      "Rock crushes Scissors"
                                                      "Rock crushes Scissors"))
(check= (runMatchesMsg *p2* *p3* *RPSLK-rules*) (list "No Match" 
                                                      "Paper covers Rock"
                                                      "Rock crushes Scissors"
                                                      "Rock crushes Lizard"
                                                      "Spock vaporizes Rock"))
(test? (implies (and (locp p1List)(locp p2List)(rule-listp rules)) (listp (runMatchesMsg p1List p2List rules))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BONUS: Make your own game that uses the functions above
;; but have different rules, more rules, or different names
;; for the signs.  Did you play Rock-Paper-Scissors-Dynamite 
;; in Elementary school like I did? Now's your chance to explore
;; why it doesn't work well.  This question is optional with
;; minimal bonus points associated with it.  Just have fun.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
 Problem II: Potentially Useful Functions
 DEFINE, IMPROVE, or FIX the following functions.  
 Improvements should be based on the function's header comments.  
 Fixes should mean the function can be admitted into ACL2s 
 (yet still conform to the description of the function.....no 
 putting t as the  output contract or removing important function calls)
 New functions require removing the "..."s and may require you to write
 input and output contracts.
 
 A quick note about insertion sort: This algorithm works by repeatedly
 taking the first element of the input or source list and inserting
 it into the SORTED destination list.  Thus a list like '(2 1 4 3)
 would insert 2 into list '(1 3 4) and '(1 2 3 4) would be returned.
 
|#

(defdata lor (listof rational))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FIX
;; sortedp: LOR -> booleanp
;; This is a special recognizer since it only takes lists of rationals (l)
;; and returns true iff the list is sorted.
;; Edit the function so that it works.
;; NOTE: change the contract and add the (endp (rest l)) condition.
(defunc sortedp (l)
  :input-contract (lorp l)
  :output-contract (booleanp (sortedp l))
  (cond ((or (endp l) (endp (rest l))) t)
        ((> (first l) (second l))      nil)
        (t                             (sortedp (rest l)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; insert: rational x lor -> lor
;; (insert val l) takes a rational val and a list of rationals l and 
;; returns the list with val inserted in the "correct" spot such
;; that elements before val are <= val and elements after val are greater.
(defunc insert (val l)
  :input-contract (and (lorp l)(sortedp l)(rationalp val))
  :output-contract (and (lorp (insert val l)) (sortedp (insert val l)))
  (cond ((endp l) (list val))
        ((<= val (first l)) (append (list val) l))
        (t (cons (first l)(insert val (rest l))))))

(test? (implies (and (rationalp val)(sortedp l))
                (sortedp (insert val l))))
(check= (insert 5 '(1 2 3 4)) '(1 2 3 4 5))
(check= (insert 0 '(1 2 3 4)) '(0 1 2 3 4))
(check= (insert 5/2 '(1 2 3 4)) '(1 2 5/2 3 4))
(check= (insert 0 ()) '(0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; isort: lor -> lor (sorted)
;; (isort l) takes a list of rational numbers l
;; and returns a sorted list with the same elements.
;; Sorting is done using the insertion sort algorithm only
;; (hence isort). You may not write another sorting algorithm.
(defunc isort (l)
  :input-contract (lorp l)
  :output-contract (and (lorp (isort l))(sortedp (isort l)))
                       ; (equal (len l)(len (isort l)))) 
                        ; This breaks subset-lor for reasons beyond me - ACL2s bug?
  (if (endp l) ()
      (insert (first l)(isort (rest l)))))

;; ADD tests for isort and insert including a minimum
;; of one test? if this has been covered in lecture before Monday.
(test? (implies (lorp l) (and (sortedp (isort l))(equal (len l)(len isort l)))))
(test? (implies (endp l) (equal (isort l) ())))
(check= (isort '()) ())
(check= (isort '(5 4 3 2 1)) '(1 2 3 4 5))
(check= (isort '(1 3 5 2 4 6)) '(1 2 3 4 5 6)) 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HELPER FUNCTION (Given)
;; subset-lor: LOR x Nat -> LOR
;; (subset-lor l n) take a list l and a natural number n
;; and returns the last n elements in l.  If n > (len l)
;; then return l.
(defunc subset-lor (l n)
  :input-contract (and (lorp l)(natp n))
  :output-contract (lorp (subset-lor l n))
  (if (>= n (len l))
    l
    (subset-lor (rest l) n)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; top-n-values: lor x nat -> lor
;; (top-n-values l n) takes a list of rational numbers l
;; and a natural number n and returns a list of 
;; the n largest numbers in l
(defunc top-n-values (l n)
  :input-contract (and (lorp l)(natp n))
  :output-contract (lorp (top-n-values l n))
  (if (>= n (len l))
    l
    (subset-lor (isort l) n)))
    

(check= (top-n-values '(1 2 3 4 5 6 7) 5) '(3 4 5 6 7))
(check= (top-n-values '(1 2 3 4 5 6 7) 17) '(1 2 3 4 5 6 7))
(check= (top-n-values '(7 6 5 4 3 2 1) 5) '(3 4 5 6 7))
(check= (top-n-values '(17 -15 3/2 5 0 -3/2 32/3) 5) '(0 3/2 5 32/3 17))
(check= (top-n-values nil 5) nil)
(check= (top-n-values '(1 2 3 4 5) 0) nil)
(check= (top-n-values '(1 2 3 4 5) 1) '(5))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FIX the input contract
;; ith-rational: LOR x Integer -> Rational
;;
;; (ith-rational l i) takes a list or rationals l and an index i
;; and returns the list element at position i (the first element
;; is element 0).
;; This function should not work for invalid input thus you probably
;; need to check for more than valid data types.
(defunc ith-rational (l i)
  :input-contract (and (lorp l)(natp i)(< i (len l)))
  :output-contract (rationalp (ith-rational l i))
  (if (equal i 0)
    (first l)
    (ith-rational (rest l) (- i 1))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN (you wrote this for HW02)
;; nat/: Nat x Nat-{0} -> Nat
;; (nat/ x y) takes a natural number x and a positive integer
;; y and returns x / y rounded down to the nearest natural number
(defunc nat/ (x y)
  :input-contract (and (natp x)(posp y))
  :output-contract (natp (nat/ x y))
  (if (< x y)
    0
    (+ 1 (nat/ (- x y) y))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; median: lor (not empty) -> rational
;; (median l) take a list of rational numbers and returns
;; the number with half of l being smaller or equal and the other 
;; half being larger or equal.
;; Odd sized lists should return the (floor (len/2))th smallest element.
;; Even sized lists should return element len/2
(defunc median (l)
  :input-contract (and (lorp l)(not (endp l)))
  :output-contract (rationalp (median l))
  (if (< (nat/ (len l) 2) (len (isort l)))
    (ith-rational (isort l) (nat/ (len l) 2))
    0)) ; Per Piazza note @146, I think due to len check in isort bug
  
;; Add your own tests here.
(check= (median '(1 2 3 4 5)) 3)
(check= (median '(5 2 4 3 1)) 3)
(check= (median '(3 1 2 4)) 3)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question III
;; Student Grade Data Definitions
;;
;; Soon I will be asking you to write a program which determines
;; your mark in the course (given that BB stinks for handling
;; dropped grades). Note, this also means that at the end of term, if
;; you ask us what your grade is or why blackboard is saying X, we will
;; point you to this assignment.
;; However, first I want to define how we can store these data 
;; (FYI: data is the plural of datum)
;; Each grade will be a record storing student ID, section,
;; professor, grade type, exam/hw/quiz number, and the grade.
;; For each grade the maximum value will be associated with 
;; the grade type
;; For example HW02 for John Smith (ID: 123456) in section 3 could take the form:
;; (grade-rec 123456 2 'Sprague ('assignment 2 80))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; First define an enumerated datatype for evaluation type 
;; (exam, assignment or quiz).
;; DEFINE
(defdata grade-type (enum '(Exam Assignment Quiz)))

(check= (grade-typep 'exam) t)
(check= (grade-typep 'assign) nil)
(check= (grade-typep 'assignment) t)
(check= (grade-typep 'quiz) t)

;; Define the section number as a number between 1 and 5 (inclusive)
;; Professor Wahl teaches Section 1 (9:15), 
;; Professor Manolios teaches 3 (1:35) and 5 (4:35)
;; and I (Sprague) teach sections 2 (9:15) and 4 (1:35)
; DEFINE
(defdata section-number (range integer (1 <= _ <= 5)))

(check= (section-numberp 1) t)
(check= (section-numberp 0) nil)
(check= (section-numberp 1/2) nil)
(check= (section-numberp -1) nil)

;; The enumerated set of three instructors
(defdata instructor (enum '(Manolios Wahl Sprague)))
(check= (instructorp 'Manolios) t)
(check= (instructorp 'Spragoo) nil)
(check= (instructorp 'BigJerk) nil) 
; Note: It really is nil even if you want to call me that.

;; Student IDs consist of positive numbers 6 to 10 digits long (assuming
;; no preceding 0s). DEFINE the permitted range
(defdata studentID (range integer (100000 <= _ <= 9999999999)))

(check= (studentIDp 1234) nil)
(check= (studentIDp 1234567) t)
(check= (studentIDp 000001) nil)

;; Student exam and assignment grades are exclusively between 0 and 100 
;; but can include part marks. Quiz grades are between 0 and 24 and are
;; integers.
;; Make data definitions (ranges) to represent valid student grades.
(defconst *quiz-max* 24)
(defdata pct-range (range rational (0 <= _ <= 100)))
(defdata quiz-range (range integer (0 <= _ <= *quiz-max*)))

(check= (pct-rangep 1/2) t)
(check= (quiz-rangep 1/2) nil)
(check= (pct-rangep 50) t)
(check= (quiz-rangep 50) nil)

;; Define information for the 3 different evalution types
;; with each type having a type, number (positive number) and grade.
(defdata quiz-grade (list 'Quiz integer quiz-range))
(defdata assignment-grade (list 'Assignment integer pct-range))
(defdata exam-grade (list 'Exam integer pct-range))
;; Union the 3 evaluation types.
(defdata eval-grade (oneof quiz-grade exam-grade assignment-grade))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The grades of each type are numbered, starting from 1. For example, hw02
;; is the assignment grade with number 2. Define a record type that
;; specifies a student id, section, prof, and grade 
;; (grade type, grade number and score).  
;; The field names should be id, section, prof and grade 
;; Define this record type:
(defdata grade-rec (record (id . studentID) (section . section-number) (prof . instructor) (grade . eval-grade)))

(check= (grade-rec-grade (grade-rec 1234567 3 'Manolios (list 'assignment 5 85))) '(assignment 5 85))
(check= (grade-rec-prof (grade-rec 1234567 3 'Manolios (list 'assignment 5 85))) 'Manolios)
(check= (grade-rec-section (grade-rec 1234567 3 'Manolios (list 'assignment 5 85))) 3)
(check= (grade-rec-id (grade-rec 1234567 3 'Manolios (list 'assignment 5 85))) 1234567)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Finally, the spreadsheet of all grades in the course is a list of grade
;; records.....not truly a spreadsheet but this code addresses the needs 
;; Excel would usually address.
(defdata grade-spreadsheet (listof grade-rec))

(check= (grade-spreadsheetp (list (grade-rec 1234567 3 'Manolios (list 'assignment 5 85)))) t)

;; Notice these two calls will not be admitted if uncommented. 
;(grade-recp (first (list (grade-rec 1234567 2 'Sprague 'quiz 5 12))))

;; The quiz value is out of range (max is 24) and the grade-rec 
;; cannot be created.
; (grade-rec 1234567 2 'Sprague '(quiz 13 88)) 

(check= (grade-recp (first (list (grade-rec 1234567 4 'Sprague '(quiz 5 12))
                                 (grade-rec 1234567 4 'Sprague '(assignment 2 88))
                                 (grade-rec 7654321 1 'Wahl '(quiz 5 24))))) t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; To avoid having to keep typing a long list of grade records, it is handy
; to define a global constant which can then be used for many check= tests.
; You should put all of the grades of your team in a spreadsheet. Use your
; group name for the name of this spreadsheet. Your spreadsheet should
; contain your actual grades, but do not use your actual NEU ids as your
; student ids (confidentiality). Your check= tests should use your own 
; spreadsheet. Here is a modifiable example

; What concept is this portion of the homework teaching? What a constant is?
; How to define one? There isn't anything novel here to check= on, I'm confident
; that grade-rec works from above and I'm confident that list works as a builtin
(defconst *cs2800* (list (grade-rec 1234567 2 'Sprague '(assignment 5 85))
                         (grade-rec 1234567 2 'Sprague '(quiz 4 18))
                         (grade-rec 1234567 2 'Sprague '(quiz 3 12))
                         (grade-rec 55555555 1 'Wahl '(assignment 4 75))
                         (grade-rec 55555555 1 'Wahl '(quiz 2 12))
                         (grade-rec 55555555 1 'Wahl '(quiz 1 24))))

(check= (third (grade-rec-grade (first (rest *cs2800*)))) 18)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Part IV: Calculating your average
;; Since each person gets the same number of dropped assignments, 
;; quizzes, and exams, define the number of COUNTED grades for 
;; each type as constants. If we decide to drop more quizzes later
;; in the term, you would change one number.

;; Note: These constants will be useful later in the program
(defconst *num-assignments* 10)
(defconst *num-exams* 2)
(defconst *num-quizzes* 20)

(defconst *pct-assignments* 20)
(defconst *pct-quizzes* 20)
(defconst *pct-exams* 60)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; student-marks-list: grade-spreadsheet x studentID -> grade-spreadsheet
;;
;; (student-marks-list l sn)
;; From a list of grade record scores (l), extract all entries
;; associated with a given student number (sn)
(defunc student-marks-list (l sn)
  :input-contract (and (grade-spreadsheetp l)(studentIDp sn))
  :output-contract (grade-spreadsheetp (student-marks-list l sn))
  (if (endp l)
    nil
    (if (equal (grade-rec-id (first l)) sn)
      (app (list (first l)) (student-marks-list (rest l) sn))
      (app nil (student-marks-list (rest l) sn)))))

(check= (student-marks-list *cs2800* 1234567) (list (grade-rec 1234567 2 'Sprague '(assignment 5 85))
                                                    (grade-rec 1234567 2 'Sprague '(quiz 4 18))
                                                    (grade-rec 1234567 2 'Sprague '(quiz 3 12))))
(check= (student-marks-list *cs2800* 55555555) (list (grade-rec 55555555 1 'Wahl '(assignment 4 75))
                                                     (grade-rec 55555555 1 'Wahl '(quiz 2 12))
                                                     (grade-rec 55555555 1 'Wahl '(quiz 1 24))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; get-grade-score: grade-rec -> rational
;; (get-grade-score rec) returns the grade from
;; a record rec.
(defunc get-grade-score (rec)
  :input-contract (grade-recp rec)
  :output-contract (rationalp (get-grade-score rec))
  (third (grade-rec-grade rec)))

(check= (get-grade-score (grade-rec 55555555 1 'Wahl '(assignment 4 75)))
        75)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; get-grade-type: grade-rec -> grade-type
;; (get-grade-type rec) returns the grade type from
;; a record rec.
(defunc get-grade-type (rec)
  :input-contract (grade-recp rec)
  :output-contract (grade-typep (get-grade-type rec))
  (first (grade-rec-grade rec)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; type-marks-list: grade-spreadsheet x grade-type -> grade-spreadsheet
;; (type-marks-list l type) takes a grade-spreadsheet plus a grade type 
;; and returns all records associated with that grade type.
(defunc type-marks-list (l type)
  :input-contract (and (grade-spreadsheetp l)(grade-typep type))
  :output-contract (grade-spreadsheetp (type-marks-list l type))
  (if (endp l)
    nil
    (if (equal (get-grade-type (first l)) type)
      (app (list (first l)) (type-marks-list (rest l) type))
      (app nil (type-marks-list (rest l) type)))))

; LOL this function is literally just student-marks-list again, I feel like
; I should wrap them into a single abstracted fucnction with an additonal param
; But I don't know if that's even possible in this language.

(check= (type-marks-list *cs2800* 'quiz) (list (grade-rec 1234567 2 'Sprague '(quiz 4 18))
                                               (grade-rec 1234567 2 'Sprague '(quiz 3 12))
                                               (grade-rec 55555555 1 'Wahl '(quiz 2 12))
                                               (grade-rec 55555555 1 'Wahl '(quiz 1 24))))

(check= (type-marks-list *cs2800* 'assignment) (list (grade-rec 1234567 2 'Sprague '(assignment 5 85))
                                                     (grade-rec 55555555 1 'Wahl '(assignment 4 75))))

(check= (type-marks-list *cs2800* 'exam) '())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; extract-scores: grade-spreadsheet -> List of Rational
;; (extract-scores l) takes a list of grade records and 
;; extracts the score from each record to return a list of rationals
(defunc extract-scores (l)
  :input-contract (grade-spreadsheetp l)
  :output-contract (lorp (extract-scores l))
  (if (endp l)
    nil
    (cons (get-grade-score (first l)) 
          (extract-scores (rest l)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN Helper Method
;; sum-lor: LOR -> rational
;; (sum-lor l) take a list of rationals l and returns the sum
;; of their values.
(defunc sum-lor (l)
  :input-contract (lorp l)
  :output-contract (rationalp (sum-lor l))
  (if (endp l)
    0
    (+ (first l) (sum-lor (rest l)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; mean-top-n: grade-spreadsheet x pos -> rational
;; (mean-top-n l n) takes a list of grade records l
;; and the maximum number of entries to keep n and 
;; returns the mean/average of the highest n scores in l.
(defunc mean-top-n (l n)
  :input-contract (and (grade-spreadsheetp l) (posp n) (not (endp l)))
  :output-contract (rationalp (mean-top-n l n))
  (if (>= n (len l))
    (/ (sum-lor (extract-scores l)) (len l))  ; if n is larger than the length of l, return the total average
    (/ (sum-lor (top-n-values (extract-scores l) n)) n))) ; if n is smaller than length of l, return the average of top n

(check= (mean-top-n (list (grade-rec 1234567 2 'Sprague '(quiz 4 18))
                          (grade-rec 1234567 2 'Sprague '(quiz 3 12))
                          (grade-rec 55555555 1 'Wahl '(quiz 2 12))
                          (grade-rec 55555555 1 'Wahl '(quiz 1 24)))
                  1) 
        24)
(check= (mean-top-n (list (grade-rec 1234567 2 'Sprague '(quiz 4 18))
                          (grade-rec 1234567 2 'Sprague '(quiz 3 12))
                          (grade-rec 55555555 1 'Wahl '(quiz 2 12))
                          (grade-rec 55555555 1 'Wahl '(quiz 1 24)))
                  2) 
        21)
(check= (mean-top-n (list (grade-rec 1234567 2 'Sprague '(quiz 4 18))
                          (grade-rec 1234567 2 'Sprague '(quiz 3 12))
                          (grade-rec 55555555 1 'Wahl '(quiz 2 12))
                          (grade-rec 55555555 1 'Wahl '(quiz 1 24)))
                  3) 
        18)
(check= (mean-top-n (list (grade-rec 1234567 2 'Sprague '(quiz 4 18))
                          (grade-rec 1234567 2 'Sprague '(quiz 3 12))
                          (grade-rec 55555555 1 'Wahl '(quiz 2 12))
                          (grade-rec 55555555 1 'Wahl '(quiz 1 24)))
                  4) 
        33/2)
(check= (mean-top-n (list (grade-rec 1234567 2 'Sprague '(quiz 4 18))
                          (grade-rec 1234567 2 'Sprague '(quiz 3 12))
                          (grade-rec 55555555 1 'Wahl '(quiz 2 12))
                          (grade-rec 55555555 1 'Wahl '(quiz 1 24)))
                  5) 
        33/2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; calc-grade-hlp: Rational x Rational x Pos -> Rational
;; (calc-grade-hlp total pct max) is a helper function for calc-grade
;; which takes in the mean top n grades for a mark type (mean), 
;; the percent that grade type is worth for your total grade (pct) 
;; and the maximum score permitted for one of these grades (max)
;; and returns the value the grade type contributes to your final grade
;; (thus an average of 90% on 10 homeworks would return 18
;; and the call would be (calc-grade-hlp 90 20 100)
;; This helper method just make it easier for ACL2s to prove contracts.
(defunc calc-grade-hlp (mean pct max)
  :input-contract (and (rationalp mean)
                       (rationalp pct)
                       (posp max))
  :output-contract (rationalp (calc-grade-hlp mean pct max))
  (/ (* mean pct) max))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; calc-grade: grade-spradsheet x studentID -> rational
;; (calc-grade l sn) takes a grade spreadsheet l and a student number sn
;; extracts all records for that student and for each assignment
;; type calculates the mark to be given.  Summing the results from 
;; each calc-mark call should give the final percent in the course.
(defunc calc-grade (l sn)
  :input-contract (and (grade-spreadsheetp l) (studentIDp sn))
  :output-contract (rationalp (calc-grade l sn))
  (let* ((grades (student-marks-list l sn)) ; returns a grade-spreadsheet
         (quizzes (type-marks-list grades 'quiz)) ; returns a grade-spreadsheet of quizzes
         (assigs (type-marks-list grades 'assignment)) ; returns a grade-spreadsheet of assignments
         (exams (type-marks-list grades 'exam))) ; returns a grade-spreadsheet of exams
         
    (+ (if (endp quizzes)
         0
         (calc-grade-hlp (mean-top-n quizzes *num-quizzes*) *pct-quizzes* *quiz-max*))
       (+ (if (endp exams)
            0
            (calc-grade-hlp (mean-top-n exams *num-exams*) *pct-exams* 100))
          (if (endp assigs)
            0
            (calc-grade-hlp (mean-top-n assigs *num-assignments*) *pct-assignments* 100))))))
            

;; Another set of marks to test your code against.
(defconst *cs2800-Test* (list (grade-rec 1234567 2 'Sprague '(quiz 22 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 21 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 20 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 19 24))
                              (grade-rec 1234567 2 'Sprague '(quiz 18 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 17 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 16 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 15 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 14 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 13 12))
                              (grade-rec 1234567 2 'Sprague '(quiz 12 12))
                              (grade-rec 1234567 2 'Sprague '(quiz 11 12))
                              (grade-rec 1234567 2 'Sprague '(quiz 10 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 9 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 8 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 7 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 6 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 5 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 4 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 3 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 2 18))
                              (grade-rec 1234567 2 'Sprague '(quiz 1 18))
                              (grade-rec 1234567 2 'Sprague '(assignment 11 75))
                              (grade-rec 1234567 2 'Sprague '(assignment 10 75))
                              (grade-rec 1234567 2 'Sprague '(assignment 9 75))
                              (grade-rec 1234567 2 'Sprague '(assignment 8 0))
                              (grade-rec 1234567 2 'Sprague '(assignment 7 75))
                              (grade-rec 1234567 2 'Sprague '(assignment 6 65))
                              (grade-rec 1234567 2 'Sprague '(assignment 5 55))
                              (grade-rec 1234567 2 'Sprague '(assignment 4 85))
                              (grade-rec 1234567 2 'Sprague '(assignment 3 95))
                              (grade-rec 1234567 2 'Sprague '(assignment 2 70))
                              (grade-rec 1234567 2 'Sprague '(assignment 1 80))
                              (grade-rec 1234567 2 'Sprague '(exam 2 65))
                              (grade-rec 1234567 2 'Sprague '(exam 2 75))))
(check= (calc-grade *cs2800-Test* 1234567) 
        (+ (* 20 18/24) (+ (* 20 75/100) (* 60 70/100))))

; Proper scope for tests is to test only the function and not the sub-functions, as the sub-
; functions should have their own test cases. Therefore, the following test cases are not
; necessary, as they are redundant:
; 1. A test where the original spreadsheet has multiple students (tested in student-marks-list)

; Test cases with no 'exam, 'quiz, or 'assignment in them are necessary, as mean-top-n will not
; take an empty list if it is the result of a call to type-marks-list (which can return the empty list)
; and a guard against this is written into the calc-grade function.

(defconst *cs2800-Test-noQuiz* (list (grade-rec 1234567 2 'Sprague '(assignment 11 75))
                                     (grade-rec 1234567 2 'Sprague '(assignment 10 75))
                                     (grade-rec 1234567 2 'Sprague '(assignment 9 75))
                                     (grade-rec 1234567 2 'Sprague '(assignment 8 0))
                                     (grade-rec 1234567 2 'Sprague '(assignment 7 75))
                                     (grade-rec 1234567 2 'Sprague '(assignment 6 65))
                                     (grade-rec 1234567 2 'Sprague '(assignment 5 55))
                                     (grade-rec 1234567 2 'Sprague '(assignment 4 85))
                                     (grade-rec 1234567 2 'Sprague '(assignment 3 95))
                                     (grade-rec 1234567 2 'Sprague '(assignment 2 70))
                                     (grade-rec 1234567 2 'Sprague '(assignment 1 80))
                                     (grade-rec 1234567 2 'Sprague '(exam 2 65))
                                     (grade-rec 1234567 2 'Sprague '(exam 2 75))))

(defconst *cs2800-Test-noExam* (list (grade-rec 1234567 2 'Sprague '(quiz 22 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 21 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 20 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 19 24))
                                     (grade-rec 1234567 2 'Sprague '(quiz 18 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 17 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 16 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 15 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 14 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 13 12))
                                     (grade-rec 1234567 2 'Sprague '(quiz 12 12))
                                     (grade-rec 1234567 2 'Sprague '(quiz 11 12))
                                     (grade-rec 1234567 2 'Sprague '(quiz 10 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 9 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 8 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 7 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 6 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 5 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 4 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 3 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 2 18))
                                     (grade-rec 1234567 2 'Sprague '(quiz 1 18))
                                     (grade-rec 1234567 2 'Sprague '(assignment 11 75))
                                     (grade-rec 1234567 2 'Sprague '(assignment 10 75))
                                     (grade-rec 1234567 2 'Sprague '(assignment 9 75))
                                     (grade-rec 1234567 2 'Sprague '(assignment 8 0))
                                     (grade-rec 1234567 2 'Sprague '(assignment 7 75))
                                     (grade-rec 1234567 2 'Sprague '(assignment 6 65))
                                     (grade-rec 1234567 2 'Sprague '(assignment 5 55))
                                     (grade-rec 1234567 2 'Sprague '(assignment 4 85))
                                     (grade-rec 1234567 2 'Sprague '(assignment 3 95))
                                     (grade-rec 1234567 2 'Sprague '(assignment 2 70))
                                     (grade-rec 1234567 2 'Sprague '(assignment 1 80))))

(defconst *cs2800-Test-noAssignment* (list (grade-rec 1234567 2 'Sprague '(quiz 22 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 21 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 20 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 19 24))
                                           (grade-rec 1234567 2 'Sprague '(quiz 18 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 17 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 16 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 15 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 14 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 13 12))
                                           (grade-rec 1234567 2 'Sprague '(quiz 12 12))
                                           (grade-rec 1234567 2 'Sprague '(quiz 11 12))
                                           (grade-rec 1234567 2 'Sprague '(quiz 10 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 9 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 8 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 7 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 6 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 5 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 4 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 3 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 2 18))
                                           (grade-rec 1234567 2 'Sprague '(quiz 1 18))
                                           (grade-rec 1234567 2 'Sprague '(exam 2 65))
                                           (grade-rec 1234567 2 'Sprague '(exam 2 75))))

(check= (calc-grade *cs2800-Test-noAssignment* 1234567) 
        (+ (* 20 18/24) (+ (* 20 0) (* 60 70/100))))
(check= (calc-grade *cs2800-Test-noQuiz* 1234567) 
        (+ (* 20 0) (+ (* 20 75/100) (* 60 70/100))))
(check= (calc-grade *cs2800-Test-noExam* 1234567) 
        (+ (* 20 18/24) (+ (* 20 75/100) (* 60 0))))
(check= (calc-grade '() 1234567) 0)#|ACL2s-ToDo-Line|#
