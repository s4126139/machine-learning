# Matrix Multiplication

## Vector dot products

For two vectors

$$
\mathbf{a}=
\begin{bmatrix}
1\\
2
\end{bmatrix},
\qquad
\mathbf{w}=
\begin{bmatrix}
3\\
4
\end{bmatrix},
$$

their dot product multiplies corresponding elements and adds the results:

$$
z
=
\mathbf{a}\cdot\mathbf{w}
=
(1)(3)+(2)(4)
=
3+8
=
11.
$$

More generally, the dot product of two vectors of the same length is

$$
\mathbf{a}\cdot\mathbf{w}
=
a_1w_1+a_2w_2+a_3w_3+\cdots.
$$

## Transposing a vector

The transpose turns a column vector into a row vector:

$$
\mathbf{a}=
\begin{bmatrix}
1\\
2
\end{bmatrix}
\quad\Longrightarrow\quad
\mathbf{a}^{T}=
\begin{bmatrix}
1 & 2
\end{bmatrix}.
$$

The dot product can then be written as a matrix product:

$$
z
=
\mathbf{a}^{T}\mathbf{w}
=
\begin{bmatrix}
1 & 2
\end{bmatrix}
\begin{bmatrix}
3\\
4
\end{bmatrix}
=11.
$$

Thus, $\mathbf{a}\cdot\mathbf{w}$ and $\mathbf{a}^{T}\mathbf{w}$ express the same computation.

## Multiplying a row vector by a matrix

Let

$$
W=
\begin{bmatrix}
3 & 5\\
4 & 6
\end{bmatrix}
=
\begin{bmatrix}
\vert & \vert\\
\mathbf{w}_1 & \mathbf{w}_2\\
\vert & \vert
\end{bmatrix}.
$$

To compute $Z=\mathbf{a}^{T}W$, take the dot product of $\mathbf{a}$ with each column of $W$:

$$
\begin{aligned}
Z_1
&=
\mathbf{a}^{T}\mathbf{w}_1
=(1)(3)+(2)(4)
=11,\\
Z_2
&=
\mathbf{a}^{T}\mathbf{w}_2
=(1)(5)+(2)(6)
=17.
\end{aligned}
$$

Therefore,

$$
Z=
\mathbf{a}^{T}W
=
\begin{bmatrix}
11 & 17
\end{bmatrix}.
$$

## Transposing a matrix

Let the columns of $A$ be two vectors:

$$
A=
\begin{bmatrix}
1 & -1\\
2 & -2
\end{bmatrix}
=
\begin{bmatrix}
\vert & \vert\\
\mathbf{a}_1 & \mathbf{a}_2\\
\vert & \vert
\end{bmatrix}.
$$

To form $A^T$, lay each column of $A$ on its side as a row:

$$
A^T=
\begin{bmatrix}
1 & 2\\
-1 & -2
\end{bmatrix}
=
\begin{bmatrix}
\mathbf{a}_1^T\\
\mathbf{a}_2^T
\end{bmatrix}.
$$

This column-to-row view is especially useful for understanding neural-network matrix operations.

## Multiplying two matrices

Using the same $W$, compute each row of $A^TW$ as a row-vector-by-matrix product.

The first row is:

$$
\mathbf{a}_1^TW=
\begin{bmatrix}
11 & 17
\end{bmatrix}.
$$

The second row is:

$$
\begin{aligned}
\mathbf{a}_2^T\mathbf{w}_1
&=(-1)(3)+(-2)(4)=-11,\\
\mathbf{a}_2^T\mathbf{w}_2
&=(-1)(5)+(-2)(6)=-17.
\end{aligned}
$$

So:

$$
A^TW=
\begin{bmatrix}
11 & 17\\
-11 & -17
\end{bmatrix}.
$$

Matrix multiplication is therefore a structured collection of vector dot products: each output element combines one row from the first matrix with one column from the second matrix.
