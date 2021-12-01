from Binary_Tree import BTree
import numpy as np
from queue import Queue,LifoQueue,PriorityQueue

def branch_bound():
    """the branch-and-bound algorithm to solve the problem of HM9

    using the binary tree as the decision making, will form the tree
    """
    tree = BTree(0)  # initialize the tree, the left is 0, while the right is 1
    J_bset = np.inf  # initialize the best value J_best as +infinity 
    Q_nodes = Queue(maxsize=0)  # initialize the queue 
    # the data structure of a node: 
    # k, the kth decision;
    # u, the decision 0 or 1 
    # J_pre, the predicted minimum; 
    # J_result, if the node is the leaf, it is the result output of the node 
    # initialize the Q_nodes, the left is 0, the right is the 1 
    
    ini_left = {'k':1,'u':0,'J_pre':0,'J_result':-1}
    
    Q_nodes.put(ini_left) 
    ini_right = {'k':1,'u':1,'J_pre':0,'J_result':-1}
    
    Q_nodes.put(ini_right)
    tree.left = BTree()

    while(not(Q_nodes.empty())):
        pass
