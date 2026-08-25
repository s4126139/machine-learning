# Deciding What to Try Next

## The practical challenge

Knowing many learning algorithms is not enough to build a successful machine learning system efficiently. The speed of development depends heavily on repeatedly making good decisions about what to do next. A skilled team may complete in weeks what another team spends months doing because it chooses more productive experiments.

Machine learning models also rarely work as well as desired on the first attempt. The central question is therefore not just how to train a model, but how to decide which change is most likely to improve it.

## Running example: housing-price prediction

Suppose a regularized linear regression model predicts housing prices using a cost of the form

$$
J(\mathbf{w},b)
=
\frac{1}{2m}\sum_{i=1}^{m}
\left(f_{\mathbf{w},b}(\mathbf{x}^{(i)})-y^{(i)}\right)^2
+
\frac{\lambda}{2m}\sum_{j=1}^{n}w_j^2.
$$

After training, its prediction errors are unacceptably large. Several next steps may appear reasonable:

| Possible next step | Motivation |
|---|---|
| Get more training examples | More data may help the model generalize. |
| Use a smaller feature set | There may be too many features. |
| Add new features | Additional properties of each house may provide useful information. |
| Add polynomial features | Existing inputs can be expanded with terms such as $x_1^2$, $x_2^2$, and $x_1x_2$. |
| Decrease $\lambda$ | The current regularization may be too strong. |
| Increase $\lambda$ | The current regularization may be too weak. |

Some of these actions will be fruitful for a particular application and others will not. More training data, for example, can help greatly in some situations but may accomplish very little in others. Collecting it can take weeks or months, so choosing without evidence can waste substantial effort.

## Diagnostics guide the choice

A **diagnostic** is a test that provides insight into what is or is not working in a learning algorithm and therefore gives guidance on how to improve its performance.

A useful diagnostic can answer a high-impact question such as whether collecting more training data is worth the time:

- If the diagnostic indicates that more data is likely to help, the team can make that investment with a clear reason.
- If it indicates that more data is unlikely to help, the diagnostic may save months of unnecessary work.

Diagnostics themselves take time to implement, but they are often an excellent use of development time because they help direct effort toward promising changes. A systematic evaluation of model performance is the foundation for the diagnostics developed in the following lessons.
