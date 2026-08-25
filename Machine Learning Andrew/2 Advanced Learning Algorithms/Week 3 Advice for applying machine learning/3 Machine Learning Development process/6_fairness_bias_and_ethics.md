# Fairness, Bias, and Ethics

## Why these issues matter

Machine learning systems affect billions of people. A system that affects people should be developed with deliberate attention to fairness, bias, and ethical impact. These concerns should be addressed before deployment rather than only after harm has occurred.

## Examples of unacceptable bias

Past systems have demonstrated serious failures:

- a hiring tool was shown to discriminate against women and was later withdrawn;
- face-recognition systems matched dark-skinned individuals to criminal mug shots more often than lighter-skinned individuals;
- bank-loan approval systems discriminated against subgroups; and
- algorithmic results can reinforce negative stereotypes, such as showing only certain kinds of people when users search for particular professions.

The goal is not merely to respond after a failure becomes public, but to avoid building and deploying such systems in the first place.

## Harmful uses of machine learning

Machine learning can also be applied in ways that are harmful regardless of model accuracy:

- creating fake videos without consent or disclosure;
- optimizing social-media engagement in ways that spread toxic or incendiary speech;
- generating fake product comments or political content with bots;
- building harmful products or committing fraud; and
- using learning algorithms for spam or other adversarial behavior.

The deepfake of former U.S. President Barack Obama discussed in the lesson was released with explicit disclosure and transparency. The ethical concern is using similar technology without consent or disclosure.

Just as spammers and anti-spam systems compete, fraudsters and fraud-prevention teams may both use machine learning. The lesson's direct guidance is not to build a system that negatively affects society and to walk away from work considered unethical. Financial benefit does not justify a project that makes the world worse.

## No simple ethics checklist

Ethics is a rich subject studied for thousands of years. There is no reliable five-item checklist that automatically makes a machine learning project ethical. The following practices are general guidance for making work fairer, less biased, and more ethical, especially before deploying a system capable of causing harm.

## 1. Assemble a diverse team and brainstorm harms

Bring together a team diverse across gender, ethnicity, culture, and other dimensions. Ask the team to identify:

- what might go wrong;
- who might be harmed; and
- which vulnerable groups could be affected.

A diverse team can collectively generate a wider range of failure scenarios, increasing the chance that a problem is recognized and corrected before deployment.

## 2. Research relevant standards and guidelines

Search the literature for standards or guidance specific to the industry and application. For example, the financial industry has emerging standards concerning whether a loan-approval system is reasonably fair and free from bias. Relevant standards can inform the design and evaluation of the system.

## 3. Audit identified dimensions before deployment

After training but before production deployment, measure the system against the possible harms identified during brainstorming.

If the team suspects that the model may be biased against particular genders, ethnicities, or other subgroups, evaluate performance for those groups. Identify and correct unacceptable disparities before release. This pre-deployment audit is a crucial line of defense.

## 4. Prepare mitigation and continue monitoring

Create a mitigation plan in advance. A simple option may be to roll back to an earlier system already known to be reasonably fair.

After deployment:

- monitor for harm;
- trigger the mitigation plan when a problem appears; and
- act quickly rather than inventing a response only after an incident.

Self-driving-car teams are used as an example: before vehicles were put on public roads, teams prepared plans for responding to an accident so that an established procedure could be executed immediately.

## Scale the scrutiny to the stakes

Projects vary in ethical impact. A neural network that selects coffee-bean roasting time has much smaller consequences than a system deciding which bank loans are approved. The latter can cause substantial harm if it is biased and therefore requires much greater scrutiny.

The central responsibility is to take ethics, fairness, and bias seriously: actively look for problems, measure them, fix them before they cause harm, and continue monitoring systems whose decisions affect people.
