from os import name
import numpy as np
import matplotlib.pyplot as plt
from numpy.core.defchararray import array

"""The function defined in the homework PDF 2.2

The function is regarded as the line minimization, \
    so I treat the direction from x- to x+ (the direction of X axis) as the direction determination,\
        if it is in the real optimization problem, the direction should be set according to the Direction determination in the PPT 

Args:
    x: the input x value

return:
    the value of the function 
"""
def minfx(x):
    if x<2 :
        return -(2-(x-3)**2)  # take care don't forget the minus -
    if (x>=2)and(x<=4.5):
        return -(2-x/2)
    if x>4.5 :
        return -(2-(x-3)**2)


"""The manipulation of Golden search

Following the indication on the PPT

Args:
    iter: it is the max iteration times
    a0: the initial value of a
    d0: the initial value of d

return:
    x_values: the list of x(a,b,c,d) in every iteration 
    func_values: the list of the func value(f(a),f(b),f(c),f(d)) in every iteration  
    func_mins: list of the minimum of the function during the iterations
    x_mins: list of the xvalue of the minimum during the iterations
"""
def GoldenSearch(a0,d0,iter=5):
    lamda = (np.sqrt(5)-1)/2
    x_values = []
    func_values = []
    func_mins = []
    x_mins = []
    a = a0
    d = d0
    b = lamda*a + (1-lamda)*d
    c = (1-lamda)*a + lamda*d  # the first update 
    
    x_value = [a,b,c,d]
    x_values.append(x_value)
    
    func_value = [minfx(a),minfx(b),minfx(c),minfx(d)]
    func_values.append(func_value)
    
    func_mins.append(min(func_value))  # the minimum of the function during the iterations
    x_mins.append(x_value[func_value.index(min(func_value))])  # the xvalue of the minimum during the iterations

    
    for _ in range(iter):
        
        if minfx(b)>minfx(c): 
            a = b
            d = d
            b = lamda*a + (1-lamda)*d
            c = (1-lamda)*a + lamda*d
        
        if minfx(b)<=minfx(c):
            a = a
            d = c
            b = lamda*a + (1-lamda)*d
            c = (1-lamda)*a + lamda*d  # update the a,b,c,d
        
        x_value = [a,b,c,d]
        x_values.append(x_value)
        
        func_value = [minfx(a),minfx(b),minfx(c),minfx(d)]
        func_values.append(func_value)
        
        func_mins.append(min(func_value))
        x_mins.append(x_value[func_value.index(min(func_value))])
    
    x_test = np.arange(0,8,0.01)
    y_test = []
    for x in x_test:
        y_test.append(minfx(x))
    plt.plot(x_test,y_test)
    plt.scatter(x_mins,func_mins)
    plt.title("Iteration of Golden Search")
    plt.show()
    
    return x_values,func_values,func_mins,x_mins

"""The classic Fibonacci calculation
"""
def FibCalculate(n):
    n0 = 0
    n1 = 1
    nth = 0
    if (n==0):
        return n0
    if (n==1):
        return n1
    else:
        for i in range(n-1):
            nth = n0 + n1
            n0 = n1
            n1 = nth
    return nth

"""Calculate the n for the iteration  times

For details ,see the PPT or PDF P34

Args:
    epsilon: it is the error to calculate the iteration times n
    a0: the initial value of a
    d0: the initial value of d

return:
    the iteration times
"""

def CalculateN(a0,d0,epsilon):
    n = 2
    while(FibCalculate(n) < (d0-a0)/epsilon):
        n += 1  # count begins from 2
    return n


"""The manipulation of Fibonacci method

Following the indication on the PPT, calculate the iteration times n by the error epsilon

Args:
    epsilon: it is the error to calculate the iteration times n
    a0: the initial value of a
    d0: the initial value of d

return:
    x_values: the list of x(a,b,c,d) in every iteration 
    func_values: the list of the func value(f(a),f(b),f(c),f(d)) in every iteration  
    func_mins: list of the minimum of the function during the iterations
    x_mins: list of the xvalue of the minimum during the iterations
"""
def FibonacciMethod(a0,d0,epsilon):
    
    iter = CalculateN(a0,d0,epsilon)  # calculate the iteration times
    lamda = FibCalculate(iter)/FibCalculate(iter+1)  
    x_values = []
    func_values = []
    func_mins = []
    x_mins = []
    a = a0
    d = d0
    b = lamda*a + (1-lamda)*d
    c = (1-lamda)*a + lamda*d  # the first update 
    
    x_value = [a,b,c,d]
    x_values.append(x_value)
    
    func_value = [minfx(a),minfx(b),minfx(c),minfx(d)]
    func_values.append(func_value)
    
    func_mins.append(min(func_value))  # the minimum of the function during the iterations
    x_mins.append(x_value[func_value.index(min(func_value))])  # the xvalue of the minimum during the iterations

    
    for n in range(1,iter-1):
        
        lamda = FibCalculate(iter-n)/FibCalculate(iter+1-n)  # calculate the lamda for every iteration 
        if minfx(b)>minfx(c): 
            a = b
            d = d
            b = lamda*a + (1-lamda)*d
            c = (1-lamda)*a + lamda*d
        
        if minfx(b)<=minfx(c):
            a = a
            d = c
            b = lamda*a + (1-lamda)*d
            c = (1-lamda)*a + lamda*d  # update the a,b,c,d
        
        x_value = [a,b,c,d]
        x_values.append(x_value)
        
        func_value = [minfx(a),minfx(b),minfx(c),minfx(d)]
        func_values.append(func_value)
        
        func_mins.append(min(func_value))
        x_mins.append(x_value[func_value.index(min(func_value))])
    
    x_test = np.arange(0,8,0.01)
    y_test = []
    for x in x_test:
        y_test.append(minfx(x))
    plt.plot(x_test,y_test)
    plt.scatter(x_mins,func_mins)
    plt.title("Iteration of Fibonacci method")
    plt.show()
    
    return x_values,func_values,func_mins,x_mins

"""The manipulation of fixed step search

Following the indication on the PPT, the detax is set as 2  

Args:
    x0: the start value of x
    x1: the stop value of x
    detaX: the fixed step

return:
    x_values: the list of x in every iteration 
    func_values: the list of the func value(f(x)) in every iteration  
"""
def FixedStep(x0,x1,detaX=2):
    l = 0  # set the l according to the PPT  
    x_values = []
    func_values = []
    while(minfx(x0+l*detaX)>minfx(x0+(l+1)*detaX)):
        x_values.append(x0+l*detaX)
        func_values.append(minfx(x0+l*detaX))
        l += 1
        if x0+l*detaX>x1:
            break

    x_values.append(x0+l*detaX)
    func_values.append(minfx(x0+l*detaX))
     
    x_test = np.arange(0,8,0.01)  # plot the iteration 
    y_test = []
    for x in x_test:
        y_test.append(minfx(x))
    plt.plot(x_test,y_test)
    plt.scatter(x_values,func_values)
    plt.title("Iteration of fix steps method")
    plt.show()
    
    return l,x_values,func_values
    


if __name__=="__main__":

    x_values,func_values,func_mins,x_mins = GoldenSearch(0,8,5)
    print(x_values)
    print(func_values)
    print(func_mins)
    print(x_mins)

    x_values,func_values,func_mins,x_mins = FibonacciMethod(0,8,0.1)
    print(x_values)
    print(func_values)
    print(func_mins)
    print(x_mins)
    
    l,x_values,func_values = FixedStep(0,8)
    print(l)
    print(x_values)
    print(func_values)