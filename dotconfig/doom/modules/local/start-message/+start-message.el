;;; modules/local/start-message/+start-message.el -*- lexical-binding: t; -*-

(defvar *code-quotes*
  '(
     "Most of the biggest problems in software are problems of misconception. - Rich Hickey"
     "Don't have good ideas if you aren't willing to be responsible for them. - Alan Perlis"
     "Fools ignore complexity. Pragmatists suffer it. Some can avoid it. Geniuses remove it. - Alan Perlis"
     "The most important property of a program is whether it accomplishes the intention of its user. - C.A.R. Hoare"
     "Inside every large program, there is a small program trying to get out. - C.A.R. Hoare"
     "Organizations which design systems are constrained to produce designs which are copies of the communication structures of these organizations. - Conway's Law"
     "Just because something is easy to measure doesn't mean it's important. - D.H.H."
     "A program is like a poem: you cannot write a poem without writing it. - E.W. Dijkstra"
     "Simplicity is prerequisite for reliability. - E.W. Dijkstra"
     "Good programmers don't just write programs. They build a working vocabulary. - Guy Steele"
     "Machines should work. People should think. - IBM Pollyanna Principle"
     "A user interface should be so simple that a beginner in an emergency can understand it within ten seconds. - Ted Nelson"
     "Make it work first before you make it work fast. - Bruce Whiteside"
     "If you aren't sure which way to do something, do it both ways and see which works better. - John Carmack"
     "Premature optimizations can be troublesome to revert, but premature generalizations are often near impossible. - Emil Persson"
     "In programming, the hard part isn't solving problems, but deciding what problems to solve. - Paul Graham"
     "If we want users to like our software we should design it to behave like a likeable person: respectful, generous and helpful. - Alan Cooper"
     "The lurking suspicion that something could be simplified is the world's richest source of rewarding challenges. - Edsger Dijkstra"
     "The computing scientist's main challenge is not to get confused by the complexities of his own making. - E. W. Dijkstra"
     "Simple things should be simple, complex things should be possible. - Alan Kay"
     "Simplicity and elegance are unpopular because they require hard work and discipline to achieve and education to be appreciated. - E.W. Dijkstra"
     "Any fool can write code that a computer can understand.  Good programmers write code that humans can understand. - Martin Fowler"
     "The purpose of abstraction is not to be vague, but to create a new semantic level in which one can be absolutely precise - Edsger Dijkstra"
     "The computer programmer is a creator of universes for which he alone is responsible. - Joseph Weizenbaum"
     "The effective exploitation of his powers of abstraction [is] one of the most vital activities of a competent programmer. - Edsger Dijkstra"
     "No matter how slow you are writing clean code, you will always be slower if you make a mess. - Uncle Bob Martin"
     "Good judgement is the result of experience. Experience is the result of bad judgement. - Fred Brooks"
     "It always takes longer than you expect, even when you take into account Hofstadter's Law. — Hofstadter's Law"
     "One accurate measurement is worth more than a thousand expert opinions. - Admiral Grace Hopper"
     "The products of normal engineering have requirements, but the products of radical engineering have only hopes and aspirations. - Alan Perlis"
     "Premature formalisation cripples understanding of the physical problem world. - Alan Perlis"
     "Administrative systems can sometimes define problem world states in terms of the computer state; cyber-physical systems must be more honest. - Alan Perlis"
     "You can't determine what went wrong unless you understand exactly what going right would have been. - Alan Perlis"
     "We lack suitable formalisations for causality, but the physical world doesn't know that. - Alan Perlis"
     "A system is not a device: devices have users, but systems have participants. - Alan Perlis"))


(defun mb/fortune ()
  (nth (random (length *code-quotes*)) *code-quotes*))

(setq-default initial-scratch-message
  (concat ";; " (mb/fortune) "\n\n"))

(setq initial-major-mode 'emacs-lisp-mode)
