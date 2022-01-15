import numpy as np
import matplotlib.pyplot

np.set_printoptions(suppress=True)

# X, the current students
# U, the new students
# G, the graduated students

X_1 = [2800,2971,2940,2885,2855,2852,2863,2887]
U_1 = [1142,1106,1110,1125,1138,1156,1200,1125]
G_1 = [891,882,866,857,856,859,866,884]

X_2 = [900,776,729,704,686,668,656,661]
U_2 = [101,102,100,94,91,101,101,100]
G_2 = [372,350,338,329,321,315,317,319]

X_3 = [220,257,275,283,287,289,292,294]
U_3 = [41,39,38,38,41,41,40,42]
G_3 = [28,30,31,32,32,32,32,32]

len = 8

def matrix_calculate():
    """
    calculate the paramters of the matrix H and f in the optimization 
    """

    c11 = 0;c12 = 0;c13 = 0;c14 = 0;c15 = 0;c16 = 0;c17 = 0
    for i in range(len-1):
        c11 += ( -X_1[i]*X_1[i+1] + X_1[i]*X_2[i+1])
        c12 += (-X_1[i]*X_1[i+1])
        c13 += (-X_2[i]*X_2[i+1] + X_2[i]*X_3[i+1])
        c14 += (-X_2[i]*X_2[i+1])
        c15 += (X_2[i]*X_1[i+1] - X_2[i]*X_2[i+1])
        c16 += (-X_3[i]*X_3[i+1])
        c17 += (X_3[i]*X_2[i+1] - X_3[i]*X_3[i+1])
    C1 = [c11,c12,c13,c14,c15,c16,c17]
    C1 = (-1)*np.array(C1)
    print("C1:",C1)  # [ 44287308  58345332   2151107   3590336 -11240917    539440   -780683]

    c31 = 0;c32 = 0;c33 = 0;c34 = 0;c35 = 0;c36 = 0;c37 = 0
    for i in range(len-1):
        c31 += ( -1.87*X_1[i]**2 - 2*X_1[i]*(U_1[i]) + 2*X_1[i]*U_2[i])
        c32 += (-1.87*X_1[i]**2 - 2*X_1[i]*(U_1[i]))
        c33 += ( -2*U_2[i]*X_2[i] - 1.94*X_2[i]**2 + 2*(X_2[i]*U_3[i]) )
        c34 += (-2*U_2[i]*X_2[i] - 1.94*X_2[i]**2)
        c35 += (1.87*X_1[i]*X_2[i] + 2*X_2[i]*(U_1[i])-2*U_2[i]*X_2[i]-1.94*X_2[i]**2)
        c36 += (-2*X_3[i]*U_3[i] - 1.75*X_3[i]**2)
        c37 += (2*U_2[i]*X_3[i] - 2*X_3[i]*U_3[i] - 1.75*X_3[i]**2)

    np.set_printoptions(suppress=True,formatter={'float_kind':'{:.2f}'.format})
    C3 = [c31,c32,c33,c34,c35,c36,c37]
    C3 = np.array(C3)

    C = 2*C1 + C3
    print("C3:",C3)
    print("C",C)

    x1x1=0; x1x2=0; x1x3=0; x2x2=0; x2x3=0; x3x3=0
    for i in range(len-1):
        x1x1 += X_1[i]**2
        x1x2 += X_1[i]*X_2[i]
        x1x3 += X_1[i]*X_3[i]
        x2x2 += X_2[i]**2
        x2x3 += X_2[i]*X_3[i]
        x3x3 += X_3[i]**2

    h = [x1x1,x1x2,x1x3,x2x2,x2x3,x3x3]
    h = np.array(h)

    print(h)

#matrix_calculate()

def mean_calculate():
    """
    calculate the mean of the sum of parameters a1+a2, b1+b2+b4, c2+c4 
    """
    a1a2 = np.mean(np.array(G_1)/np.array(X_1))
    b1b2b4 = np.mean(np.array(G_2)/np.array(X_2))
    c2c4 = np.mean(np.array(G_3)/np.array(X_3))
    print(a1a2)
    print(b1b2b4)
    print(c2c4)
    b4 = []
    c4 = []
    for i in range(len-1):
        b4.append( (X_1[i+1] - X_1[i] - U_1[i] + G_1[i] + 0.065*X_1[i])/X_2[i] )
        c4.append( (X_2[i+1] - X_2[i] - U_2[i] + G_2[i] + 0.125*X_2[i])/X_3[i] )
    b4 = np.array(b4)
    c4 = np.array(c4)
    print("b4:",b4)
    print("c4:",c4)
    print(np.mean(b4))
    print(np.mean(c4))

#mean_calculate()

#matrix_calculate()

def simulation():
    """
    simulate the model given the initial point of the data of 2009 
    and the number of new students every year
    """
    y_simu = []
    y_gradu = []
    a1,a2,b1,b2,b4,c2,c4 = 0.0978,    0.2509,    0.1022,    0.3984,    0.0598,    0.2033,    0.0134

    B = np.array([[0.935-a1-a2, b4,           0,          1,0,0],
                  [a1,          0.97-b1-b2-b4,c4,         0,1,0],
                  [0,           b1,           0.875-c2-c4,0,0,1]])
    y_k_1 = np.array([[2800],[900],[220]])

    for i in range(len):
        u_k = np.array([ [U_1[i]], [U_2[i]], [U_3[i]]])
        y_k_1 = np.dot(B,np.vstack((y_k_1,u_k)))
        y_simu.append(y_k_1) 
        y_gradu.append(y_k_1*np.array([[a1+a2],
                                    [b1+b2+b4],
                                    [c2+c4]]) )
    print(np.hstack(y_simu).T)
    print(np.hstack(y_gradu).T)

simulation()