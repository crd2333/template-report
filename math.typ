#import "@preview/quick-maths:0.1.0": shorthands
#import "@preview/mitex:0.2.4": *

// 以类似格式添加符号缩写
#let shorthand = shorthands.with(
  ($+-$, $plus.minus$),
  ($|-$, math.tack),
  ($=<$, $<=$),                // =< becomes '≤'
  ($<==$, math.arrow.l.double), // Replaces '≤'，似乎需要某一边有东西才能正常工作，原因未知
  ($~$, $med$),
)

// 文本运算符
#let argmax = math.op("argmax", limits: true)
#let argmin = math.op("argmin", limits: true)

#let dcases(..args) = math.cases(..args.pos().map(math.display)) // cases with display style

#let cnum(num) = str.from-unicode(9311 + num)  // 带圈数字

// 以类似格式添加文本缩写
#let le = $<=$
#let ge = $>=$
#let Pi = $product$ // big pi as product
#let infty = $infinity$
#let int = $integral$
#let wave = $tilde$ // alternative to ~
// $wave$, $prop$, $approx$
#let na = $nabla$
#let di = $dif$
#let pa = $diff$ // partial
#let ij = $i j$
#let ji = $j i$

// 希腊字母
#let r1 = $rho_1$
#let r2 = $rho_2$
#let si = $sigma$
#let Si = $Sigma$
#let s1 = $sigma_1$
#let s2 = $sigma_2$
#let de = $delta$
#let De = $Delta$
#let d1 = $delta_1$
#let D1 = $Delta_1$
#let d2 = $delta_2$
#let D2 = $Delta_2$
#let al = $alpha$
#let a1 = $alpha_1$
#let a2 = $alpha_2$
#let an = $alpha_n$
#let aN = $alpha_N$
#let ta = $tau$
#let th = $theta$
#let t1 = $theta_1$
#let t2 = $theta_2$
#let tn = $theta_n$
#let tN = $theta_N$
#let ep = $epsilon$
#let ep1 = $epsilon_1$
#let ep2 = $epsilon_2$
#let ga = $gamma$
#let g1 = $gamma_1$
#let g2 = $gamma_2$
#let la = $lambda$
#let l1 = $lambda_1$
#let l2 = $lambda_2$
#let ln = $lambda_n$
#let lN = $lambda_N$
#let La = $Lambda$
#let L1 = $Lambda_1$
#let L2 = $Lambda_2$
#let Ln = $Lambda_n$
#let LN = $Lambda_N$
#let p1 = $pi_1$
#let p2 = $pi_2$
#let pn = $pi_n$
#let pN = $pi_N$

// bold, hat, tilde, arrow letters
#let bx = math.bold("x")
#let by = math.bold("y")
#let bz = math.bold("z")
#let bs = math.bold("s")
#let bt = math.bold("t")
#let bu = math.bold("u")
#let bv = math.bold("v")
#let bw = math.bold("w")
#let ba = math.bold("a")
#let bb = math.bold("b")
#let bc = math.bold("c")
#let bd = math.bold("d")
#let be = math.bold("e")
#let bf = math.bold("f")
#let bg = math.bold("g")
#let bh = math.bold("h")
#let bi = math.bold("i")
#let bj = math.bold("j")
#let bk = math.bold("k")
// letters with hat
#let hx = $hat(x)$
#let hy = $hat(y)$
#let hz = $hat(z)$
#let hs = $hat(s)$
#let ht = $hat(t)$
#let hu = $hat(u)$
#let hv = $hat(v)$
#let hw = $hat(w)$
#let ha = $hat(a)$
#let hb = $hat(b)$
#let hc = $hat(c)$
#let hd = $hat(d)$
#let he = $hat(e)$
#let hf = $hat(f)$
#let hg = $hat(g)$
#let hh = $hat(h)$
#let hi = $hat(i)$
#let hj = $hat(j)$
#let hk = $hat(k)$
// letters with tilde
#let tx = $tilde(x)$
#let ty = $tilde(y)$
#let tz = $tilde(z)$
#let ts = $tilde(s)$
#let tt = $tilde(t)$
#let tu = $tilde(u)$
#let tv = $tilde(v)$
#let tw = $tilde(w)$
// #let ta = $tilde(a)$ // 'ta' used for tau
#let tb = $tilde(b)$
#let tc = $tilde(c)$
#let td = $tilde(d)$
#let te = $tilde(e)$
#let tf = $tilde(f)$
#let tg = $tilde(g)$
// #let th = $tilde(h)$ // 'th' used for theta
#let ti = $tilde(i)$
#let tj = $tilde(j)$
#let tk = $tilde(k)$
// letters with arrow
#let ax = $arrow(x)$
#let ay = $arrow(y)$
#let az = $arrow(z)$
// #let as = $arrow(s)$ // 'as' is a keyword
#let at = $arrow(t)$
#let au = $arrow(u)$
#let av = $arrow(v)$
#let aw = $arrow(w)$
#let aa = $arrow(a)$
#let ab = $arrow(b)$
#let ac = $arrow(c)$
#let ad = $arrow(d)$
#let ae = $arrow(e)$
#let af = $arrow(f)$
#let ag = $arrow(g)$
#let ah = $arrow(h)$
#let ai = $arrow(i)$
#let aj = $arrow(j)$
#let ak = $arrow(k)$

#let x1 = $x_1$
#let x2 = $x_2$
// #let xi = $x_i$ // 'xi' used for xi
#let xj = $x_j$
#let xn = $x_n$
#let xN = $x_N$
#let y1 = $y_1$
#let y2 = $y_2$
#let yi = $y_i$
#let yj = $y_j$
#let yn = $y_n$
#let yN = $y_N$
#let z1 = $z_1$
#let z2 = $z_2$
#let zi = $z_i$
#let zj = $z_j$
#let zn = $z_n$
#let zN = $z_N$
// #let s1 = $s_1$
// #let s2 = $s_2$
// #let sn = $s_n$
// #let sN = $s_N$
// #let t1 = $t_1$
// #let t2 = $t_2$
// #let tn = $t_n$
// #let tN = $t_N$ // 's' and 't' used for sigma and tau
#let u1 = $u_1$
#let u2 = $u_2$
#let ui = $u_i$
#let uj = $u_j$
#let un = $u_n$
#let uN = $u_N$
#let v1 = $v_1$
#let v2 = $v_2$
#let vi = $v_i$
#let vj = $v_j$
#let vn = $v_n$
#let vN = $v_N$
#let w1 = $w_1$
#let w2 = $w_2$
#let wi = $w_i$
#let wj = $w_j$
#let wn = $w_n$
#let wN = $w_N$
// #let a1 = $a_1$
// #let a2 = $a_2$
// #let an = $a_n$
// #let aN = $a_N$ // 'a' used for alpha
#let b1 = $b_1$
#let b2 = $b_2$
// #let bi = $b_i$
// #let bj = $b_j$ // b is used for bold
#let bn = $b_n$
#let bN = $b_N$
#let c1 = $c_1$
#let c2 = $c_2$
#let ci = $c_i$
#let cj = $c_j$
#let cn = $c_n$
#let cN = $c_N$
// #let d1 = $d_1$
// #let d2 = $d_2$
// #let dn = $d_n$
// #let dN = $d_N$ // 'd' used for delta
#let e1 = $e_1$
#let e2 = $e_2$
#let ei = $e_i$
#let ej = $e_j$
#let en = $e_n$
#let eN = $e_N$
#let f1 = $f_1$
#let f2 = $f_2$
#let fi = $f_i$
#let fj = $f_j$
#let fn = $f_n$
#let fN = $f_N$
// #let g1 = $g_1$
// #let g2 = $g_2$
// #let gn = $g_n$
// #let gN = $g_N$ // 'g' used for gamma
#let h1 = $h_1$
#let h2 = $h_2$
#let hi = $h_i$
#let hj = $h_j$
#let hn = $h_n$
#let hN = $h_N$
#let i1 = $i_1$
#let i2 = $i_2$
#let ii = $i_i$
// #let ij = $i_j$ 'ij' used for i j with backspace between
// #let in = $i_n$ // 'in' is a keyword
#let iN = $i_N$
#let j1 = $j_1$
#let j2 = $j_2$
// #let ji = $j_i$ // 'ji' used for j i with backspace between
#let jj = $j_j$
#let jn = $j_n$
#let jN = $j_N$
#let k1 = $k_1$
#let k2 = $k_2$
#let ki = $k_i$
#let kj = $k_j$
#let kn = $k_n$
#let kN = $k_N$
