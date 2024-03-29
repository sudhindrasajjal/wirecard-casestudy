import math

print 'Enter number of rows'
r = raw_input()

# Function to compute the nth number of the the Beatty Sequence. Source: http://oeis.org/A054385
def compute_row_count(n):
	return int(math.floor(n*math.exp(1) / (math.exp(1) - 1)))

for i in range(1,int(r)+1):
	print '*' * compute_row_count(i) + '\n'
