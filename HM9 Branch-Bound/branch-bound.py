from Binary_Tree import BTree
from queue import Queue,LifoQueue,PriorityQueue

def branch_bound():
    """the branch-and-bound algorithm to solve the problem of HM9

    using the binary tree as the decision making, will form the tree
    """
    tree = BTree(data={'k':0,'u':-1,'J_pre':'origin','J_result':-1})  # initialize the tree, the left is 0, while the right is 1
    J_best = 0.7  # initialize the best value J_best as +infinity or choose one feasible solution
    Q_nodes = Queue(maxsize=0)  # initialize the queue 
    # the data structure of a node: 
    # k, the kth decision, the height of the tree;
    # u, the decision 0 or 1 
    # J_pre, the predicted minimum; 
    # J_result, if the node is the leaf, it is the result output of the node 
    # initialize the Q_nodes, the left is 0, the right is the 1 
    
    # initialize the 1th decision branches
    ini_left = BTree(data={'k':1,'u':0,'J_pre':0,'J_result':-1})
    tree.left = ini_left
    ini_left.parent = tree
    if( (J_pre(ini_left)).data['J_pre'] < J_best ):
        Q_nodes.put(ini_left)  
    
    ini_right = BTree(data={'k':1,'u':1,'J_pre':0,'J_result':-1})
    tree.right = ini_right
    ini_right.parent = tree
    if( (J_pre(ini_right)).data['J_pre'] < J_best ):
        Q_nodes.put(ini_right)
    
    J_bests = []  # store the best value
    while(not(Q_nodes.empty())):
        node = Q_nodes.get()  # get a node
        #node = J_pre(node)  # calculate the node's predicted J
        if node.data['J_result'] != -1:
            if node.data['J_result'] < J_best:
                J_best = node.data['J_result']
                J_bests.append(J_best)
        else:
            ini_left = BTree(data={'k':node.data['k']+1,'u':0,'J_pre':0,'J_result':-1})
            node.left = ini_left
            ini_left.parent = node
            if( (J_pre(ini_left)).data['J_pre'] < J_best ):
                Q_nodes.put(ini_left) 
            
            ini_right = BTree(data={'k':node.data['k']+1,'u':1,'J_pre':0,'J_result':-1})
            node.right = ini_right
            ini_right.parent = node
            if( (J_pre(ini_right)).data['J_pre'] < J_best ):
                Q_nodes.put(ini_right)
    
    print("the optima: ",min(J_bests))
    return tree



def J_pre(J_node):
    """the prediction function to calculate the predicted value of the node
    
    args:
        J_node(class BTree, Jnode.data = dictionary {'k':1,'u':0,'J_pre':0,'J_result':-1}): the information of the node
    returns:
        J_node(class BTree): with the predicted output Jnode.data['J_pre']
    """
    y_n = 0.5
    
    if(J_node.data['k']==1):

        # calculate j1 according to the u
        y_n1 = 0.9 * y_n + 0.1 * J_node.data['u']  
        j_1 = (y_n1 - 1)**2 + 0.01 * J_node.data['u']**2
        
        # calculate j2,j3 according to the quadratic optimization 
        u_n1 = 5 - 4.5 * y_n1
        y_n2 = 0.5 + 0.45 * y_n1
        j_2 = (y_n2 - 1)**2 + 0.01 * u_n1**2

        u_n2 = 5 - 4.5 * y_n2 
        y_n3 = 0.5 + 0.45 * y_n2
        j_3 = (y_n3 - 1)**2 + 0.01 * u_n2**2
        J_node.data['J_pre'] = j_1 + j_2 + j_3
    
    if(J_node.data['k']==2):

        # get the u_n from the parent node of the J_node
        u_n = J_node.parent.data['u']
        y_n1 = 0.9 * y_n + 0.1 * u_n  
        j_1 = (y_n1 - 1)**2 + 0.01 * u_n**2

        # calculate j2 according to the u_n1 
        u_n1 = J_node.data['u']
        y_n2 = 0.9 * y_n1 + 0.1 * u_n1
        j_2 = (y_n2 - 1)**2 + 0.01 * u_n1**2

        # calculate j3 according to the quadratic optimization 
        u_n2 = 5 - 4.5 * y_n2 
        y_n3 = 0.5 + 0.45 * y_n2
        j_3 = (y_n3 - 1)**2 + 0.01 * u_n2**2
        J_node.data['J_pre'] = j_1 + j_2 + j_3

    if(J_node.data['k']==3):

        # get the u_n from the parent node of the J_node
        u_n = J_node.parent.parent.data['u']
        y_n1 = 0.9 * y_n + 0.1 * u_n  
        j_1 = (y_n1 - 1)**2 + 0.01 * u_n**2

        # calculate j2 according to the u_n1 
        u_n1 = J_node.parent.data['u']
        y_n2 = 0.9 * y_n1 + 0.1 * u_n1
        j_2 = (y_n2 - 1)**2 + 0.01 * u_n1**2

        # calculate j3 according to the u_n2
        u_n2 = J_node.data['u']
        y_n3 = 0.9 * y_n2 + 0.1 * u_n2
        j_3 = (y_n3 - 1)**2 + 0.01 * u_n2**2
        
        J_node.data['J_pre'] = j_1 + j_2 + j_3
        J_node.data['J_result'] = j_1 + j_2 + j_3

    return J_node

if __name__ == "__main__":
    tree = branch_bound()
    tree.print_tree('J_pre',save_path='./Binary_Tree.gv', label=True)