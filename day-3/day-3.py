
"""
it feels like cheating to use python so to make it fun its a (optimized) DFA simulation

do() and don't() are checked using buffers
"""
states = ['m', 'u', 'l', '(', 'digit1', 'digit2']
state = 0
digit = 0
num1 = 0
num2 = 0

class Buffer:
    def __init__(self, size):
        self.size = size
        self.arr = ['0'] * size
    def push(self, x):
        for i in range(self.size-1):
            self.arr[self.size - i - 1] = self.arr[self.size - i - 2]
        self.arr[0] = x
    def check(self):
        buf = ''.join(list(reversed(self.arr)))
        if buf == "don't()":
            return 0

        buf = ''.join(list(reversed(self.arr[:4])))
        if buf == 'do()':
            return 1

        return -1


buffer = Buffer(7)

def reset():
    global state
    global digit
    global num1 
    global num2 
    state = 0
    digit = 0
    num1 = 0
    num2 = 0

stop = 0

if __name__ == "__main__":
    sum = 0
    skipsum = 0
    enable = 1
    with open("input.txt", 'r') as file:
        line = file.read()
        for c in line:
            buffer.push(c)
            if buffer.check() != -1:
                enable = buffer.check()
            #stop += 1
            #if stop == 45:
            #    exit(0)
            #print(c + "   " + str(state))
            if state < 4:
                if states[state] == c:
                    state += 1
                else:
                    reset()
            elif state == 4:
                if c.isnumeric() and digit < 3:
                    digit += 1
                    num1 *= 10
                    num1 += int(c)
                elif c == ',':
                    state += 1
                    digit = 0
                else:
                    reset()
            elif state == 5: # else also works
                if c.isnumeric() and digit < 3:
                    digit += 1 
                    num2 *= 10
                    num2 += int(c)
                elif c == ')':
                    sum += num1 * num2
                    skipsum += num1*num2* enable
                    reset()
                else:
                    reset()
    print(sum)
    print(skipsum)

