;; extends

;; Remove a cor de string (amarelo) da interpolação inteira
((interpolation) @none
 (#set! priority 120))

;; Destaca as chaves {}
(interpolation
  "{" @punctuation.special.python
  "}" @punctuation.special.python
  (#set! priority 125))

;; Destaca a variável dentro das chaves
(interpolation
  (identifier) @variable.python
  (#set! priority 125))
