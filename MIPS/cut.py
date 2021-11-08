if __name__ == '__main__':
    with open(r"egg.asm", 'r') as file_in:
        lines = file_in.readlines()
        file_out = open(r"hex.txt", 'w')
        for line in lines:
            if len(line) < 1:
                continue
            if line[0] != ' ':
                continue
            file_out.write(line[16:24] + '\n')

        file_out.close()
