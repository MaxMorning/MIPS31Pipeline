import os

hex_path = r"./MIPS/HEX"
cpu_res_path = r"./MIPS/RES"
mars_res_path = r"./MIPS/MARSRES"
workspace_path = r"./MIPS/WORKSPACE"
work_path = r"../"

if __name__ == '__main__':
    os.chdir(work_path)
    # compile
    os.system(r'iverilog -o simulate.sml -y verilog tb/soc_tb.v')

    print("Compile Done!")
    file_names = os.listdir(hex_path)
    print(file_names)
    is_wrong = False
    for file_name in file_names:
        if file_name[-4:] == ".txt":
            print("Start Simulation in ", file_name)
            # copy instr
            with open(os.path.join(hex_path, file_name), 'r') as file_src:
                with open(os.path.join(workspace_path, "instr.txt"), 'w') as file_dst:
                    file_content = file_src.read()
                    file_dst.write(file_content)

            # start simulation
            os.system(r'simulate.sml')
            # os.system(r'quit -sim')
            # os.system(r'quit')

            # compare
            # is_wrong = false
            with open(os.path.join(workspace_path, "result.txt"), 'r') as file_result:
                with open(os.path.join(mars_res_path, file_name), 'r') as file_standard:
                    result = file_result.read()
                    standard = file_standard.read()

                    result = result.replace(' ', '')
                    result = result.replace('\n', '')

                    standard = standard.replace(' ', '')
                    standard = standard.replace('\n', '')

                    for index in range(len(standard)):
                        if standard[index] != result[index]:
                            print(file_name, " Wrong!")
                            is_wrong = True
                            break

            if is_wrong:
                break

    if not is_wrong:
        print("Congratulations!")
