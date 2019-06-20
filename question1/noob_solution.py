print 'Enter number of rows'
n = raw_input()

flag=1

for i in range(1, int(n)+1):
	if i == 1:
		print '*' * flag + '\n'
	elif i%2 == 0:
		flag += 2
		print '*' * flag + '\n'
	elif i%2 == 1:
		flag += 1
		print '*' * flag + '\n'