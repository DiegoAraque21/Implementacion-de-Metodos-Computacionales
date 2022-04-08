
"""
Diego Araque
"""

def factorial(n):
	""""Return the factorial of n computed using recursion"""
	return 1 if n == 0 else n*factorial(n-1)	


def main():
	"""Program to start"""
	n=int(input("Enter a number: "))
	print(f"The factorial of {n} is {factorial(n)}")



main()