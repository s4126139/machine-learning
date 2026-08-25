# Matrix Multiplication Rules

## Matrices as collections of vectors

Let $A$ be a $2\times3$ matrix. Its three columns can be viewed as vectors:

$$
A=
\begin{bmatrix}
\vert & \vert & \vert\\
\mathbf{a}_1 & \mathbf{a}_2 & \mathbf{a}_3\\
\vert & \vert & \vert
\end{bmatrix}.
$$

After transposing, those columns become the rows of $A^T$:

$$
A^T=
\begin{bmatrix}
\mathbf{a}_1^T\\
\mathbf{a}_2^T\\
\mathbf{a}_3^T
\end{bmatrix}.
$$

Thus, $A^T$ has shape $3\times2$.

Let $W$ be a $2\times4$ matrix whose four columns are

$$
W=
\begin{bmatrix}
\vert & \vert & \vert & \vert\\
\mathbf{w}_1 & \mathbf{w}_2 & \mathbf{w}_3 & \mathbf{w}_4\\
\vert & \vert & \vert & \vert
\end{bmatrix}.
$$

## Computing an output element

Define

$$
Z=A^TW.
$$

Every element $Z_{ij}$ is the dot product of:

- row $i$ of $A^T$, which is $\mathbf{a}_i^T$;
- column $j$ of $W$, which is $\mathbf{w}_j$.

Therefore,

$$
Z_{ij}=\mathbf{a}_i^T\mathbf{w}_j.
$$

The row chosen from the first matrix determines the output row; the column chosen from the second matrix determines the output column.

## Worked output entries

### Row 1, column 1

Using

$$
\mathbf{a}_1=
\begin{bmatrix}
1\\
2
\end{bmatrix},
\qquad
\mathbf{w}_1=
\begin{bmatrix}
3\\
4
\end{bmatrix},
$$

the upper-left entry is

$$
Z_{11}
=
\mathbf{a}_1^T\mathbf{w}_1
=(1)(3)+(2)(4)
=11.
$$

### Row 3, column 2

Using

$$
\mathbf{a}_3=
\begin{bmatrix}
0.1\\
0.2
\end{bmatrix},
\qquad
\mathbf{w}_2=
\begin{bmatrix}
5\\
6
\end{bmatrix},
$$

the entry is

$$
Z_{32}
=(0.1)(5)+(0.2)(6)
=0.5+1.2
=1.7.
$$

### Row 2, column 3

Using

$$
\mathbf{a}_2=
\begin{bmatrix}
-1\\
-2
\end{bmatrix},
\qquad
\mathbf{w}_3=
\begin{bmatrix}
7\\
8
\end{bmatrix},
$$

the entry is

$$
Z_{23}
=(-1)(7)+(-2)(8)
=-7-16
=-23.
$$

Repeating this row-column dot product for every position fills the complete output matrix.

## Dimension compatibility rule

The product $A^TW$ is valid because:

$$
A^T:\;3\times2,
\qquad
W:\;2\times4.
$$

The inner dimensions match:

$$
\boxed{2=2}.
$$

This is required because each output element is a dot product, and a dot product can only be taken between vectors of the same length.

In general:

$$
(m\times n)(n\times p)\longrightarrow(m\times p).
$$

The product has:

- the same number of rows as the first matrix;
- the same number of columns as the second matrix.

Therefore,

$$
(3\times2)(2\times4)\longrightarrow(3\times4),
$$

so $Z=A^TW$ is a $3\times4$ matrix containing 12 values.

Matrix multiplication may look more involved than individual dot products, but it is precisely a collection of those dot products arranged according to these row, column, and dimension rules.
