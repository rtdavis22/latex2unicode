"Copyright (c) 2011, Robert Davis

"Permission is hereby granted, free of charge, to any person obtaining 
"a copy of this software and associated documentation files (the "Software"),
"to deal in the Software without restriction, including without limitation
"the rights to use, copy, modify, merge, publish, distribute, sublicense, 
"and/or sell copies of the Software, and to permit persons to whom the 
"Software is furnished to do so, subject to the following conditions:

"The above copyright notice and this permission notice shall be included in 
"all copies or substantial portions of the Software.

"THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
"OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
"FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
"AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
"LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
"OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
"THE SOFTWARE.

let s:Mappings = [
	\ "CapitalGreek",
	\ "LowerGreek",
	\ "SpecialSets",
	\ "RelationalOperators",
	\ "BinaryOperators",
\]  

let s:CapitalGreek = {
	\ "Gamma$":    "Γ", "Delta$":   "Δ", "Theta$":   "Θ",
	\ "Lambda$":   "Λ", "Xi$":      "Ξ", "Pi$":      "Π",
	\ "Sigma$":    "Σ", "Phi$":     "Φ", "Psi$":     "Ψ",
	\ "Omega$":    "Ω",
\}

let s:LowerGreek = {
	\ "alpha$":   "α", "beta$":    "β", "gamma$":   "γ",
	\ "delta$":   "δ", "epsilon$": "ε", "zeta$":    "ζ",
	\ "eta$":     "η", "theta$":   "θ", "iota$":    "ι",
	\ "kappa$":   "κ", "lamda$":   "λ", "mu$":      "μ",
	\ "nu$":      "ν", "xi$":      "ξ", "omicron$": "ο",
	\ "pi$":      "π", "rho$":     "ρ", "sigma$":   "σ",
	\ "tau$":     "τ", "upsilon$": "υ", "phi$":     "ϕ",
	\ "chi$":     "χ", "psi$":     "ψ", "omega$":   "ω"
\}

let s:SpecialSets = {
	\ "complex$":  "ℂ",
	\ "natural$":  "ℕ",
	\ "rational$": "ℚ",
	\ "real$":     "ℝ",
	\ "integer$":  "ℤ",
\}

let s:RelationalOperators = {
        \ "leq$":        "≤", "geq$":        "≥", "equiv$":      "≡",
        \ "prec$":       "≺", "succ$":       "≻", "sim$":        "∼",
        \ "preceq$":     "≼", "succeq$":     "≽", "simeq$":      "≃",
        \ "ll$":         "≪", "gg$":         "≫", "asymp$":      "≍",
        \ "subset$":     "⊂", "supset$":     "⊃", "approx$":     "≈",
        \ "subseteq$":   "⊆", "supseteq$":   "⊇", "cong$":       "≅",
        \ "sqsubset$":   "⊏", "sqsupset$":   "⊐", "neq$":        "≠",
        \ "sqsubseteq$": "⊑", "sqsupseteq$": "⊒", "doteq$":      "?",
        \ "in$":         "∈", "ni$":         "∋", "vdash$":      "⊢",
        \ "dashv$":      "⊣", "models$":     "⊧", "perp$":       "⊥",
        \ "mid$":        "∣", "parallel$":   "∥", "bowtie$":     "⋈",
        \ "Join$":       "⋈", "smile$":      "?", "frown$":      "?",
        \ "propto$":     "∝", "notin$":      "∉"
\}

let s:BinaryOperators = {
        \        
\}

execute "set iskeyword=" . escape( &iskeyword, '\' ) . ',\$'

let s:AllMappings = {}

for dict in s:Mappings	
  execute "call extend( s:AllMappings, s:" . dict . " )"
endfor

for name in keys( s:AllMappings )
  execute "iab " . '$' . name  . " " . s:AllMappings[name] 
endfor

function! DetexLine()
  let start = getpos('.')
  if search("\\$", 'b', line('.')) > 0
     if search("\\$", 'b', line('.')) > 0
       exe ".s/\\$_\\([0-9]\\+\\)\\$/\\=ToSubscript(submatch(1))/e"
       exe ".s/\\$\\^\\([0-9]\\+\\)\\$/\\=ToSuperscript(submatch(1))/e"
     endif
  endif
  call setpos('.', start)
endfunction
autocmd CursorMovedI * call DetexLine()

function! ToSubscript(str)
  let ret = a:str
  let ret =  substitute(ret,"0","₀","g")
  let ret =  substitute(ret,"1","₁","g")
  let ret =  substitute(ret,"2","₂","g")
  let ret =  substitute(ret,"3","₃","g")
  let ret =  substitute(ret,"4","₄","g")
  let ret =  substitute(ret,"5","₅","g")
  let ret =  substitute(ret,"6","₆","g")
  let ret =  substitute(ret,"7","₇","g")
  let ret =  substitute(ret,"8","₈","g")
  let ret =  substitute(ret,"9","₉","g")
  return ret
endfunction

function! ToSuperscript(str)
  let ret = a:str
  let ret =  substitute(ret,"0","⁰","g")
  let ret =  substitute(ret,"1","¹","g")
  let ret =  substitute(ret,"2","²","g")
  let ret =  substitute(ret,"3","³","g")
  let ret =  substitute(ret,"4","⁴","g")
  let ret =  substitute(ret,"5","⁵","g")
  let ret =  substitute(ret,"6","⁶","g")
  let ret =  substitute(ret,"7","⁷","g")
  let ret =  substitute(ret,"8","⁸","g")
  let ret =  substitute(ret,"9","⁹","g")
  return ret
endfunction

