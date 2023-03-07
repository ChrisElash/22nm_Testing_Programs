#! /usr/bin/python
############################################################
'''
Created by Christopher Elash in September 2021

This test program is meant for the 22nm FDSOI test chip and will test the chips 
SRAM .

Please read any further documentation provided with this code to gain a better of understanding of how it works.
Also ensure that the FPGA and testboard are properly set up before running this test.
'''
############################################################

CLOCK_PERIOD = 0.000001  # The period for the clocking of the system. Seems stable at 1 MHz

import time
import RPi.GPIO as GPIO
import sys

# Setup for all the GPIO pins

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BOARD) # use the actual pin number 
GPIO.setup(5, GPIO.OUT, initial=GPIO.HIGH) # reset pin, active low
GPIO.setup(11, GPIO.OUT, initial = GPIO.LOW) # the data pin to write test data to the FPGA
GPIO.setup(13, GPIO.OUT, initial = GPIO.LOW) # the data clk pin to drive the data to the FPGA
GPIO.setup(15, GPIO.OUT, initial = GPIO.HIGH) # the clear error signal for the test, active low
GPIO.setup(19, GPIO.IN) # the error flag for the SRAM check
GPIO.setup(23, GPIO.OUT, initial = GPIO.LOW) # the clk to get the data out from the SRAM Q port
GPIO.setup(29, GPIO.IN) # the data from the SRAM Q port



"""
Converts a binary numbary to an equivlant decimal.

n: a number in binary

Returns: nothing
"""  
def binaryToDecimal(n):
    return int(n,2)


"""
Takes in a number in seconds and outputs array of days, hours, minutes, and seconds

n: a number in seconds

Returns: array of days, hours, minutes, and seconds elapsed
"""  
def timeElapsed(seconds):
    time_elapsed = [0, 0, 0, 0]
    
    seconds_in_day = 60*60*24
    seconds_in_hour = 60*60
    seconds_in_minute = 60
    
    
    days = seconds // seconds_in_day
    hours = (seconds -  (days*seconds_in_day)) // seconds_in_hour
    minutes = (seconds - (days * seconds_in_day) - (hours*seconds_in_hour)) // seconds_in_minute
    seconds_remaining = int(seconds % 60)
    
    time_elapsed = [days, hours, minutes, seconds_remaining]
    return time_elapsed
                         



"""
Sends a clock pulse to the data line to FPGA

Returns: nothing
"""
def clockData():
    GPIO.output(13, GPIO.HIGH)
    time.sleep(CLOCK_PERIOD)
    GPIO.output(13, GPIO.LOW)
    time.sleep(CLOCK_PERIOD)



"""
Sends a clock pulse to the sram data out clk

Returns: nothing
"""
def clockDataSRAM():
    GPIO.output(23, GPIO.HIGH)
    time.sleep(CLOCK_PERIOD)
    GPIO.output(23, GPIO.LOW)
    time.sleep(CLOCK_PERIOD)



"""
Takes in an character and writes the equivlant bit to the FPGA via the data and data_clk lines

data: a string of length 1 that is either '0' or '1'

Returns: nothing
"""
def writeData(data):
    # start by loading data into the pin
    if (data == '0'):
        GPIO.output(11, GPIO.LOW)   # if input is 0, then go low
    elif (data == '1'): 
        GPIO.output(11, GPIO.HIGH)  # in input is 1, then go high

    # now clock the data in using the clock pin
    clockData()



"""
Returns the 8 bit data out Q from the SRAM at the current address location and the 8 bit data in

Returns: A list of the data bits found from both the sram output and input
"""
def getSRAMData():

    data_out = ''
    data_in = ''
    address = ''
    data = ['', '', 0]

    for i in range(8):
        clockDataSRAM() # clock the next bit in
        if (GPIO.input(29)):
            data_out = '1' + data_out
        else:
            data_out = '0' + data_out

    for i in range(8):
        clockDataSRAM() # clock the next bit in
        if (GPIO.input(29)):
            data_in = '1' + data_in
        else:
            data_in = '0' + data_in
            
    for i in range(15):
        clockDataSRAM()
        if (GPIO.input(29)):
            address = '1' + address
        else:
            address = '0' + address
            
    address_num = binaryToDecimal(address)

    data[0] = data_out
    data[1] = data_in
    data[2] = address_num

    return data



if __name__ == '__main__':

    # open up files to save the test data with start time in name
    StartTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
    StartTime_File = str(StartTime).replace(':','-')
    sram_file = open("/home/pi/Desktop/%s-SRAM_Test.txt" %(StartTime_File),"w")
    
    
    time_elapsed_start = time.time()
    


    
    GPIO.setwarnings(False)
    time.sleep(0.5)
    print("         _____ _____            __  __        ")
    print("        / ____|  __ \     /\   |  \/  |       ")
    print("       | (___ | |__) |   /  \  | \  / |       ")
    print("        \___ \|  _  /   / /\ \ | |\/| |       ")
    print("        ____) | | \ \  / ____ \| |  | |       ")
    print("  _____|_____/|_| _\_\/_/____\_\_|__|_|_____  ")
    print(" |__   __|  ____|/ ____|__   __|  ____|  __ \ ")
    print("    | |  | |__  | (___    | |  | |__  | |__) |")
    print("    | |  |  __|  \___ \   | |  |  __| |  _  / ")
    print("    | |  | |____ ____) |  | |  | |____| | \ \ ")
    print("    |_|  |______|_____/   |_|  |______|_|  \_\\")
    print("                                                          ")
    print("                                                          ")
    time.sleep(0.5)
    print("Welcome to the 22nm FDSOI SRAM Tester\n")
    print ("Press 'CTRL+C' when done testing to terminate")
    time.sleep(0.5)
    print("Beginning to read data from text file...")


    # get data from the text file
    with open('SRAM_Test_Data.txt') as file:
        file_data = file.readlines()
    # strip data of new line characters ("\n")
    file_data = [x.strip() for x in file_data]

    # data is now an array of each line from the file, but we only care about indexes 5, 10, 13, 16, 21, 24, 27

    # get input data for D[7:0]
    data = file_data[5]

    # get start address
    start_address = file_data[10] + file_data[13] + file_data[16]   

    # get end address
    end_address = file_data[21] + file_data[24] + file_data[27]   

    time.sleep(0.5) # allow pause before writing data 

    print("Now attempting to write data " + data + " to address locations " + str(int(start_address,2)) + " through " + str(int(end_address,2)))
    data_string_write = "Now attempting to write data " + data + " to address locations " + str(int(start_address,2)) + " through " + str(int(end_address,2)) + "\n"
    sram_file.write(data_string_write)

    # now reset the system to clear any data currently there
    GPIO.output(5, GPIO.LOW)
    clockData() # clock the reset in
    GPIO.output(5, GPIO.HIGH)

    # send data D for sram
    for element in data:
        writeData(element)

    # send start address
    for element in start_address:
        writeData(element)

    # send end address
    for element in end_address:
        writeData(element)


    # now perform two more clocks to load all data to appropriate registers and to begin looping through address
    clockData()
    clockData()

    # total addresses being checked is 
    total_address = int(end_address, 2) - int(start_address, 2) + 1

    # now begin writing the test data to all address locations
    # since the addresses are looping through with the test data, just set rdwen to write for 0.1 seconds 
    # at 1 mhz will take 0.032767 seconds to write to all address locations

    GPIO.output(15, GPIO.LOW)
    time.sleep(CLOCK_PERIOD)
    GPIO.output(15, GPIO.HIGH) # now change back to read mode

    time.sleep(0.5)

    #show the local time
    StartTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
    print("The beginning time: ", StartTime)
    data_string_write = "The beginning time: " + StartTime + "\n"
    sram_file.write(data_string_write)

    time.sleep(0.5)
    print("Total errors since beginning of test: 0")
    print("Waiting for Single Event Upset...")

    # begin testing loop, terminated by user presing CTRL+C
    total_errors = 0
    while True:
        try:
            if (GPIO.input(19)):    # an error was found so capture it and rewrite the test data
                total_errors = total_errors + 1 # increase errors by one
                data_found = getSRAMData()

                CurrentTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
                data_string_print = CurrentTime + " Error found at address location "  + str(data_found[2]) + " with output data " + data_found[0] + " and input data " + data_found[1] 
                data_string_write = CurrentTime + " Error found at address location "  + str(data_found[2]) + " with output data " + data_found[0] + " and input data " + data_found[1] + "\n"
                print(data_string_print)
                sram_file.write(data_string_write)
                
                # now print total errors
                CurrentTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
                data_string_print = CurrentTime + " Total errors found since beginning of test: " + str(total_errors) 
                data_string_write = CurrentTime + " Total errors found since beginning of test: " + str(total_errors) + "\n"
                print(data_string_print)
                sram_file.write(data_string_write)

                # now clear the error
                GPIO.output(15, GPIO.LOW)
                time.sleep(CLOCK_PERIOD*2)
                GPIO.output(15, GPIO.HIGH)

                # now wait for next error to occur
                time_elapsed_now = time.time() - time_elapsed_start
                elapsed = timeElapsed(time_elapsed_now)
                CurrentTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
                data_string_print = CurrentTime + " Time Elapsed: " + str(elapsed[0]) + "d " + str(elapsed[1]) + "h " + str(elapsed[2]) + "m " + str(elapsed[3]) + "s"
                print(data_string_print)
                CurrentTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
                data_string_print = CurrentTime + " Waiting for single event upset... \n"
                print(data_string_print)
                
        except KeyboardInterrupt:   # if user presses CTRL+C end the testing
            print("Ending Testing")
            sram_file.close()
            sys.exit()
