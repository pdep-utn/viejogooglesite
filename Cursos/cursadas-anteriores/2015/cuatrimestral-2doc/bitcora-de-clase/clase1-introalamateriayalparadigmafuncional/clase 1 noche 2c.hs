doble x = x + x
modulo x
 | x > 0 = x
 | x == 0 = 0
 | otherwise = -x

fibo 0 = 0
fibo 1 = 1
fibo x 
 | x > 1 = fibo (x-1) + fibo (x-2)