from tensorflow.keras.activations import relu, linear
from tensorflow.keras.layers import Dense
from tensorflow.keras.optimizers import Adam

import numpy as np

def _shape_as_list(shape):
    """Support TensorShape and tuple shapes across TensorFlow/Keras versions."""
    return shape.as_list() if hasattr(shape, "as_list") else list(shape)


def test_network(target):
    expected_units = [64, 64, 4]
    expected_activations = [relu, relu, linear]
    assert len(target.layers) == len(expected_units), (
        f"Wrong number of layers. Expected 3 but got {len(target.layers)}"
    )

    for i, (layer, units, activation) in enumerate(
        zip(target.layers, expected_units, expected_activations)
    ):
        assert type(layer) is Dense, (
            f"Wrong type in layer {i}. Expected {Dense} but got {type(layer)}"
        )
        assert layer.units == units, (
            f"Wrong number of units in layer {i}. Expected {units} but got {layer.units}"
        )
        assert layer.activation == activation, (
            f"Wrong activation in layer {i}. Expected {activation} but got {layer.activation}"
        )

    output = target(np.zeros((1, 8), dtype=np.float32))
    assert tuple(output.shape) == (1, 4), (
        f"Wrong network input/output dimensions. Expected (1, 4), got {tuple(output.shape)}"
    )
    print("\033[92mAll tests passed!")

def test_optimizer(target, ALPHA):
    assert type(target) == Adam, f"Wrong optimizer. Expected: {Adam}, got: {target}"
    assert np.isclose(target.learning_rate.numpy(), ALPHA), f"Wrong alpha. Expected: {ALPHA}, got: {target.learning_rate.numpy()}"
    print("\033[92mAll tests passed!")


def test_compute_loss(target):
    num_actions = 4
    def target_q_network_random(inputs):
        return np.float32(np.random.rand(inputs.shape[0],num_actions))

    def q_network_random(inputs):
        return np.float32(np.random.rand(inputs.shape[0],num_actions))

    def target_q_network_ones(inputs):
        return np.float32(np.ones((inputs.shape[0], num_actions)))

    def q_network_ones(inputs):
        return np.float32(np.ones((inputs.shape[0], num_actions)))

    np.random.seed(1)
    states = np.float32(np.random.rand(64, 8))
    actions = np.float32(np.floor(np.random.uniform(0, 1, (64, )) * 4))
    rewards = np.float32(np.random.rand(64, ))
    next_states = np.float32(np.random.rand(64, 8))
    done_vals = np.float32((np.random.uniform(0, 1, size=(64,)) > 0.96) * 1)

    loss = target((states, actions, rewards, next_states, done_vals), 0.995, q_network_random, target_q_network_random)


    assert np.isclose(loss, 0.6991737), f"Wrong value. Expected {0.6991737}, got {loss}"

    # Test when episode terminates
    done_vals = np.float32(np.ones((64,)))
    loss = target((states, actions, rewards, next_states, done_vals), 0.995, q_network_ones, target_q_network_ones)
    assert np.isclose(loss, 0.343270182), f"Wrong value. Expected {0.343270182}, got {loss}"

    # Test MSE with parameters A = B
    done_vals = np.float32((np.random.uniform(0, 1, size=(64,)) > 0.96) * 1)
    rewards = np.float32(np.ones((64, )))
    loss = target((states, actions, rewards, next_states, done_vals), 0, q_network_ones, target_q_network_ones)
    assert np.isclose(loss, 0), f"Wrong value. Expected {0}, got {loss}"

    # Test MSE with parameters A = 0 and B = 1
    done_vals = np.float32((np.random.uniform(0, 1, size=(64,)) > 0.96) * 1)
    rewards = np.float32(np.zeros((64, )))
    loss = target((states, actions, rewards, next_states, done_vals), 0, q_network_ones, target_q_network_ones)
    assert np.isclose(loss, 1), f"Wrong value. Expected {1}, got {loss}"

    print("\033[92mAll tests passed!")
