#for windows computer run using privilegies = bcdedit /set xsavedisable 0

import tensorflow as tf

print(dir(tf))
W = tf.variable_scope(tf.random_normal([1], -1.0, 1.0))
print('W is' + str(W))

tf.zeros()