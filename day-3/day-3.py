
"""
it feels like cheating to use python so to make it fun its a DFA
"""
states = ['m', 'u', 'l', '(', 'digit1', 'digit2']
state = 0
digit = 0
num1 = 0
num2 = 0

def reset():
    state = 0
    num1 = 0
    num2 = 0

stop = 0

if __name__ == "__main__":
    sum = 0
    with open("input.txt", 'r') as file:
        line = file.read()
        for c in line:
            stop += 1
            if stop == 30:
                exit(0)
            print(c + "   " + str(state))
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
                else:
                    reset()
            elif state == 5: # else also works
                if c.isnumeric() and digit < 3:
                    digit += 1 
                    num2 *= 10
                    num2 += int(c)
                elif c == ')':
                    print(num1)
                    reset()
                else:
                    reset()


