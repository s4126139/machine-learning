# The Iterative Loop of Machine Learning Development

## Development is an iterative process

A machine learning model almost never performs as well as desired on its first training run. Development therefore proceeds through a repeated loop:

1. **Choose the system architecture.**
   - Select the machine learning model.
   - Decide what data to use.
   - Choose hyperparameters and related design choices.
2. **Implement and train the model.**
3. **Run diagnostics.**
   - Analyze bias and variance.
   - Perform error analysis.
4. **Use the diagnostic evidence to revise the architecture.**
   - Enlarge the neural network.
   - Change the regularization parameter $\lambda$.
   - Add more data.
   - Add or remove features.
5. **Train and evaluate again.**

Several passes through this loop are usually required before the system reaches the desired performance.

## Example: email spam classification

The goal is to classify each email as spam or non-spam using supervised learning:

- input $\mathbf{x}$: features computed from an email;
- target $y\in\{0,1\}$: whether the email is spam.

Because the input is an email document, this is a text-classification problem. Spam may contain phrases such as “deal of the week” or offers for watches, medicines, and mortgages. Spammers may deliberately misspell words to confuse a recognizer, while legitimate email contains ordinary personal communication.

## Constructing email features

One approach is to choose the 10,000 most common words from a language or another dictionary and define

$$
\mathbf{x}=(x_1,x_2,\ldots,x_{10{,}000}).
$$

Each feature corresponds to one dictionary word. Two feature definitions discussed in the lesson are:

- **Binary presence:** $x_j=1$ if word $j$ appears in the email and $0$ otherwise.
- **Word count:** $x_j$ equals the number of times word $j$ appears.

The binary representation already works reasonably well. Given these features, a classifier such as logistic regression or a neural network can learn to predict $y$.

## Possible improvements after the first model

If the initial classifier is not accurate enough, many ideas may be available:

### Collect more data

A large-scale “honeypot” can create fake email addresses and deliberately expose them to spammers. Messages sent to those addresses are then known to be spam and provide additional labeled examples.

### Improve email-routing features

Email headers record the sequence of servers and networks through which a message traveled. An unusual route can contain useful evidence that the sender is a spammer.

### Improve body-text features

- Treat related word forms such as “discount” and “discounting” more intelligently instead of as entirely separate words.
- Detect deliberate misspellings of words such as watches, medicine, or mortgage.

## Use diagnostics to prioritize

The main challenge is not generating ideas but selecting the promising ones. A good choice can make development dramatically faster.

- Bias–variance analysis indicates whether collecting more data is likely to help. A costly honeypot project is less promising for a high-bias model, but could help substantially when variance is high.
- Error analysis identifies the kinds of examples on which the model fails and can show which data or feature changes would address the most errors.

The development loop therefore uses evidence from diagnostics to choose the next modification to the model, data, or feature representation instead of pursuing every plausible idea.
