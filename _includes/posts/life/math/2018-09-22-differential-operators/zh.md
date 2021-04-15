## 【公式】

$$
\begin{align*}

  &设 \; D = \dfrac{d}{dx}, \; 则 \; y^\prime = D y, \; y^{\prime \prime} = D^2 y

  \\

  &( 1 )
  \begin{cases}
    F_{( D )} e^{kx} = F_{( k )} e^{kx}
    \\
    \dfrac{1}{F_{( D )}} e^{kx} = \dfrac{1}{F_{( k )}} e^{kx}
  \end{cases}

  \\

  &( 2 )
  \begin{cases}
    F_{( D^2 )} \sin ax = F_{( -a^2 )} \sin ax
    \\
    \dfrac{1}{F_{( D^2 )}} \sin ax = \dfrac{1}{F_{( -a^2 )}} \sin ax
  \end{cases}

  \\

  &( 3 )
  \begin{cases}
    F_{( D )} e^{kx} f_{( x )} = e^{kx} F_{( D + k )} f_{( x )}
    \\
    \dfrac{1}{F_{( D )}} e^{kx} f_{( x )} = e^{kx} \dfrac{1}{F_{( D + k )}} f_{( x )}
  \end{cases}

  \\

  &( 4 )
  \begin{cases}
    F_{( D )} f_{( x )} = F_{1 ( D )} F_{2 ( D )} f_{( x )} = F_{2 ( D )} F_{1 ( x )} f_{( x )}
    \\
    \dfrac{1}{F_{( D )}} f_{( x )} = \dfrac{1}{F_{1 ( D )} F_{2 ( D )}} f_{( x )} = \dfrac{1}{F_{2 ( D )} F_{1 ( x )}} f_{( x )}
  \end{cases}
\end{align*}

$$

>【注】
> 1. 分母均不为0
> 2. 算子式和方程式没有乘法交换律，算子式和算子式有乘法交换律
> 3. 当（1）式的分母为0时，可用（3）式，此时f(x)=1
> 4. （4）式中 F(D) = F1(D) * F2(D)

## 【题型】

### 型一

$$
F_{( D )} y = f_{( x )} \; => \; y^* = \dfrac{1}{F_{( D )}} f_{( x )}
$$

### 型二

$$
F_{( D )} y = e^{\lambda x} f_{( x )} \; => \; y^* = \dfrac{1}{F_{( D )}} e^{\lambda x} f_{( x )} =
\begin{cases}
  \dfrac{1}{F_{( \lambda )}} e^{\lambda x} f_{( x )} & , \; F_{( \lambda )} \neq 0
  \\
  e^{\lambda x} \dfrac{1}{F_{( D + \lambda )}} f_{( x )} & , \; F_{( \lambda )} = 0
\end{cases}
$$

### 型三

$$
\begin{aligned}

  &( 1 )
  \begin{cases}
    F_{( D )} y = e^{\lambda x} f_{( x )} \sin ax
    \\
    F_{( D )} y = e^{\lambda x} f_{( x )} \cos ax
  \end{cases}

  \\

  &( 2 )
  利用欧拉公式：
  \begin{cases}
    e^{iax} = \cos ax + i \sin ax
    \\
    i = \sqrt{-1} \; 或 \; i^2 = -1
  \end{cases}

  \\

  &( 3 )
  令 \; F_{( D )} y = e^{( \lambda + ia ) x} f_{( x )} \; => \; y = e^{( \lambda + ia ) x} \dfrac{1}{F_{( D + \lambda + ia )}} f_{( x )}

  \\

  &( 4 )
  算出 \; y \; 后将欧拉公式回代，可得到带有（虚部）和（实部）的解

  \\

  &( 5 )
  \begin{cases}
    F_{( D )} y = e^{\lambda x} f_{( x )} \sin ax => 取（虚部）为特解 \; y^*
    \\
    F_{( D )} y = e^{\lambda x} f_{( x )} \cos ax => 取（实部）为特解 \; y^*
  \end{cases}

\end{aligned}
$$

>【注】
> 1. λ可以是0
> 2. 考研中出现的微分方程，一般就是这三种题型

### 例题

#### 型一、型二

![differential-operators.jpg](/img/in-post/post-differential-operators/differential-operators.jpg)
